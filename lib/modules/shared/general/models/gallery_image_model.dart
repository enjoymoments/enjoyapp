import 'dart:io';

import 'dart:typed_data';

class GalleryImageModel {
  GalleryImageModel({
    this.id,
    this.index,
    this.file,
    this.url,
    this.byte,
  });

  final String id;
  final int index;
  final File file;
  final String url;
  final Uint8List byte;
}
