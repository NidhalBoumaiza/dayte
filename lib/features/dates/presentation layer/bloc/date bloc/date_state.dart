part of 'date_bloc.dart';

@immutable
sealed class DateState extends Equatable {}

final class DateInitial extends DateState {
  @override
  List<Object?> get props => [];
}

final class GetRecommendationLoading extends DateState {
  @override
  List<Object?> get props => [];
}

final class GetRecommendationError extends DateState {
  final String message;

  GetRecommendationError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class GetRecommendationUnauthorized extends DateState {
  GetRecommendationUnauthorized();

  @override
  List<Object?> get props => [];
}

final class GetRecommendationSuccess extends DateState {
  final List<User> recommendations;

  GetRecommendationSuccess({required this.recommendations});

  @override
  List<Object?> get props => [recommendations];
}

final class EndOfPlanErreur extends DateState {
  final String message;

  EndOfPlanErreur({required this.message});

  @override
  List<Object?> get props => [message];
}
