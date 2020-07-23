import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  Future<String> getImageAsync({ImageSource source = ImageSource.gallery}) async {
    ImagePicker image = new ImagePicker();
    var file = await image.getImage(source: source);
    return file.path;
  }
}