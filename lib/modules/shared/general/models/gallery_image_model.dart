import 'dart:io';

class GalleryImageModel {
  GalleryImageModel({
    this.id,
    this.index,
    this.file,
    this.url,
  });

  final String id;
  final int index;
  final File file;
  final String url;
}
