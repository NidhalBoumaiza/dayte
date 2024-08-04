import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/map_failure_to_message.dart';
import '../../../../authorisation/domain layer/entities/user_entity.dart';
import '../../../domain layer/usecases/get_recommendation_use_case.dart';

part 'date_event.dart';
part 'date_state.dart';

class DateBloc extends Bloc<DateEvent, DateState> {
  final GetRecommendationUseCase getRecommendationUseCase;

  DateBloc({required this.getRecommendationUseCase}) : super(DateInitial()) {
    on<DateEvent>((event, emit) {});
    on<GetRecommendationEvent>(_getRecommendation);
    on<changeIsLikeValue>(_changeIsLikeValue);
  }

  void _getRecommendation(
      GetRecommendationEvent event, Emitter<DateState> emit) async {
    emit(GetRecommendationLoading());
    final failureOrRecommendations =
        await getRecommendationUseCase(event.isShuffle);
    failureOrRecommendations.fold((failure) {
      if (failure is UnauthorizedFailure) {
        emit(GetRecommendationUnauthorized());
      } else if (failure is EndOfPlanFailure) {
        emit(EndOfPlanErreur(message: mapFailureToMessage(failure)));
      } else if (failure is ShuffleFailure) {
        emit(ShuffleErreur(message: mapFailureToMessage(failure)));
      } else {
        emit(GetRecommendationError(message: mapFailureToMessage(failure)));
      }
    }, (recommendations) {
      print(recommendations);
      recommendationsForShuffleErreur = recommendations;
      emit(GetRecommendationSuccess(recommendations: recommendations));
    });
  }

  void _changeIsLikeValue(
      changeIsLikeValue event, Emitter<DateState> emit) async {
    if (state is GetRecommendationSuccess) {
      final currentState = state as GetRecommendationSuccess;
      final updatedRecommendations = currentState.recommendations.map((user) {
        if (user.id == event.id) {
          user.isLiked = true;
        }
        return user;
      }).toList();

      emit(GetRecommendationSuccess(recommendations: updatedRecommendations));
    }
  }
}

late List<User> recommendationsForShuffleErreur;
