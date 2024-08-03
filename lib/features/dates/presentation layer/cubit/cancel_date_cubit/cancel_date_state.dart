part of 'cancel_date_cubit.dart';

@immutable
sealed class CancelDateState extends Equatable {}

final class CancelDateInitial extends CancelDateState {
  @override
  List<Object?> get props => [];
}

final class CancelDateLoading extends CancelDateState {
  @override
  List<Object?> get props => [];
}

final class CancelDateSuccess extends CancelDateState {
  @override
  List<Object?> get props => [];
}

final class CancelDateErreur extends CancelDateState {
  final String message;

  CancelDateErreur(this.message);

  @override
  List<Object?> get props => [message];
}

final class CancelDateUnauthorised extends CancelDateState {
  final String message;

  CancelDateUnauthorised(this.message);

  @override
  List<Object?> get props => [message];
}

final class CancelDateNetworkErreur extends CancelDateState {
  final String message;

  CancelDateNetworkErreur(this.message);

  @override
  List<Object?> get props => [message];
}

final class EndOfPlanErreur extends CancelDateState {
  final String message;

  EndOfPlanErreur(this.message);

  @override
  List<Object?> get props => [message];
}
