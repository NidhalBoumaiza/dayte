import 'package:bloc/bloc.dart';
import 'package:client/core/utils/map_failure_to_message.dart';
import 'package:client/features/dates/domain%20layer/entities/match_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain layer/usecases/get_user_matches.dart';

part 'get_matches_state.dart';

class GetMatchesCubit extends Cubit<GetMatchesState> {
  GetUserMatches getUserMatches;

  GetMatchesCubit({required this.getUserMatches}) : super(GetMatchesInitial());

  void getMatches() async {
    emit(GetMatchesLoading());
    final result = await getUserMatches();
    result.fold(
      (failure) {
        if (failure is UnauthorizedFailure) {
          emit(GetMatchesUnauthorized());
        } else {
          emit(GetMatchesErreur(mapFailureToMessage(failure)));
        }
      },
      (matches) => emit(GetMatchesSucess(matches)),
    );
  }
}
