import 'package:client/features/authorisation/domain%20layer/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

class MatchEntity extends Equatable {
  final String? id;
  final User? likingUser;
  final User? likedUser;
  final DateTime? finalDate;

  final String? location;

  const MatchEntity({
    this.id,
    this.likingUser,
    this.likedUser,
    this.finalDate,
    this.location,
  });

  @override
  List<Object?> get props => [id, likingUser, likedUser, finalDate];
}
