import 'package:flutter/material.dart';
import 'package:mozin/modules/shared/custom_view_migrate/gallery_images/gallery_photo_source_type_enum.dart';
import 'package:mozin/modules/shared/general/models/gallery_image_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryPhotoViewWrapper extends StatefulWidget {
  GalleryPhotoViewWrapper({
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex,
    @required this.galleryItems,
    @required this.galleryPhotoSourceType,
    this.scrollDirection = Axis.horizontal,
  }) : pageController = PageController(initialPage: initialIndex);

  final LoadingBuilder loadingBuilder;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List<GalleryImageModel> galleryItems;
  final Axis scrollDirection;
  final GalleryPhotoSourceTypeEnum galleryPhotoSourceType;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  int currentIndex;

  @override
  void initState() {
    currentIndex = widget.initialIndex;
    super.initState();
  }

  @override
  void dispose() {
    widget.pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: widget.backgroundDecoration,
        child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: _buildItem,
          itemCount: widget.galleryItems.length,
          loadingBuilder: widget.loadingBuilder,
          backgroundDecoration: widget.backgroundDecoration,
          pageController: widget.pageController,
          onPageChanged: onPageChanged,
          scrollDirection: widget.scrollDirection,
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final GalleryImageModel item = widget.galleryItems[index];
    return PhotoViewGalleryPageOptions(
      imageProvider: _getImageProvider(item),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 1.1,
      heroAttributes: PhotoViewHeroAttributes(tag: item.id),
    );
  }

  ImageProvider<dynamic> _getImageProvider(GalleryImageModel item) {
    if (widget.galleryPhotoSourceType == GalleryPhotoSourceTypeEnum.file) {
      return FileImage(item.file);
    } else if (widget.galleryPhotoSourceType ==
        GalleryPhotoSourceTypeEnum.url) {
      return NetworkImage(item.url);
    } else if (widget.galleryPhotoSourceType ==
        GalleryPhotoSourceTypeEnum.memory) {
      return MemoryImage(item.byte);
    }

    throw Exception('GalleryPhotoSourceType not found.');
  }
}
