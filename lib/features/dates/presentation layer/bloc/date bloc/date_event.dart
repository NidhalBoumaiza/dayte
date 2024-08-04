part of 'date_bloc.dart';

@immutable
sealed class DateEvent extends Equatable {}

final class GetRecommendationEvent extends DateEvent {
  late bool isShuffle;

  GetRecommendationEvent({required this.isShuffle});

  @override
  List<Object> get props => [isShuffle];
}

final class changeIsLikeValue extends DateEvent {
  final String id;

  changeIsLikeValue(this.id);

  @override
  List<Object> get props => [id];
}
