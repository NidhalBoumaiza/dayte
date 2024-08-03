import 'package:bloc/bloc.dart';
import 'package:client/core/error/failures.dart';
import 'package:client/core/utils/map_failure_to_message.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain layer/usecases/change_password_use_case.dart';

part 'change_password__state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase changePasswordUseCase;

  ChangePasswordCubit({required this.changePasswordUseCase})
      : super(ChangePasswordInitial());

  void changePassword(
      String oldPassword, String newPassword, String confirmNewPassword) async {
    emit(ChangePasswordLoading());
    final result = await changePasswordUseCase.execute(
        oldPassword, newPassword, confirmNewPassword);
    result.fold(
      (failure) {
        if (failure is UnauthorizedFailure) {
          emit(ChangePasswordUnauthorized());
        } else if (failure is EndOfPlanFailure) {
          emit(EndOfPlanErreur(mapFailureToMessage(failure)));
        }
        else {
          emit(ChangePasswordError(mapFailureToMessage(failure)));
        }
      },
      (_) {
        emit(ChangePasswordSuccess());
      },
    );
  }
}
