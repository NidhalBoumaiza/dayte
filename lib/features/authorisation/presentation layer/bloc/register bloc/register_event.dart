part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent extends Equatable {}

final class RegisterEventRegister extends RegisterEvent {
  final String phoneNumber;
  final String password;
  final String passwordConfirm;

  RegisterEventRegister({
    required this.phoneNumber,
    required this.password,
    required this.passwordConfirm,
  });

  @override
  List<Object> get props => [phoneNumber, password, passwordConfirm];
}

final class VerifyCodeEvent extends RegisterEvent {
  final String code;

  VerifyCodeEvent({required this.code});

  @override
  List<Object> get props => [code];
}

final class ResendVerifactionCodeEvent extends RegisterEvent {
  ResendVerifactionCodeEvent();

  @override
  List<Object> get props => [];
}

final class FinishingAccountEvent extends RegisterEvent {
  User user;

  FinishingAccountEvent({required this.user});

  @override
  List<Object?> get props => [user];
}

final class LoginWithPhoneNumberEvent extends RegisterEvent {
  String password;

  String phoneNumber;

  LoginWithPhoneNumberEvent({
    required this.phoneNumber,
    required this.password,
  });

  @override
  List<Object?> get props => [phoneNumber, password];
}
