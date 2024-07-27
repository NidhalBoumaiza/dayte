import 'package:client/features/authorisation/data%20layer/models/image_model.dart';
import 'package:client/features/authorisation/domain%20layer/entities/image_entity.dart';

import '../../domain layer/entities/user_entity.dart';

class UserModel extends User {
  UserModel({
    String? id,
    String? phoneNumber,
    String? password,
    bool? verified,
    String? name,
    DateTime? dateOfBirth,
    String? gender,
    List<String>? interests,
    List<String>? prompts,
    List<String>? description,
    List<ImageEntity>? images,
    Location? location,
    String? plan,
    DateTime? endOfPlan,
    int? age,
    bool? isLiked,
  }) : super(
          id: id,
          phoneNumber: phoneNumber,
          password: password,
          verified: verified,
          name: name,
          dateOfBirth: dateOfBirth,
          gender: gender,
          interests: interests,
          prompts: prompts,
          description: description,
          images: images,
          location: location,
          plan: plan,
          endOfPlan: endOfPlan,
          age: age,
          isLiked: isLiked,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return UserModel(
      id: json['_id'] as String?,
      phoneNumber: json['phone_number'] as String?,
      password: json['password'] as String?,
      age: json['age'] as int?,
      isLiked: json['isLiked'] as bool?,
      verified: json['verified'] as bool?,
      name: json['name'] as String?,
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'] as String)
          : null,
      gender: json['gender'] as String?,
      interests: (json['interests'] as List<dynamic>?)
          ?.map((e) => e['name'] as String)
          .toList(),
      prompts:
          (json['prompts'] as List<dynamic>?)?.map((e) => e as String).toList(),
      description: (json['description'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      location: json['location'] != null
          ? Location.fromJson(json['location'] as Map<String, dynamic>)
          : null,
      plan: json['plan'] as String?,
      endOfPlan: json['endOfPlan'] != null
          ? DateTime.parse(json['endOfPlan'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'password': password,
      'verified': verified,
      'name': name,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'gender': gender,
      'interests': interests,
      'prompts': prompts,
      'description': description,
      'images': images?.map((e) => e.toJson()).toList(),
      'location': location?.toJson(),
      'plan': plan,
      'endOfPlan': endOfPlan?.toIso8601String(),
    };
  }
}
