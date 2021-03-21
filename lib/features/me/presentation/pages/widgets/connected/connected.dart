import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/ads/presentation/pages/banners/banner_add_widget.dart';
import 'package:mozin/features/me/presentation/pages/widgets/connected/cubit/connected_cubit.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';
import 'package:mozin/package_view/custom_avatar.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/custom_divider.dart';
import 'package:mozin/package_view/extension.dart';
import 'package:mozin/package_view/spacer_box.dart';

class Connected extends StatelessWidget {
  final UserAppModel user;
  final ConnectedCubit connectedCubit;

  const Connected({
    Key key,
    @required this.user,
    @required this.connectedCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CustomContainer(
        child: Column(
          children: <Widget>[
            SpacerBox.v10,
            _buildHeader(context),
            SpacerBox.v16,
            CustomDivider(),
            SpacerBox.v16,
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
          radius: SizeConfig.sizeByPixel(35),
        ),
        SpacerBox.h16,
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            user.name.title(context),
            SpacerBox.v10,
            _buildLineInfo(context),
          ],
        ),
      ],
    );
  }

  Widget _buildLineInfo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildItemLineInfo(context, '438', 'Posts'),
        SpacerBox.h43,
        _buildItemLineInfo(context, '298', 'Fotos'),
        SpacerBox.h43,
        _buildItemLineInfo(context, '321', 'Marcações'),
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

  Widget _buildCards(BuildContext context) {
    return BlocBuilder<ConnectedCubit, ConnectedState>(
      cubit: connectedCubit,
      builder: (context, state) {
        return Column(
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 30,
              children: [
                _generateItem(context, Routes.albums_screen, 'Álbuns'),
                _generateItem(
                    context, Routes.favorite_interests_screen, 'Favoritos'),
              ],
            ),
            SpacerBox.v16,
            if (state.ads != null && state.ads.length > 0)
              BannerAdWidget(
                bannerAd: state.ads[0],
              ),
          ],
        );
      },
    );
  }

  Widget _generateItem(BuildContext context, String routeName, String name) {
    return GestureDetector(
      onTap: () {
        ExtendedNavigator.of(context).push(routeName);
      },
      child: Container(
        alignment: Alignment.center,
        width: SizeConfig.sizeByPixel(140),
        height: SizeConfig.sizeByPixel(120),
        decoration: BoxDecoration(
          color: Theme.of(context).hintColor,
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: name.label(
          context,
        ),
      ),
    );
  }
}
