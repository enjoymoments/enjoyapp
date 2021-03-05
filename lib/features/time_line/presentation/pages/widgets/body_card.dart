import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mozin/modules/shared/general/models/media_model.dart';
import 'package:mozin/features/time_line/data/models/time_line_model.dart';
import 'package:mozin/features/time_line/presentation/pages/widgets/loadings/photo_item_loading.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/modules/shared/general/models/gallery_image_model.dart';
import 'package:mozin/package_view/custom_circular_progress_indicador.dart';
import 'package:mozin/package_view/gallery_images/gallery_photo_source_type_enum.dart';
import 'package:mozin/package_view/extension.dart';
import 'package:mozin/package_view/spacer_box.dart';

class BodyCard extends StatefulWidget {
  const BodyCard({Key key, @required this.item}) : super(key: key);

  final TimeLineItemModel item;

  @override
  _BodyCardState createState() => _BodyCardState();
}

class _BodyCardState extends State<BodyCard> {
  int _current = 0;
  List<GalleryImageModel> _galleryImages;

  @override
  void initState() {
    _galleryImages = TimeLineItemModel.toGalleryImages(widget.item.medias);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return _buildContent();
  }

  Widget _buildContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextPost(),
        SpacerBox.v8,
        ..._buildCarousel(),
      ],
    );
  }

  List<Widget> _buildCarousel() {
    if (widget.item.medias.length > 0) {
      return [
        CarouselSlider(
          items: _buildPhotos(),
          options: CarouselOptions(
              autoPlay: false,
              enableInfiniteScroll: false,
              pageSnapping: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        if (widget.item.medias.length > 1) _buildBulletPoints(),
      ];
    }
    return [];
  }

  Widget _buildTextPost() {
    if (widget.item.textPost != null && widget.item.textPost.isNotEmpty) {
      return widget.item.textPost.description(context);
    }

    return SizedBox.shrink();
  }

  Widget _buildBulletPoints() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.item.medias.map(
        (url) {
          int index = widget.item.medias.indexOf(url);
          return Container(
            width: 8.0,
            height: 8.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _current == index
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).hintColor,
            ),
          );
        },
      ).toList(),
    );
  }

  List<Widget> _buildPhotos() {
    List<Widget> widgets = [];
    for (var i = 0; i < widget.item.medias.length; i++) {
      var media = widget.item.medias[i];
      widgets.add(_buildPhoto(media, i));
    }

    return widgets;
  }

  Widget _buildPhoto(MediaModel media, int index) {
    return GestureDetector(
      onTap: () {
        ExtendedNavigator.of(context).push(
          Routes.gallery_photo_view_wrapper,
          arguments: GalleryPhotoViewWrapperArguments(
            loadingBuilder: (BuildContext context, ImageChunkEvent event) =>
                CustomCircularProgressIndicator(),
            galleryPhotoSourceType: GalleryPhotoSourceTypeEnum.url,
            galleryItems: _galleryImages,
            backgroundDecoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
            ),
            initialIndex: index,
            scrollDirection: Axis.horizontal,
          ),
        );
      },
      child: Container(
        width: SizeConfig.screenWidth,
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
          child: Stack(
            children: <Widget>[
              CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: media.url,
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight / 2,
                placeholder: (context, url) => PhotoItemLoading(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
