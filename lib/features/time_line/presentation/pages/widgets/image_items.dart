import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/time_line/presentation/blocs/add_time_line_bloc/add_time_line_bloc.dart';
import 'package:mozin/modules/shared/general/models/gallery_image_model.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/package_view/gallery_images/gallery_image_thumbnail.dart';
import 'package:mozin/package_view/gallery_images/gallery_photo_source_type_enum.dart';

class ImageItems extends StatelessWidget {
  final AddTimeLineBloc addTimeLineBloc;
  final List<GalleryImageModel> images;

  ImageItems({
    Key key,
    @required this.images,
    @required this.addTimeLineBloc,
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
      addTimeLineBloc: addTimeLineBloc,
      galleryImageModel: image,
      onTap: () {
        open(context, image.index);
      },
    );
  }

  void open(BuildContext context, final int index) {
    ExtendedNavigator.of(context).push(
      Routes.gallery_photo_view_wrapper,
      arguments: GalleryPhotoViewWrapperArguments(
        galleryPhotoSourceType: GalleryPhotoSourceTypeEnum.file,
        galleryItems: images,
        backgroundDecoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
        ),
        initialIndex: index,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
