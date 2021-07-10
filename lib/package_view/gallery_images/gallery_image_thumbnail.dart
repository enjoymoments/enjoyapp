import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mozin/modules/shared/general/enums.dart';
import 'package:mozin/modules/shared/general/models/gallery_image_model.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/custom_item_modal_fit.dart';
import 'package:mozin/package_view/custom_modal_fit.dart';
import 'package:vibration/vibration.dart';

class GalleryImageThumbnail extends StatelessWidget {
  const GalleryImageThumbnail({
    Key key,
    @required this.galleryImageModel,
    @required this.onRemoveCallback,
    @required this.onTap,
    @required this.sourceType,
  }) : super(key: key);

  final GalleryImageModel galleryImageModel;
  final Function(GalleryImageModel galleryImageModel) onRemoveCallback;
  final GestureTapCallback onTap;
  final SourceTypeEnum sourceType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
        onTap: onTap,
        onLongPress: () {
          _removeMedia(context);
        },
        child: Hero(
          tag: galleryImageModel.id,
          child: Container(
            height: 80,
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: _buildImage(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              margin: EdgeInsets.all(10),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (sourceType == SourceTypeEnum.File) {
      return Image.file(
        galleryImageModel.file,
        fit: BoxFit.fill,
      );
    } else if (sourceType == SourceTypeEnum.Url) {
      return CachedNetworkImage(
        imageUrl: galleryImageModel.url,
        fit: BoxFit.fill,
      );
    }

    return null;
  }

  void _removeMedia(BuildContext context) async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(duration: 50);
    }

    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => CustomModalFit(
        items: [
          CustomItemModalFit(
            text: 'Não quero remover',
            iconData: AppIcons.ad,
            onTap: () {
            },
          ),
          CustomItemModalFit(
            text: 'Sim, quero remover',
            iconData: AppIcons.trash,
            onTap: () {
              onRemoveCallback(galleryImageModel);
            },
          ),
        ],
      ),
    );
  }
}
