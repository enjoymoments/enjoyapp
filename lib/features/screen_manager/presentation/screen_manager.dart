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
import 'package:mozin/modules/shared/general/enums.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/custom_icon.dart';
import 'package:mozin/package_view/custom_item_modal_fit.dart';
import 'package:mozin/package_view/custom_modal_fit.dart';
import 'package:mozin/package_view/custom_scaffold.dart';
import 'package:mozin/features/time_line/presentation/pages/time_line_screen.dart';
import 'package:mozin/package_view/fab/fab_bottom_app_bar.dart';
import 'package:mozin/package_view/fab/layout.dart';
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

          //In test
          floatingActionButton: _buildFab(context),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: FABBottomAppBar(
            centerItemText: '',
            color: Theme.of(context).iconTheme.color,
            selectedColor: Theme.of(context).primaryColor,
            iconSize: 18,
            notchedShape: CircularNotchedRectangle(),
            onTabSelected: (index) {
              _screenManagerBloc.add(TapScreen(
                  DefaultMenuEnum(index, ignoreSearch: true), context));
            },
            items: [
              FABBottomAppBarItem(iconData: AppIcons.home, text: 'Início'),
              FABBottomAppBarItem(iconData: AppIcons.seedling, text: 'Casal'),
              FABBottomAppBarItem(iconData: AppIcons.user, text: 'Eu'),
              FABBottomAppBarItem(iconData: AppIcons.bell, text: 'Alertas'),
            ],
          ),
          //Before
          // bottomNavigationBar: DefaultMenu(onTap: (itemSelected) {
          //   _screenManagerBloc.add(TapScreen(itemSelected, context));
          // }),
        );
      },
    );
  }

  Widget _buildFab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _screenManagerBloc.add(TapScreen(DefaultMenuEnum.Search, context));
      },
      tooltip: 'Increment',
      child: Image.asset(
        'assets/icons/icon.png',
        fit: BoxFit.fill,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 2.0,
    );

    //TODO: in development
    // final icons = [Icons.sms, Icons.mail, Icons.phone];

    // return AnchoredOverlay(
    //   showOverlay: true,
    //   overlayBuilder: (context, offset) {
    //     return CenterAbout(
    //       position: Offset(offset.dx, offset.dy - icons.length * 35.0),
    //       child: FabWithIcons(
    //         icons: icons,
    //         onIconTapped: (index) {},
    //       ),
    //     );
    //   },
    //   child: FloatingActionButton(
    //     onPressed: () {
    //       _screenManagerBloc.add(TapScreen(DefaultMenuEnum.Search, context));
    //     },
    //     tooltip: 'Increment',
    //     child: Image.asset(
    //       'assets/icons/icon.png',
    //       fit: BoxFit.fill,
    //     ),
    //     backgroundColor: Theme.of(context).primaryColor,
    //     elevation: 2.0,
    //   ),
    // );
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
    return state.contents[state.currentScreen];
  }

  List<Widget> _buildActionButtons(ScreenManagerState state) {
    switch (state.currentScreen) {
      case DefaultMenuEnum.TimeLine:
        if (_notAuthenticated()) {
          return [];
        }
        return [
          IconButton(
            icon: CustomIcon(icon: AppIcons.plus),
            onPressed: () {
              ExtendedNavigator.of(context).push(Routes.add_time_line_screen);
            },
          ),
        ];
      case DefaultMenuEnum.Home:
        return [];
      case DefaultMenuEnum.Search:
        return [];
      case DefaultMenuEnum.Me:
        return [
          //TODO:in development
          // IconButton(
          //   icon: CustomIcon(icon: AppIcons.bell),
          //   onPressed: () {
          //     ExtendedNavigator.of(context).push(Routes.notification_screen);
          //   },
          // ),
          IconButton(
            icon: CustomIcon(icon: AppIcons.bars),
            onPressed: () {
              showMaterialModalBottomSheet(
                context: context,
                builder: (context) => CustomModalFit(
                  items: _getItemsModalFit(),
                ),
              );
            },
          ),
        ];
      case DefaultMenuEnum.Alert:
        return [];
      default:
        return [];
    }
  }

  String _getStringbyScreen(ScreenManagerState state) {
    switch (state.currentScreen) {
      case DefaultMenuEnum.Home:
        return 'Início';
      case DefaultMenuEnum.TimeLine:
        return 'Casal';
      case DefaultMenuEnum.Search:
        return '';
      case DefaultMenuEnum.Me:
        return 'Eu';
      case DefaultMenuEnum.Alert:
        return 'Alertas';
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
        text: 'Mais sobre nós',
        iconData: AppIcons.info_circle,
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
                    _launchURL('https://mozin-2c81d.web.app/');
                  },
                ),
              ],
            ),
          );
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
