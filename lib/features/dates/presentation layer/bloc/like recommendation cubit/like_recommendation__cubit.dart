import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/map_failure_to_message.dart';
import '../../../domain layer/usecases/like_recommendation_use_case.dart';

part 'like_recommendation__state.dart';

class LikeRecommendationCubit extends Cubit<LikeRecommendationState> {
  final LikeRecommendationUseCase likeRecommendationUseCase;

  LikeRecommendationCubit({required this.likeRecommendationUseCase})
      : super(LikeRecommendationInitial());

  Future<void> likeRecommendation(String userId) async {
    emit(LikeRecommendationLoading());
    final failureOrUnit = await likeRecommendationUseCase(userId);
    failureOrUnit.fold(
      (failure) {
        if (failure is UnauthorizedFailure) {
          emit(LikeRecommendationUnauthorized());
        } else {
          emit(LikeRecommendationError(message: mapFailureToMessage(failure)));
        }
      },
      (_) => emit(LikeRecommendationSuccess()),
    );
  }
}
