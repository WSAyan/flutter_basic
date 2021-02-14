import 'dart:io';

import 'package:image_picker/image_picker.dart';

class PickerHelper {
  Future<File> getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile == null) {
      return null;
    }

    return File(pickedFile.path);
  }

  Future<File> getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile == null) {
      return null;
    }

    return File(pickedFile.path);
  }
}
