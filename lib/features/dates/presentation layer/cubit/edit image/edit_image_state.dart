import 'package:equatable/equatable.dart';

class EditImageState extends Equatable {
  List<dynamic> img;
  List<String>? croppedImage;

  EditImageState({
    required this.img,
    this.croppedImage,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [img];
}
