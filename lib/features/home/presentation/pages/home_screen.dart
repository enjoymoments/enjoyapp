import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mozin/features/ads/presentation/pages/banner/banner_add.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/custom_icon.dart';
import 'package:mozin/package_view/extension.dart';
import 'package:mozin/package_view/spacer_box.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserAppModel _user;

  @override
  void initState() {
    _user = getItInstance<UserWrapper>().getUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (_user == UserAppModel.empty) {
      return Column(
        children: [
          _buildCardHelpMe(),
          SpacerBox.v16,
          BannerAdWidget(AdSize.banner),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _generateItem(
          context,
          AppIcons.calendar_day,
          Routes.calendar,
          'Calendário',
          'O que pretende fazer nos próximos dias ?',
        ),
        SpacerBox.v16,
        _buildCardHelpMe(),
        SpacerBox.v16,
        BannerAdWidget(AdSize.banner),
      ],
    );
  }

  Widget _buildCardHelpMe() {
    return _generateItem(
      context,
      AppIcons.assistive_listening_systems,
      Routes.feedback,
      'Ajude-nos a melhorar o app',
      'Compartilhe algum problema, sugestão ou melhoria',
    );
  }

  //TODO:review this - create widget
  Widget _generateItem(
    BuildContext context,
    IconData iconData,
    String routeName,
    String name,
    String description,
  ) {
    return GestureDetector(
      onTap: () {
        ExtendedNavigator.of(context).push(routeName);
      },
      child: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.sizeByPixel(70),
        decoration: BoxDecoration(
          color: Theme.of(context).hintColor,
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.sizeByPixel(8.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomIcon(
                    icon: iconData,
                  ),
                  SpacerBox.h8,
                  name.title(
                    context,
                  ),
                ],
              ),
              SpacerBox.v8,
              Expanded(
                child: description.description(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
