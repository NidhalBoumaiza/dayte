import 'package:client/features/authorisation/data%20layer/models/user_model.dart';
import 'package:client/features/dates/domain%20layer/entities/match_entity.dart';

class MatchModel extends MatchEntity {
  MatchModel({
    String? id,
    UserModel? LikingUser,
    UserModel? LikedUser,
    DateTime? finalDate,
    String? location,
  }) : super(
          id: id,
          likingUser: LikingUser,
          likedUser: LikedUser,
          finalDate: finalDate,
          location: location,
        );

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      id: json['_id'] as String?,
      LikingUser: json['likingUser'] != null
          ? UserModel.fromJson(json['likingUser'] as Map<String, dynamic>)
          : null,
      LikedUser: json['likedUser'] != null
          ? UserModel.fromJson(json['likedUser'] as Map<String, dynamic>)
          : null,
      finalDate: json['finalTime'] != null
          ? DateTime.parse(json['finalTime'] as String)
          : null,
      location: json['location']['address'] as String?,
    );
  }

// Map<String, dynamic> toJson() {
//   return {
//     '_id': id,
//     'LikingUser': LikingUser?.toJson(),
//     'LikedUser': LikedUser?.toJson(),
//     'finalDate': finalDate?.toIso8601String(),
//     'location': location,
//   };
// }
}
