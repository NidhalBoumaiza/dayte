import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'edit_image_state.dart';

class EditImageCubit extends Cubit<EditImageState> {
  EditImageCubit() : super(EditImageState(img: []));

  void changeImage(dynamic img, String croppedImage) {
    List<String> splitString = [];
    dynamic image;
    if (!img.contains("uploads")) {
      splitString = img.split(",");
      image = base64Decode(splitString[1]);
    } else {
      image = img;
    }

    final updatedImages = List<dynamic>.from(state.img)..add(image);
    final updatedImagesToSendToBackend =
        List<String>.from(state.croppedImage ?? [])..add(croppedImage);
    final updatedState = EditImageState(
        img: updatedImages, croppedImage: updatedImagesToSendToBackend);
    print(updatedState.img.length);
    emit(updatedState);
  }

  void removeImage(int index) {
    if (index >= 0 && index < state.img.length) {
      final updatedImages = List<dynamic>.from(state.img)..removeAt(index);
      final updatedImagesToSendToBackend =
          List<String>.from(state.croppedImage ?? [])..removeAt(index);
      final updatedState = EditImageState(
          img: updatedImages, croppedImage: updatedImagesToSendToBackend);
      emit(updatedState);
    }
  }

  void clearState() {
    emit(EditImageState(img: [], croppedImage: []));
  }
}
