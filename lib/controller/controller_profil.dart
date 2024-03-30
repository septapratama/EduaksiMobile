import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerHelper {
  Future<File?> getImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  }
}
