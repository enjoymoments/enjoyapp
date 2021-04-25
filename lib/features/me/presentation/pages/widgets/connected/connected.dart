import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mozin/features/ads/presentation/pages/banners/banner_ad_widget.dart';
import 'package:mozin/features/me/presentation/pages/widgets/login/bloc/authentication_bloc.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/custom_avatar.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/custom_divider.dart';
import 'package:mozin/package_view/custom_item_modal_fit.dart';
import 'package:mozin/package_view/custom_modal_fit.dart';
import 'package:mozin/package_view/custom_tile.dart';
import 'package:mozin/package_view/extension.dart';
import 'package:mozin/package_view/spacer_box.dart';
import 'package:url_launcher/url_launcher.dart';

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
          title: 'Mais sobre nós',
          description: 'Redes sociais',
          iconStart: AppIcons.info_circle,
          iconEnd: AppIcons.angle_right,
          onTap: () {
            showMaterialModalBottomSheet(
              context: context,
              builder: (context) => CustomModalFit(
                items: [
                  CustomItemModalFit(
                    text: 'Instagram',
                    iconData: AppIcons.instagram,
                    onTap: () {
                      _launchURL('https://www.instagram.com/myenjoymoments/');
                    },
                  ),
                  CustomItemModalFit(
                    text: 'Facebook',
                    iconData: AppIcons.facebook,
                    onTap: () {
                      _launchURL(
                          'https://www.facebook.com/Enjoy-108714310939674');
                    },
                  ),
                  CustomItemModalFit(
                    text: 'Linkedin',
                    iconData: AppIcons.linkedin,
                    onTap: () {
                      _launchURL(
                          'https://www.linkedin.com/company/enjoy-moments/');
                    },
                  ),
                  CustomItemModalFit(
                    text: 'Site',
                    iconData: AppIcons.window_maximize,
                    onTap: () {
                      _launchURL('https://enjoymoments.com.br');
                    },
                  ),
                ],
              ),
            );
          },
        ),
        ..._divider(),
        CustomTile(
          title: 'Curtiu o Enjoy? Avalie-nos',
          description: 'Dá aquela 5 estrelas pra gente ;)',
          iconStart: AppIcons.thumbs_up,
          iconEnd: AppIcons.angle_right,
          onTap: () {
            ExtendedNavigator.of(context).push(Routes.configuration_screen);
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
        ..._buildLogout(),
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

  List<Widget> _buildLogout() {
    if (!_notAuthenticated()) {
      return [
        ..._divider(),
        CustomTile(
          title: 'Sair',
          description: 'Vou logo ali e já volto',
          iconStart: AppIcons.window_close,
          iconEnd: AppIcons.angle_right,
          onTap: () {
            root<AuthenticationBloc>()..add(Logout());
          },
        ),
      ];
    }

    return [];
  }

  bool _notAuthenticated() {
    if (getItInstance.isRegistered<UserWrapper>() &&
        (getItInstance<UserWrapper>().getUser == UserAppModel.empty)) {
      return true;
    }

    return false;
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
