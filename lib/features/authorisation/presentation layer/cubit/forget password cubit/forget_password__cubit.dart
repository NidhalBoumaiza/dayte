import 'package:bloc/bloc.dart';
import 'package:client/core/error/failures.dart';
import 'package:client/core/utils/map_failure_to_message.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain layer/usecases/forgot_password_use_case.dart';
import '../../../domain layer/usecases/reset_password_use_case.dart';

part 'forget_password__state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase forgetPasswordUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  ForgetPasswordCubit(
      {required this.resetPasswordUseCase, required this.forgetPasswordUseCase})
      : super(ForgetPasswordInitial());

  void forgetPassword(String phoneNumber) async {
    emit(ForgetPasswordLoading());
    final result = await forgetPasswordUseCase(phoneNumber);
    result.fold(
      (failure) {
        if (failure is UnauthorizedFailure) {
          emit(ForgetPasswordUnauthorised());
        } else if (failure is EndOfPlanFailure) {
          emit(EndOfPlanErreur(mapFailureToMessage(failure)));
        } else {
          emit(ForgetPasswordErreur(mapFailureToMessage(failure)));
        }
      },
      (_) => emit(ForgetPasswordSuccess()),
    );
    emit(ForgetPasswordInitial());
  }

  void resetPassword(
      String phoneNumber, String password, String confirmPassword) async {
    emit(ResetPasswordLoading());
    final result =
        await resetPasswordUseCase(phoneNumber, password, confirmPassword);
    result.fold(
      (failure) {
        if (failure is UnauthorizedFailure) {
          emit(ResetPasswordUnauthorised());
        } else {
          emit(ResetPasswordErreur(mapFailureToMessage(failure)));
        }
      },
      (_) => emit(ResetPasswordSuccess()),
    );
    // emit(ForgetPasswordInitial());
  }
}
