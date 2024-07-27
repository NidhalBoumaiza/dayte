part of 'change_password__cubit.dart';

@immutable
sealed class ChangePasswordState extends Equatable {}

final class ChangePasswordInitial extends ChangePasswordState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class ChangePasswordLoading extends ChangePasswordState {
  @override
  List<Object?> get props => [];
}

final class ChangePasswordError extends ChangePasswordState {
  final String message;

  ChangePasswordError(this.message);

  @override
  List<Object?> get props => [message];
}

final class ChangePasswordUnauthorized extends ChangePasswordState {
  @override
  List<Object?> get props => [];
}

final class ChangePasswordSuccess extends ChangePasswordState {
  @override
  List<Object?> get props => [];
}
