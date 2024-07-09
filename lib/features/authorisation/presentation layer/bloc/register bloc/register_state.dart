part of 'register_bloc.dart';

@immutable
sealed class RegisterState extends Equatable {}

final class RegisterInitial extends RegisterState {
  @override
  List<Object?> get props => [];
}

final class RegisterLoading extends RegisterState {
  @override
  List<Object?> get props => [];
}

final class RegisterSuccess extends RegisterState {
  RegisterSuccess();

  @override
  List<Object?> get props => [];
}

final class RegisterFailure extends RegisterState {
  final String message;

  RegisterFailure(this.message);

  @override
  List<Object?> get props => [message];
}

final class verifyCodeLoading extends RegisterState {
  @override
  List<Object?> get props => [];
}

final class verifyCodeSuccess extends RegisterState {
  verifyCodeSuccess();

  @override
  List<Object?> get props => [];
}

final class verifyCodeFailure extends RegisterState {
  final String message;

  verifyCodeFailure(this.message);

  @override
  List<Object?> get props => [message];
}

final class ResendVerifactionCodeLoading extends RegisterState {
  @override
  List<Object?> get props => [];
}

final class ResendVerifactionCodeSuccess extends RegisterState {
  ResendVerifactionCodeSuccess();

  @override
  List<Object?> get props => [];
}

final class ResendVerifactionCodeFailure extends RegisterState {
  final String message;

  ResendVerifactionCodeFailure(this.message);

  @override
  List<Object?> get props => [message];
}

final class FinishingAccountLoading extends RegisterState {
  @override
  List<Object?> get props => [];
}

final class FinishingAccountSuccess extends RegisterState {
  FinishingAccountSuccess();

  @override
  List<Object?> get props => [];
}

final class FinishingAccountFailure extends RegisterState {
  final String message;

  FinishingAccountFailure(this.message);

  @override
  List<Object?> get props => [message];
}

final class LoginWithPhoneNumberLoading extends RegisterState {
  LoginWithPhoneNumberLoading();

  @override
  List<Object?> get props => [throw UnimplementedError()];
}

final class LoginWithPhoneNumberSuccess extends RegisterState {
  User user;

  LoginWithPhoneNumberSuccess(this.user);

  @override
  List<Object?> get props => [throw UnimplementedError()];
}

final class LoginWithPhoneNumberFailure extends RegisterState {
  final String message;

  LoginWithPhoneNumberFailure(this.message);

  @override
  List<Object?> get props => [message];
}
