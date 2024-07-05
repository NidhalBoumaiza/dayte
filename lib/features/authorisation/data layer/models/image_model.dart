import '../../domain layer/entities/image_entity.dart';

class ImageModel extends ImageEntity {
  ImageModel({
    String? id,
    String? userId,
    String? image,
    int? position,
  }) : super(
          id: id,
          userId: userId,
          image: image,
          position: position,
        );

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['_id'] as String?,
      userId: json['user_id'] as String?,
      image: json['image'] as String?,
      position: json['position'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user_id': userId,
      'image': image,
      'position': position,
    };
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        image,
        position,
      ];
}
