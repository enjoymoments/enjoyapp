import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/push_notification_config.dart';
import 'package:mozin/setup.dart';
import 'package:mozin/views/home/home_screen.dart';
import 'package:mozin/views/login/bloc/authentication_bloc.dart';
import 'package:mozin/views/more/more_screen.dart';
import 'package:mozin/views/notifications/notifications_screen.dart';
import 'package:mozin/views/shared/blocs/queue_post/queue_post_bloc.dart';
import 'package:mozin/views/shared/custom_scaffold.dart';
import 'package:mozin/views/shared/default_menu.dart';
import 'package:mozin/views/shared/enum/default_menu_enum.dart';
import 'package:mozin/views/time_line/add_time_line_screen.dart';
import 'package:mozin/views/time_line/time_line_screen.dart';
import 'package:mozin/views/shared/extension.dart';

class ScreenManager extends StatefulWidget {
  final AuthenticationBloc authenticationBloc;

  const ScreenManager({
    Key key,
    @required this.authenticationBloc,
  }) : super(key: key);

  @override
  _ScreenManagerState createState() => _ScreenManagerState();
}

class _ScreenManagerState extends State<ScreenManager> {
  DEFAULT_MENU_ENUM _default_menu_item = DEFAULT_MENU_ENUM.HOME;

  QueuePostBloc _queuePostBloc;

  @override
  void initState() {
    _queuePostBloc = getItInstance<QueuePostBloc>();
    _setConfigPushNotificationAsync();
    super.initState();
  }

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
    if (itemSelected == DEFAULT_MENU_ENUM.ADD) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddTimeLineScreen()),
      );
    } else {
      setState(() {
        _default_menu_item = itemSelected;
      });
    }
  }

  Widget _buildBody() {
    return BlocConsumer<QueuePostBloc, QueuePostState>(
      cubit: _queuePostBloc,
      listener: (consumerContext, state) {
        if (state.isSuccess) {
          consumerContext.showSnackBar('Opa, deu certo !');
        }
      },
      builder: (context, state) {
        switch (_default_menu_item) {
          case DEFAULT_MENU_ENUM.TIME_LINE:
            return TimeLineScreen();
          case DEFAULT_MENU_ENUM.NOTIFICATION:
            return NotificationsScreen();
          case DEFAULT_MENU_ENUM.MORE:
            return MoreScreen(
              authenticationBloc: widget.authenticationBloc,
            );
          case DEFAULT_MENU_ENUM.HOME:
          default:
            return HomeScreen();
        }
      },
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text(
        _getStringbyScreen(),
      ),
    );
  }

  String _getStringbyScreen() {
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

  //TODO:review
  void _setConfigPushNotificationAsync() async {
    try {
      PushNotificationConfig _pushNoficationConfig = PushNotificationConfig();
      var token = await _pushNoficationConfig.configureAsync();

      print('TOKEN: ' + token);
    } catch (e) {
      print(e);
    }
  }
}
