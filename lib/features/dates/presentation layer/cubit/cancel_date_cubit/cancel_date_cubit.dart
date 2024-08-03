import 'package:bloc/bloc.dart';
import 'package:client/core/utils/map_failure_to_message.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/strings.dart';
import '../../../domain layer/usecases/cancel_date.dart';

part 'cancel_date_state.dart';

class CancelDateCubit extends Cubit<CancelDateState> {
  CancelDateUseCase cancelDateUseCase;

  CancelDateCubit({required this.cancelDateUseCase})
      : super(CancelDateInitial());

  void cancelDate(String dateId) async {
    emit(CancelDateLoading());
    final result = await cancelDateUseCase(dateId);
    result.fold(
      (failure) {
        if (failure is ServerMessageFailure) {
          emit(CancelDateErreur(mapFailureToMessage(failure)));
        } else if (failure is UnauthorizedFailure) {
          emit(CancelDateUnauthorised(mapFailureToMessage(failure)));
        } else if (failure is OfflineFailure) {
          emit(CancelDateNetworkErreur(OfflineFailureMessage));
        } else if (failure is EndOfPlanFailure) {
          emit(EndOfPlanErreur(mapFailureToMessage(failure)));
        } else {
          emit(CancelDateErreur('An error occurred'));
        }
      },
      (_) => emit(CancelDateSuccess()),
    );
  }
}
