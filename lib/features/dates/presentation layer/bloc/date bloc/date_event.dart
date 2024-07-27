part of 'date_bloc.dart';

@immutable
sealed class DateEvent extends Equatable {}

final class GetRecommendationEvent extends DateEvent {
  @override
  List<Object> get props => [];
}

final class changeIsLikeValue extends DateEvent {
  final String id;

  changeIsLikeValue(this.id);

  @override
  List<Object> get props => [id];
}
