import 'package:client/features/authorisation/domain%20layer/entities/image_entity.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;

  final String? phoneNumber;
  final String? password;
  final bool? verified;
  final String? name;
  final DateTime? dateOfBirth;
  final String? gender;
  final List<String>? interests;
  final List<String>? prompts;
  final List<String>? description;
  final List<ImageEntity>? images;
  final Location? location;
  final String? plan;
  final DateTime? endOfPlan;
  final int? age;

  User(
      {this.phoneNumber,
      this.id,
      this.password,
      this.verified,
      this.name,
      this.dateOfBirth,
      this.gender,
      this.interests,
      this.prompts,
      this.description,
      this.images,
      this.location,
      this.plan,
      this.endOfPlan,
      this.age});

  @override
  List<Object?> get props => [
        phoneNumber,
        password,
        verified,
        name,
        dateOfBirth,
        gender,
        interests,
        prompts,
        description,
        images,
        location,
        plan,
        endOfPlan,
        age,
        id,
      ];
}

// user_entity.dart
class Location extends Equatable {
  final List<num> coordinates;

  Location(this.coordinates);

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      (json['coordinates'] as List<dynamic>).map((e) => e as num).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coordinates': coordinates,
    };
  }

  @override
  List<Object?> get props => [coordinates];
}
