part of 'date_bloc.dart';

@immutable
sealed class DateEvent extends Equatable {}

final class GetRecommendationEvent extends DateEvent {
  @override
  List<Object> get props => [];
}
