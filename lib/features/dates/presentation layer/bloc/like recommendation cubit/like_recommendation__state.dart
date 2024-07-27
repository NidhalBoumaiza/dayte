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

final class ItsAMatch extends LikeRecommendationState {
  String id;

  User likingUser;
  User likedUser;

  ItsAMatch(
      {required this.id, required this.likedUser, required this.likingUser});

  @override
  List<Object?> get props => [id, likedUser, likingUser];
}
