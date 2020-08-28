import 'package:flutter/material.dart';
import 'package:mozin/modules/shared/models/gallery_image_model.dart';
import 'package:mozin/views/gallery_images/gallery_image_thumbnail.dart';
import 'package:mozin/views/gallery_images/gallery_photo_view_wrapper.dart';
import 'package:mozin/views/time_line/blocs/add_time_line_bloc/add_time_line_bloc.dart';

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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryPhotoViewWrapper(
          galleryItems: images,
          backgroundDecoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
          ),
          initialIndex: index,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  // Widget _buildImages(BuildContext context) {
  //   return BlocBuilder<ImageBloc, DefaultState>(
  //     bloc: imageBloc,
  //     builder: (BuildContext context, DefaultState state) {
  //       if (state is Loading) {
  //         return CustomCircularProgressIndicator();
  //       }

  //       if (state is LoadedImage) {
  //         currentJoke.medias = state.images;
  //         saveJoke(state.images);
  //       }

  //       if (currentJoke.medias != null) {
  //         return Wrap(
  //           children: currentJoke.medias.map<Widget>((image) {
  //             return _buildCardImage(context, image.url);
  //           }).toList(),
  //         );
  //       } else {
  //         return SizedBox.shrink();
  //       }
  //     },
  //   );
  // }
}
