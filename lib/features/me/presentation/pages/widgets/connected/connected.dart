import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';
import 'package:mozin/package_view/custom_avatar.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/extension.dart';
import 'package:mozin/package_view/spacer_box.dart';

class Connected extends StatelessWidget {
  final UserAppModel user;

  const Connected({Key key, @required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CustomContainer(
        child: Column(
          children: <Widget>[
            SpacerBox.v10,
            CustomAvatar(
              radius: SizeConfig.sizeByPixel(35),
            ),
            user.name.title(context),
            'Bla bla bla Bla bla bla Bla bla bla'.label(context),
            SpacerBox.v16,
            Divider(
              color: Theme.of(context).hintColor,
              height: SizeConfig.sizeByPixel(4),
            ),
            SpacerBox.v8,
            _buildLineInfo(context),
            SpacerBox.v16,
            _buildFavourites(context),
            SpacerBox.v16,
          ],
        ),
      ),
    );
  }

  Widget _buildLineInfo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildItemLineInfo(context, '438', 'Posts'),
        SpacerBox.h43,
        _buildItemLineInfo(context, '298', 'Following'),
        SpacerBox.h43,
        _buildItemLineInfo(context, '321K', 'Followers'),
      ],
    );
  }

  Widget _buildItemLineInfo(
      BuildContext context, String title, String description) {
    return Column(
      children: [
        title.title(context, fontWeight: FontWeight.bold),
        SpacerBox.v4,
        description.label(context),
      ],
    );
  }

  Widget _buildFavourites(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        'Favoritos'.title(context, fontWeight: FontWeight.bold),
        SpacerBox.v8,
        _buildFavouritesItem(context),
      ],
    );
  }

  Widget _buildFavouritesItem(BuildContext context) {
    return CarouselSlider(
      items: _buildCards(context),
      options: CarouselOptions(
        autoPlay: false,
        viewportFraction: 0.5,
        initialPage: 1,
        enableInfiniteScroll: false,
        pageSnapping: false,
      ),
    );
  }

  List<Widget> _buildCards(BuildContext context) {
    return List.generate(5, (index) {
      return Container(
        margin: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 0.2,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl:
                      'https://i.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U',
                  width: SizeConfig.sizeByPixel(150),
                  height: SizeConfig.sizeByPixel(150),
                ),
              ),
            ),
            SpacerBox.v8,
            Padding(
              padding: EdgeInsets.only(left: SizeConfig.sizeByPixel(10), bottom: SizeConfig.sizeByPixel(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "Outterwear".title(context, fontWeight: FontWeight.bold, fontSize: 14),
                  '170+ items'.label(context, fontSize: 13),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
