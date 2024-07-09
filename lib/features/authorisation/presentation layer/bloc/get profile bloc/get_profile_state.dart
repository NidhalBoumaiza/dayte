part of 'get_profile_bloc.dart';

@immutable
sealed class GetProfileState extends Equatable {}

final class GetProfileInitial extends GetProfileState {
  @override
  List<Object?> get props => [];
}

final class GetProfileLoading extends GetProfileState {
  @override
  List<Object?> get props => [];
}

final class GetProfileSuccess extends GetProfileState {
  final User user;

  GetProfileSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

final class GetProfileFailure extends GetProfileState {
  final String message;

  GetProfileFailure(this.message);

  @override
  List<Object?> get props => [message];
}

final class GetProfileUnauthorized extends GetProfileState {
  @override
  List<Object?> get props => [];
}
