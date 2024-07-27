part of 'forget_password__cubit.dart';

@immutable
sealed class ForgetPasswordState extends Equatable {}

final class ForgetPasswordInitial extends ForgetPasswordState {
  @override
  List<Object?> get props => [];
}

final class ForgetPasswordLoading extends ForgetPasswordState {
  @override
  List<Object?> get props => [];
}

final class ForgetPasswordSuccess extends ForgetPasswordState {
  @override
  List<Object?> get props => [];
}

final class ForgetPasswordErreur extends ForgetPasswordState {
  final String message;

  ForgetPasswordErreur(this.message);

  @override
  List<Object?> get props => [message];
}

final class ForgetPasswordUnauthorised extends ForgetPasswordState {
  @override
  List<Object?> get props => [];
}

final class ResetPasswordLoading extends ForgetPasswordState {
  @override
  List<Object?> get props => [];
}

final class ResetPasswordSuccess extends ForgetPasswordState {
  @override
  List<Object?> get props => [];
}

final class ResetPasswordErreur extends ForgetPasswordState {
  final String message;

  ResetPasswordErreur(this.message);

  @override
  List<Object?> get props => [message];
}

final class ResetPasswordUnauthorised extends ForgetPasswordState {
  @override
  List<Object?> get props => [];
}
