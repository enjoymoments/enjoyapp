import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mozin/features/home/presentation/pages/home_screen.dart';
import 'package:mozin/features/me/presentation/pages/widgets/login/bloc/authentication_bloc.dart';
import 'package:mozin/features/monitoring/presentation/pages/monitoring_screen.dart';
import 'package:mozin/features/screen_manager/presentation/bloc/screen_manager_bloc.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/features/me/presentation/pages/me_screen.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/custom_icon.dart';
import 'package:mozin/package_view/custom_item_modal_fit.dart';
import 'package:mozin/package_view/custom_modal_fit.dart';
import 'package:mozin/package_view/custom_scaffold.dart';
import 'package:mozin/package_view/default_menu.dart';
import 'package:mozin/package_view/enum/default_menu_enum.dart';
import 'package:mozin/features/time_line/presentation/pages/time_line_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenManager extends StatefulWidget {
  @override
  _ScreenManagerState createState() => _ScreenManagerState();
}

class _ScreenManagerState extends State<ScreenManager> {
  ScreenManagerBloc _screenManagerBloc;

  @override
  void initState() {
    _screenManagerBloc = getItInstance<ScreenManagerBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return BlocBuilder<ScreenManagerBloc, ScreenManagerState>(
      cubit: _screenManagerBloc,
      builder: (BuildContext context, ScreenManagerState state) {
        return CustomScaffold(
          child: _buildContent(state),
          appBar: _buildAppBar(state),
          bottomNavigationBar: DefaultMenu(onTap: (itemSelected) {
            _screenManagerBloc.add(TapScreen(itemSelected, context));
          }),
        );
      },
    );
  }

  Widget _buildAppBar(ScreenManagerState state) {
    return AppBar(
      title: Text(
        _getStringbyScreen(state),
      ),
      actions: _buildActionButtons(state),
    );
  }

  Widget _buildContent(ScreenManagerState state) {
    switch (state.currentScreen) {
      case DEFAULT_MENU_ENUM.TIME_LINE:
        return TimeLineScreen();
      case DEFAULT_MENU_ENUM.ME:
        return MeScreen();
      case DEFAULT_MENU_ENUM.MONITORING:
        return MonitoringScreen();
      case DEFAULT_MENU_ENUM.HOME:
      default:
        return HomeScreen();
    }
  }

  List<Widget> _buildActionButtons(ScreenManagerState state) {
    switch (state.currentScreen) {
      case DEFAULT_MENU_ENUM.TIME_LINE:
        if (_notAuthenticated()) {
          return [];
        }
        return [
          IconButton(
            icon: CustomIcon(icon: AppIcons.plus),
            onPressed: () {
              showMaterialModalBottomSheet(
                context: context,
                builder: (context, scrollController) => CustomModalFit(
                  items: [
                    CustomItemModalFit(
                      text: 'Postagem',
                      iconData: AppIcons.keyboard,
                      onTap: () {
                        ExtendedNavigator.of(context)
                            .push(Routes.add_time_line_screen);
                      },
                    ),
                    CustomItemModalFit(
                      text: 'Álbum',
                      iconData: AppIcons.folder,
                      onTap: () {},
                    ),
                  ],
                ),
              );
            },
          ),
        ];
      case DEFAULT_MENU_ENUM.HOME:
        return [];
      case DEFAULT_MENU_ENUM.SEARCH:
        return [];
      case DEFAULT_MENU_ENUM.ME:
        return [
          IconButton(
            icon: CustomIcon(icon: AppIcons.bell),
            onPressed: () {
              ExtendedNavigator.of(context)
                            .push(Routes.notification);
            },
          ),
          IconButton(
            icon: CustomIcon(icon: AppIcons.bars),
            onPressed: () {
              showMaterialModalBottomSheet(
                context: context,
                builder: (context, scrollController) => CustomModalFit(
                  items: _getItemsModalFit(),
                ),
              );
            },
          ),
        ];
      case DEFAULT_MENU_ENUM.MONITORING:
        return [];
      default:
        return [];
    }
  }

  String _getStringbyScreen(ScreenManagerState state) {
    switch (state.currentScreen) {
      case DEFAULT_MENU_ENUM.HOME:
        return 'Início';
      case DEFAULT_MENU_ENUM.TIME_LINE:
        return 'Casal';
      case DEFAULT_MENU_ENUM.SEARCH:
        return '';
      case DEFAULT_MENU_ENUM.ME:
        return 'Eu';
      case DEFAULT_MENU_ENUM.MONITORING:
        return 'Dados';
      default:
        return '';
    }
  }

  bool _notAuthenticated() {
    if (getItInstance.isRegistered<UserWrapper>() &&
        (getItInstance<UserWrapper>().getUser == UserAppModel.empty)) {
      return true;
    }

    return false;
  }

  List<Widget> _getItemsModalFit() {
    var _result = [
      CustomItemModalFit(
        text: 'Curtiu o Enjoy? Avalie-nos',
        iconData: AppIcons.thumbs_up,
        onTap: () {},
      ),
      CustomItemModalFit(
        text: 'Facebook',
        iconData: AppIcons.facebook,
        onTap: () {
          _launchURL('https://www.facebook.com/Enjoy-108714310939674');
        },
      ),
      CustomItemModalFit(
        text: 'Nosso Site',
        iconData: AppIcons.window_maximize,
        onTap: () {
          _launchURL('https://mozin-2c81d.web.app/');
        },
      ),
      CustomItemModalFit(
        text: 'Configurações',
        iconData: AppIcons.cog,
        onTap: () {},
      ),
      CustomItemModalFit(
        text: 'Ajude-nos a melhorar o app',
        iconData: AppIcons.assistive_listening_systems,
        onTap: () {
          ExtendedNavigator.of(context)
                            .push(Routes.feedback);
        },
      ),
    ];

    if (!_notAuthenticated()) {
      _result.add(
        CustomItemModalFit(
          text: 'Sair',
          iconData: AppIcons.window_close,
          onTap: () {
            root<AuthenticationBloc>()..add(Logout());
          },
        ),
      );
    }

    return _result;
  }

  void _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
}
