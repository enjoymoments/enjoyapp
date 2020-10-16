import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class WrapperMediaService {
  Future<List<File>> getMedias({FileType fileType = FileType.image}) async {
    return await FilePicker.getMultiFile(
      type: fileType,
    );
  }

  Future<File> openCamera() async {
    ImagePicker image = new ImagePicker();
    var file = await image.getImage(source: ImageSource.camera);
    return file != null ? File(file.path) : null;
  }
}
