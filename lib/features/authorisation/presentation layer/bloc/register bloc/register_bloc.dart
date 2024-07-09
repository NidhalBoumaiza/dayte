import 'package:bloc/bloc.dart';
import 'package:client/features/authorisation/domain%20layer/usecases/register_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/map_failure_to_message.dart';
import '../../../domain layer/entities/user_entity.dart';
import '../../../domain layer/usecases/finish_profile_use_case.dart';
import '../../../domain layer/usecases/login_with_phone_number_use_case.dart';
import '../../../domain layer/usecases/send_verification_code_use_case.dart';
import '../../../domain layer/usecases/verify_phone_number_use_case.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterUseCase registerUseCase;
  VerifyPhoneNumberUseCase verifyPhoneNumberUseCase;
  SendVerificationCodeUseCase sendVerificationCodeUseCase;
  FinishProfileUseCase finishProfileUseCase;
  LoginWithPhoneNumberUserCase loginWithPhoneNumberUserCase;

  RegisterBloc({
    required this.registerUseCase,
    required this.verifyPhoneNumberUseCase,
    required this.sendVerificationCodeUseCase,
    required this.finishProfileUseCase,
    required this.loginWithPhoneNumberUserCase,
  }) : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) {});
    on<RegisterEventRegister>(_registerEvent);
    on<VerifyCodeEvent>(_verifyCodeEvent);
    on<ResendVerifactionCodeEvent>(_resendVerifactionCodeEvent);
    on<FinishingAccountEvent>(_finishingAccountEvent);
    on<LoginWithPhoneNumberEvent>(_loginEvent);
  }

  _registerEvent(
      RegisterEventRegister event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    final failurOrSuccess = await registerUseCase(
        event.phoneNumber, event.password, event.passwordConfirm);
    failurOrSuccess.fold(
      (failure) => emit(RegisterFailure(mapFailureToMessage(failure))),
      (unit) => emit(RegisterSuccess()),
    );
    emit(RegisterInitial());
  }

  _verifyCodeEvent(VerifyCodeEvent event, Emitter<RegisterState> emit) async {
    emit(verifyCodeLoading());
    final failurOrSuccess = await verifyPhoneNumberUseCase(event.code);
    failurOrSuccess.fold(
      (failure) => emit(verifyCodeFailure(mapFailureToMessage(failure))),
      (unit) => emit(verifyCodeSuccess()),
    );
    emit(RegisterInitial());
  }

  _resendVerifactionCodeEvent(
      ResendVerifactionCodeEvent event, Emitter<RegisterState> emit) async {
    emit(ResendVerifactionCodeLoading());
    final failurOrSuccess = await sendVerificationCodeUseCase();
    failurOrSuccess.fold(
      (failure) => emit(
        ResendVerifactionCodeFailure(mapFailureToMessage(failure)),
      ),
      (Strign) => emit(ResendVerifactionCodeSuccess()),
    );
    emit(RegisterInitial());
  }

  _finishingAccountEvent(
      FinishingAccountEvent event, Emitter<RegisterState> emit) async {
    emit(FinishingAccountLoading());
    final failurOrSuccess = await finishProfileUseCase(event.user);
    failurOrSuccess.fold(
      (failure) => emit(
        FinishingAccountFailure(mapFailureToMessage(failure)),
      ),
      (unit) => emit(FinishingAccountSuccess()),
    );
    emit(RegisterInitial());
  }

  _loginEvent(
      LoginWithPhoneNumberEvent event, Emitter<RegisterState> emit) async {
    emit(LoginWithPhoneNumberLoading());
    final failurOrSuccess =
        await loginWithPhoneNumberUserCase(event.phoneNumber, event.password);
    failurOrSuccess.fold(
      (failure) => emit(
        LoginWithPhoneNumberFailure(mapFailureToMessage(failure)),
      ),
      (user) => emit(LoginWithPhoneNumberSuccess(user)),
    );
    // emit(RegisterInitial());
  }
}
