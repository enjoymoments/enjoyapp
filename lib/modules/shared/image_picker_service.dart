import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  Future<File> getImageAsync({ImageSource source = ImageSource.gallery}) async {
    ImagePicker image = new ImagePicker();
    var file = await image.getImage(source: source);
    return file != null ? File(file.path) : null;
  }
}
