import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mozin/modules/shared/general/enums.dart';
import 'package:mozin/modules/shared/general/models/gallery_image_model.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/package_view/gallery_images/gallery_image_thumbnail.dart';
import 'package:mozin/package_view/gallery_images/gallery_photo_source_type_enum.dart';

class ImageItems extends StatelessWidget {
  final Function(GalleryImageModel galleryImageModel) onRemoveCallback;
  final List<GalleryImageModel> images;
  final SourceTypeEnum sourceType;

  ImageItems({
    Key key,
    @required this.images,
    @required this.onRemoveCallback,
    @required this.sourceType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (images != null) {
      return Wrap(
        children: images.map<Widget>(
          (image) {
            return _buildCardImage(
              context,
              image,
            );
          },
        ).toList(),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _buildCardImage(
    BuildContext context,
    GalleryImageModel image,
  ) {
    return GalleryImageThumbnail(
      sourceType: sourceType,
      galleryImageModel: image,
      onRemoveCallback: (model) {
        onRemoveCallback(model);
      },
      onTap: () {
        open(context, image.index);
      },
    );
  }

  void open(BuildContext context, final int index) {
    ExtendedNavigator.of(context).push(
      Routes.gallery_photo_view_wrapper_screen,
      arguments: GalleryPhotoViewWrapperArguments(
        galleryPhotoSourceType: _sourceType(),
        galleryItems: images,
        backgroundDecoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
        ),
        initialIndex: index,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  GalleryPhotoSourceTypeEnum _sourceType() {
    if(sourceType == SourceTypeEnum.File) {
      return GalleryPhotoSourceTypeEnum.file;
    } else if (sourceType == SourceTypeEnum.Url) {
      return GalleryPhotoSourceTypeEnum.url;
    }

    return null;
  }
}
