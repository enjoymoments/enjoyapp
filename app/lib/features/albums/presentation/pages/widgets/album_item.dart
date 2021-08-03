import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/albums/data/models/album_item_model.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:custom_view/size_config.dart';
import 'package:custom_view/shimmer_loading.dart';
import 'package:custom_view/extensions/extension.dart';

class AlbumItem extends StatelessWidget {
  final AlbumItemModel album;

  const AlbumItem({Key key, @required this.album}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ExtendedNavigator.of(context).push(Routes.edit_albums_screen,
            arguments: EditAlbumScreenArguments(album: album));
      },
      child: CachedNetworkImage(
        imageUrl: album.medias[0].url,
        fit: BoxFit.cover,
        placeholder: (context, imageProvider) {
          return ShimmerLoading(
            width: SizeConfig.sizeByPixel(SizeConfig.screenWidth),
            height: SizeConfig.sizeByPixel(150),
          );
        },
        imageBuilder: (context, imageProvider) {
          return Container(
            child: Align(
              alignment: Alignment.center,
              child: album.titleAlbum.labelIntro(context,
                  color: Theme.of(context).backgroundColor),
            ),
            height: SizeConfig.sizeByPixel(150),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Theme.of(context).hintColor),
              image: DecorationImage(
                //TODO:review this - maybe use a another image for opacity
                // colorFilter: ColorFilter.mode(
                //   Colors.black.withOpacity(0.2),
                //   BlendMode.darken,
                // ),
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}