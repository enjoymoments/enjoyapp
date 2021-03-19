import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mozin/modules/shared/firebase/firebase_storage_service.dart';
import 'package:mozin/modules/shared/general/models/gallery_image_model.dart';
import 'package:mozin/modules/shared/general/models/key_value.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as Path;

class WrapperMediaService {
  WrapperMediaService({
    @required this.uuidService,
    @required this.firebaseStorageService,
    @required this.userWrapper,
  });

  final Uuid uuidService;
  final FirebaseStorageService firebaseStorageService;
  final UserWrapper userWrapper;

  String generateUUIDv4() {
    return uuidService.v4();
  }

  Future<List<PlatformFile>> getMedias({FileType fileType = FileType.image}) async {
    FilePickerResult _result = await FilePicker.platform.pickFiles(
      type: fileType,
      allowMultiple: true
    );
    
    return _result.files;
  }

  Future<File> openCamera() async {
    ImagePicker image = new ImagePicker();
    var file = await image.getImage(source: ImageSource.camera);
    return file != null ? File(file.path) : null;
  }

  List<GalleryImageModel> transformFilesToImages(List<PlatformFile> files) {
    final List<GalleryImageModel> galleryItems = [];

    for (var i = 0; i < files.length; i++) {
      var item = files[i];
      galleryItems.add(GalleryImageModel(
        id: uuidService.v4(),
        index: i,
        //TODO:review this
        //file: item,
      ));
    }

    return galleryItems;
  }

  Future<List<KeyValue<String, String>>> uploadMedias(
      List<GalleryImageModel> medias) async {
    List<Future<dynamic>> _listFutures = [];
    List<KeyValue<String, String>> _listUrls = [];
    List<GalleryImageModel> _errorItems = [];

    for (var item in medias) {
      String extensionFile = Path.extension(item.file.path);

      try {
        _listFutures.add(
          firebaseStorageService
              .uploadFile(
                  userWrapper.getUser.id, item.file, "${item.id}$extensionFile")
              .then((value) {
            _listUrls.add(KeyValue<String, String>(key: item.id, value: value));
          }).catchError((onError) {
            _errorItems.add(item);
          }),
        );
      } catch (e) {
        _errorItems.add(item);
      }
    }

    await Future.wait(_listFutures);

    return _listUrls;
  }
}
