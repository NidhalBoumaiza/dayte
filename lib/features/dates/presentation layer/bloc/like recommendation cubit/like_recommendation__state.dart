part of 'like_recommendation__cubit.dart';

@immutable
sealed class LikeRecommendationState extends Equatable {}

final class LikeRecommendationInitial extends LikeRecommendationState {
  @override
  List<Object?> get props => [];
}

final class LikeRecommendationLoading extends LikeRecommendationState {
  @override
  List<Object?> get props => [];
}

final class LikeRecommendationError extends LikeRecommendationState {
  final String message;

  LikeRecommendationError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class LikeRecommendationSuccess extends LikeRecommendationState {
  @override
  List<Object?> get props => [];
}

final class LikeRecommendationUnauthorized extends LikeRecommendationState {
  @override
  List<Object?> get props => [];
}
