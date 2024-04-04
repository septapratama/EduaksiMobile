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
  String evaluatePasswordStrength(String password) {
    if (password.length >= 8 &&
        password.contains(RegExp(r'[0-9]')) &&
        password.contains(RegExp(r'[a-zA-Z]'))) {
      return 'Kuat';
    } else if (password.length >= 8 &&
        (password.contains(RegExp(r'[0-9]')) ||
            password.contains(RegExp(r'[a-zA-Z]')))) {
      return 'Sedang';
    } else {
      return 'Rendah';
    }
  }
}