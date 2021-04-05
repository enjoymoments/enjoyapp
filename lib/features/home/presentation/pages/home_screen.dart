import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/ads/presentation/pages/banners/banner_ad_widget.dart';
import 'package:mozin/features/home/presentation/blocs/home_cubit/home_cubit.dart';
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
  HomeCubit _homeCubit;

  @override
  void initState() {
    _user = getItInstance<UserWrapper>().getUser;
    _homeCubit = getItInstance<HomeCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _homeCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: BlocBuilder<HomeCubit, HomeState>(
        cubit: _homeCubit,
        builder: (context, state) {
          return _buildContent(state);
        },
      ),
    );
  }

  Widget _buildContent(HomeState state) {
    if (_user == UserAppModel.empty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildCardHelpMe(),
          SpacerBox.v16,
          BannerAdWidget(
            screenName: Routes.home_partial,
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _generateItem(
          context,
          AppIcons.calendar_day,
          Routes.calendar_screen,
          'Calendário',
          'O que pretende fazer nos próximos dias ?',
        ),
        SpacerBox.v16,
        _buildCardHelpMe(),
        SpacerBox.v16,
        BannerAdWidget(
            screenName: Routes.home_partial,
        ),
      ],
    );
  }

  Widget _buildCardHelpMe() {
    return _generateItem(
      context,
      AppIcons.assistive_listening_systems,
      Routes.feedback_screen,
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
