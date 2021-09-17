import 'dart:io';

import 'dart:typed_data';

import 'package:mozin/modules/shared/general/models/base_image_model.dart';

class GalleryImageModel extends BaseImageModel {
  GalleryImageModel({
    String? id,
    this.index,
    this.file,
    this.url,
    this.byte,
  }) : super(id: id);

  final int? index;
  final File? file;
  final String? url;
  final Uint8List? byte;
}
