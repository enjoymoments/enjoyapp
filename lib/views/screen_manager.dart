import 'package:flutter/material.dart';
import 'package:mozin/views/home/home.dart';
import 'package:mozin/views/more/more.dart';
import 'package:mozin/views/notifications/notifications.dart';
import 'package:mozin/views/shared/custom_scaffold.dart';
import 'package:mozin/views/shared/default_menu.dart';
import 'package:mozin/views/shared/enum/default_menu_enum.dart';
import 'package:mozin/views/time_line/time_line.dart';

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
    if (itemSelected == DEFAULT_MENU_ENUM.NOTIFICATION) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Notifications()),
      );
    } else if (itemSelected == DEFAULT_MENU_ENUM.MORE) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => More()),
      );
    } else {
      setState(() {
        _default_menu_item = itemSelected;
      });
    }
  }

  Widget _buildBody() {
    switch (_default_menu_item) {
      case DEFAULT_MENU_ENUM.TIME_LINE:
        return TimeLine();
      case DEFAULT_MENU_ENUM.HOME:
        return Home();
      case DEFAULT_MENU_ENUM.NOTIFICATION:
        break;
      case DEFAULT_MENU_ENUM.MORE:
        break;
    }
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Início'),
    );
  }
}
