import 'package:equatable/equatable.dart';

class ImageEntity extends Equatable {
  final String? id;
  final String? userId;
  final String? image;
  final int? position;

  ImageEntity({
    this.id,
    this.userId,
    this.image,
    this.position,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
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
