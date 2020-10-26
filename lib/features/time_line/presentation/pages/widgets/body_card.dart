import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/time_line/data/models/time_line_model.dart';
import 'package:mozin/features/time_line/presentation/pages/widgets/loadings/photo_item_loading.dart';
import 'package:mozin/modules/config/size_config.dart';

class BodyCard extends StatefulWidget {
  const BodyCard({Key key, @required this.item}) : super(key: key);

  final TimeLineItemModel item;

  @override
  _BodyCardState createState() => _BodyCardState();
}

class _BodyCardState extends State<BodyCard> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return _buildContent();
  }

  Widget _buildContent() {
    return Column(
      children: [
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
      ],
    );
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
    return widget.item.medias
        .map(
          (media) => Container(
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
        )
        .toList();
  }
}
