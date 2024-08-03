part of 'get_matches_cubit.dart';

@immutable
sealed class GetMatchesState extends Equatable {}

final class GetMatchesInitial extends GetMatchesState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class GetMatchesLoading extends GetMatchesState {
  @override
  List<Object?> get props => [];
}

final class GetMatchesErreur extends GetMatchesState {
  final String message;

  GetMatchesErreur(this.message);

  @override
  List<Object?> get props => [message];
}

final class GetMatchesUnauthorized extends GetMatchesState {
  @override
  List<Object?> get props => [];
}

final class GetMatchesSucess extends GetMatchesState {
  final List<MatchEntity> matches;

  GetMatchesSucess(this.matches);

  @override
  List<Object?> get props => [matches];
}

final class EndOfPlanErreur extends GetMatchesState {
  final String message;

  EndOfPlanErreur(this.message);

  @override
  List<Object?> get props => [message];
}
