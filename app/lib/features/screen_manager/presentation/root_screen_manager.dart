import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/screen_manager/presentation/bloc/screen_manager_bloc.dart';
import 'package:mozin/features/time_line/presentation/pages/widgets/time_line_avatar.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:custom_view/size_config.dart';
import 'package:mozin/modules/shared/firebase/firebase_dynamic_links.dart';
import 'package:mozin/modules/shared/general/enums.dart';
import 'package:mozin/modules/shared/user/services/user_service.dart';
import 'package:custom_view/AppIcons.dart';
import 'package:custom_view/custom_icon.dart';
import 'package:custom_view/custom_scaffold.dart';
import 'package:custom_view/fab/fab_bottom_app_bar.dart';

class RootScreenManager extends StatefulWidget {
  @override
  _RootScreenManagerState createState() => _RootScreenManagerState();
}

class _RootScreenManagerState extends State<RootScreenManager> {
  ScreenManagerBloc _screenManagerBloc;

  @override
  void initState() {
    _screenManagerBloc = getItInstance<ScreenManagerBloc>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getItInstance<ConfigureFirebaseDynamicLinks>()..initDynamicLinks(context);

    super.didChangeDependencies();
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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            onPressed: () {
              _screenManagerBloc
                  .add(TapScreen(DefaultMenuEnum.Search, context));
            },
            child: Icon(
              AppIcons.search,
              color:
                  Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
            ),
            tooltip: 'search',
          ),
          bottomNavigationBar: FABBottomAppBar(
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            color:
                Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
            selectedColor:
                Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
            iconSize: Theme.of(context).iconTheme.size,
            centerItemText: '',
            height: SizeConfig.sizeByPixel(50),
            notchedShape: CircularNotchedRectangle(),
            onTabSelected: (index) {
              _screenManagerBloc.add(
                TapScreen(DefaultMenuEnum(index, ignoreSearch: true), context),
              );
            },
            items: [
              FABBottomAppBarItem(iconData: AppIcons.heart, text: 'Casal'),
              FABBottomAppBarItem(iconData: AppIcons.calendar, text: 'Calendário'),
              FABBottomAppBarItem(iconData: AppIcons.bookmark, text: 'Favoritos'),
              FABBottomAppBarItem(iconData: AppIcons.user, text: 'Eu'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAppBar(ScreenManagerState state) {
    if (state.currentScreen == DefaultMenuEnum.TimeLine) {
      return AppBar(
        leadingWidth: SizeConfig.sizeByPixel(55),
        leading: TimeLineAvatar(),
        title: TimeLineText(),
        actions: [
          TimeLineAddActions(),
        ],
      );
    }

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
        if (getItInstance<UserService>().notAuthenticated()) {
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
      case DefaultMenuEnum.Calendar:
              if (getItInstance<UserService>().notAuthenticated()) {
          return [];
        }
        return [
          IconButton(
          icon: CustomIcon(icon: AppIcons.plus),
          onPressed: () {
            ExtendedNavigator.of(context).push(Routes.add_calendar_screen);
          },
        ),
        ];
      case DefaultMenuEnum.Search:
        return [];
      case DefaultMenuEnum.Me:
        return [];
      case DefaultMenuEnum.Favorites:
        return [];
      default:
        return [];
    }
  }

  String _getStringbyScreen(ScreenManagerState state) {
    switch (state.currentScreen) {
      case DefaultMenuEnum.Calendar:
        return 'Calendário';
      case DefaultMenuEnum.Search:
        return '';
      case DefaultMenuEnum.Me:
        return 'Eu';
      case DefaultMenuEnum.Favorites:
        return 'Favoritos';
      default:
        return '';
    }
  }
}
