import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/ads/presentation/pages/banners/banner_ad_widget.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/custom_avatar.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/custom_divider.dart';
import 'package:mozin/package_view/custom_tile.dart';
import 'package:mozin/package_view/extension.dart';
import 'package:mozin/package_view/spacer_box.dart';

class Connected extends StatelessWidget {
  final UserAppModel user;

  const Connected({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CustomContainer(
        child: Column(
          children: <Widget>[
            SpacerBox.v10,
            _buildHeader(context),
            SpacerBox.v30,
            _buildCards(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        CustomAvatar(
          radius: SizeConfig.sizeByPixel(25),
        ),
        SpacerBox.h16,
        user.name.title(context),
      ],
    );
  }

  Widget _buildCards(BuildContext context) {
    return Column(
      children: [
        CustomTile(
          title: 'Álbuns',
          description: 'Meus álbums pessoais',
          iconStart: AppIcons.camera_retro,
          iconEnd: AppIcons.angle_right,
          onTap: () {
            ExtendedNavigator.of(context).push(Routes.albums_screen);
          },
        ),
        ..._divider(),
        CustomTile(
          title: 'Favoritos',
          description: 'Meus lugares favoritos',
          iconStart: AppIcons.star,
          iconEnd: AppIcons.angle_right,
          onTap: () {
            ExtendedNavigator.of(context)
                .push(Routes.favorite_interests_screen);
          },
        ),
        ..._divider(),
        CustomTile(
          title: 'Configurações',
          description: 'Minhas configurações',
          iconStart: AppIcons.cog,
          iconEnd: AppIcons.angle_right,
          onTap: () {
            ExtendedNavigator.of(context).push(Routes.configuration_screen);
          },
        ),
        ..._divider(),
        BannerAdWidget(
          screenName: Routes.me_authenticated_partial,
        ),
      ],
    );
  }

  List<Widget> _divider() {
    return [
      SpacerBox.v14,
      CustomDivider(),
      SpacerBox.v14,
    ];
  }
}
