part of 'edit_profile_cubit.dart';

@immutable
sealed class EditProfileState extends Equatable {}

final class EditProfileInitial extends EditProfileState {
  @override
  List<Object?> get props => [];
}

final class EditProfileLoading extends EditProfileState {
  @override
  List<Object?> get props => [];
}

final class EditProfileSuccess extends EditProfileState {
  @override
  List<Object?> get props => [];
}

final class EditProfileErreur extends EditProfileState {
  late String message;

  EditProfileErreur(message);

  @override
  List<Object?> get props => [message];
}

final class EditProfileUnauthorised extends EditProfileState {
  late String message;

  EditProfileUnauthorised(message);

  @override
  List<Object?> get props => [message];
}

final class EditProfileOffline extends EditProfileState {
  late String message;

  EditProfileOffline(message);

  @override
  List<Object?> get props => [message];
}

final class EndOfPlan extends EditProfileState {
  late String message;

  EndOfPlan(message);

  @override
  List<Object?> get props => [message];
}
