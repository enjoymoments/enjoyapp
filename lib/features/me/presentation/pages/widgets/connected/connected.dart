import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/me/presentation/pages/widgets/login/bloc/authentication_bloc.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/package_view/custom_avatar.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/extension.dart';
import 'package:mozin/package_view/spacer_box.dart';

class Connected extends StatelessWidget {
  final AuthenticationBloc authenticationBloc;

  const Connected({Key key, @required this.authenticationBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CustomContainer(
        child: InkWell(
          onTap: () {
            //authenticationBloc.add(Logout());
          },
          child: Column(
            children: <Widget>[
              SpacerBox.v24,
              CustomAvatar(
                radius: SizeConfig.sizeByPixel(45),
              ),
              'Tiana Rosser'.title(context),
              'Bla bla bla Bla bla bla Bla bla bla'.label(context),
              SpacerBox.v16,
              Divider(
                color: Theme.of(context).hintColor,
                height: SizeConfig.sizeByPixel(4),
              ),
              SpacerBox.v16,
              _buildLineInfo(context),
              SpacerBox.v16,
              _buildFavourites(context),
            ],
          ),
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
      children: [
        'Favoritos'.title(context, fontWeight: FontWeight.bold),
        _buildFavouritesItem(),
      ],
    );
  }

  Widget _buildFavouritesItem() {
    return CarouselSlider(
      items: _buildCards(),
      options: CarouselOptions(
          autoPlay: false,
          enableInfiniteScroll: false,
          pageSnapping: false,
          onPageChanged: (index, reason) {
            // setState(() {
            //   _current = index;
            // });
          }),
    );
  }

  List<Widget> _buildCards() {
    return List.generate(5, (index) {
      return Container(
        height: SizeConfig.sizeByPixel(10),
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              Image.network(
                  'https://i.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U',
                  fit: BoxFit.cover,
                  width: SizeConfig.sizeByPixel(100)),
            ],
          ),
        ),
      );
      // return Container(
      //   width: SizeConfig.screenWidth,
      //   margin: EdgeInsets.all(5.0),
      //   child: ClipRRect(
      //     borderRadius: BorderRadius.all(
      //       Radius.circular(5.0),
      //     ),
      //     child: Stack(
      //       children: <Widget>[
      //         CachedNetworkImage(
      //           fit: BoxFit.cover,
      //           imageUrl:
      //               'https://i.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U',
      //           width: SizeConfig.screenWidth,
      //           height: SizeConfig.screenHeight / 2,
      //         ),
      //       ],
      //     ),
      //   ),
      // );
    });
  }
}
