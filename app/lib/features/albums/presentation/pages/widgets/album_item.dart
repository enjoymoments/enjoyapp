import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_utilities/custom_utilities.dart';
import 'package:custom_view/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/albums/data/models/album_item_model.dart';
import 'package:mozin/modules/config/router.gr.dart';

class AlbumItem extends StatelessWidget {
  final AlbumItemModel album;

  const AlbumItem({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AutoRouter.of(context).push(Edit_albums_screen(album: album));
      },
      child: Column(
        children: [
          _buildHeader(context),
          CachedNetworkImage(
            imageUrl: album.medias![0].url!,
            fit: BoxFit.cover,
            placeholder: (context, imageProvider) {
              return ShimmerLoading(
                width: SizeConfig.sizeByPixel(SizeConfig.screenWidth!),
                height: SizeConfig.sizeByPixel(150),
              );
            },
            imageBuilder: (context, imageProvider) {
              return Container(
                child: Align(
                  alignment: Alignment.center,
                  child: album.titleAlbum!.labelIntro(context,
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
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        album.dateCreation!
            .dateCustomFormat('dd/MM/yyyy')
            .format(album.dateCreation!)
            .toString()
            .date(context),
        InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => CustomModalFit(
                items: [
                  CustomItemModalFit(
                    text: 'Deletar ábum',
                    iconData: AppIcons.trash,
                    onTap: () {
                      _remove(context);
                    },
                  ),
                ],
              ),
            );
          },
          child: Container(
            width: SizeConfig.sizeByPixel(60),
            height: SizeConfig.sizeByPixel(30),
            alignment: Alignment.centerRight,
            child: CustomIcon(icon: AppIcons.ellipsis_h),
          ),
        ),
      ],
    );
  }

  void _remove(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (context) => CustomModalFit(
        items: [
          CustomItemModalFit(
            text: 'Não quero deletar',
            iconData: AppIcons.ad,
            onTap: () {
              //_actionButtoncontroller.stop();
            },
          ),
          CustomItemModalFit(
            text: 'Sim, quero deletar',
            iconData: AppIcons.trash,
            onTap: () {
              //_editAlbumCubit.deleteAlbum(widget.album);
            },
          ),
        ],
      ),
    );
  }
}
