import 'package:flutter/material.dart';
import 'package:mozin/views/home/home_screen.dart';
import 'package:mozin/views/more/more_screen.dart';
import 'package:mozin/views/notifications/notifications_screen.dart';
import 'package:mozin/views/shared/custom_scaffold.dart';
import 'package:mozin/views/shared/default_menu.dart';
import 'package:mozin/views/shared/enum/default_menu_enum.dart';
import 'package:mozin/views/time_line/time_line_screen.dart';

class ScreenManager extends StatefulWidget {
  @override
  _ScreenManagerState createState() => _ScreenManagerState();
}

class _ScreenManagerState extends State<ScreenManager> {
  DEFAULT_MENU_ENUM _default_menu_item = DEFAULT_MENU_ENUM.HOME;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: _buildBody(),
      appBar: _buildAppBar(),
      bottomNavigationBar: DefaultMenu(onTap: (itemSelected) {
        _tapScreen(itemSelected);
      }),
    );
  }

  void _tapScreen(DEFAULT_MENU_ENUM itemSelected) {
    setState(() {
      _default_menu_item = itemSelected;
    });
  }

  Widget _buildBody() {
    switch (_default_menu_item) {
      case DEFAULT_MENU_ENUM.TIME_LINE:
        return TimeLineScreen();
      case DEFAULT_MENU_ENUM.NOTIFICATION:
        return NotificationsScreen();
      case DEFAULT_MENU_ENUM.MORE:
        return MoreScreen();
      case DEFAULT_MENU_ENUM.HOME:
      default:
        return HomeScreen();
    }
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(getStringbyScreen()),
    );
  }

  String getStringbyScreen() {
    switch (_default_menu_item) {
      case DEFAULT_MENU_ENUM.HOME:
        return 'Início';
      case DEFAULT_MENU_ENUM.TIME_LINE:
        return 'Linha';
      case DEFAULT_MENU_ENUM.ADD:
        break;
      case DEFAULT_MENU_ENUM.NOTIFICATION:
        return 'Notificação';
      case DEFAULT_MENU_ENUM.MORE:
        return 'Mais';
    }
  }
}
