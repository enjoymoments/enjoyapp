import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/modules/shared/general/enums.dart';
import 'package:mozin/modules/shared/general/models/gallery_image_model.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:custom_view/custom_circular_progress_indicador.dart';
import 'package:mozin/modules/shared/custom_view_migrate/gallery_images/gallery_photo_source_type_enum.dart';

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
      return Container(
        alignment: Alignment.center,
        child: Wrap(
          spacing: SizeConfig.sizeByPixel(10),
          children:
              _buildCustomPhotos(context, images, SizeConfig.sizeByPixel(150)),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  List<Widget> _buildCustomPhotos(
      BuildContext context, List<GalleryImageModel> images, double imageWidth) {
    List<Widget> _list = [];

    for (var i = 0; i < images.length; i++) {
      var item = images[i];

      _list.add(_LoadPhotoItem(
        galleryImages: images,
        index: i,
        item: item,
        sourceType: PhotoSourceType.file,
        imageWidth: imageWidth,
      ));
    }

    return _list;
  }

  //TODO: in development
  // Widget _buildCardImage(
  //   BuildContext context,
  //   GalleryImageModel image,
  // ) {
  //   return GalleryImageThumbnail(
  //     sourceType: sourceType,
  //     galleryImageModel: image,
  //     onRemoveCallback: (model) {
  //       onRemoveCallback(model);
  //     },
  //     onTap: () {
  //       open(context, image.index);
  //     },
  //   );
  // }

  // void open(BuildContext context, final int index) {
  //   ExtendedNavigator.of(context).push(
  //     Routes.gallery_photo_view_wrapper_screen,
  //     arguments: GalleryPhotoViewWrapperArguments(
  //       galleryPhotoSourceType: _sourceType(),
  //       galleryItems: images,
  //       backgroundDecoration: BoxDecoration(
  //         color: Theme.of(context).backgroundColor,
  //       ),
  //       initialIndex: index,
  //       scrollDirection: Axis.horizontal,
  //     ),
  //   );
  // }

  // GalleryPhotoSourceTypeEnum _sourceType() {
  //   if (sourceType == SourceTypeEnum.File) {
  //     return GalleryPhotoSourceTypeEnum.file;
  //   } else if (sourceType == SourceTypeEnum.Url) {
  //     return GalleryPhotoSourceTypeEnum.url;
  //   }

  //   return null;
  // }
}


//TODO: in development
enum PhotoSourceType {
  memory,
  network,
  file,
}

class _LoadPhotoItem extends StatelessWidget {
  final List<GalleryImageModel> galleryImages;
  final int index;
  final GalleryImageModel item;
  final PhotoSourceType sourceType;
  final double imageWidth;

  const _LoadPhotoItem({
    Key key,
    @required this.galleryImages,
    @required this.index,
    @required this.item,
    @required this.sourceType,
    @required this.imageWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ExtendedNavigator.of(context).push(
          Routes.gallery_photo_view_wrapper_screen,
          arguments: GalleryPhotoViewWrapperArguments(
            loadingBuilder: (BuildContext context, ImageChunkEvent event) =>
                CustomCircularProgressIndicator(),
            galleryPhotoSourceType: getGalleryPhotoSourceType(),
            galleryItems: galleryImages,
            backgroundDecoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
            ),
            initialIndex: index,
            scrollDirection: Axis.horizontal,
          ),
        );
      },
      child: Container(
        height: SizeConfig.sizeByPixel(100),
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              if (sourceType == PhotoSourceType.memory)
                Image.memory(item.byte, fit: BoxFit.cover, width: imageWidth),
              if (sourceType == PhotoSourceType.network)
                Image.network(item.url, fit: BoxFit.cover, width: imageWidth),
              if (sourceType == PhotoSourceType.file)
                Image.file(item.file, fit: BoxFit.cover, width: imageWidth),
            ],
          ),
        ),
      ),
    );
  }

  GalleryPhotoSourceTypeEnum getGalleryPhotoSourceType() {
    if(sourceType == PhotoSourceType.file) {
      return GalleryPhotoSourceTypeEnum.file;
    } else if (sourceType == PhotoSourceType.memory) {
      return GalleryPhotoSourceTypeEnum.memory;
    } else if (sourceType == PhotoSourceType.network) {
      return GalleryPhotoSourceTypeEnum.url;
    }

    return null;
  }
}
