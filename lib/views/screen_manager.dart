import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/setup.dart';
import 'package:mozin/views/home/home_screen.dart';
import 'package:mozin/views/login/bloc/authentication_bloc.dart';
import 'package:mozin/views/more/more_screen.dart';
import 'package:mozin/views/me/me_screen.dart';
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
    if (itemSelected == DEFAULT_MENU_ENUM.SEARCH) {
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
        return _buildContent();
      },
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text(
        _getStringbyScreen(),
      ),
      actions: _buildActionButtons(),
    );
  }

  Widget _buildContent() {
    switch (_default_menu_item) {
      case DEFAULT_MENU_ENUM.TIME_LINE:
        return TimeLineScreen();
      case DEFAULT_MENU_ENUM.ME:
        return MeScreen();
      case DEFAULT_MENU_ENUM.MORE:
        return MoreScreen(
          authenticationBloc: widget.authenticationBloc,
        );
      case DEFAULT_MENU_ENUM.HOME:
      default:
        return HomeScreen();
    }
  }

  List<Widget> _buildActionButtons() {
    switch (_default_menu_item) {
      case DEFAULT_MENU_ENUM.TIME_LINE:
        return [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTimeLineScreen()),
              );
            },
          ),
        ];
      case DEFAULT_MENU_ENUM.HOME:
      case DEFAULT_MENU_ENUM.SEARCH:
      case DEFAULT_MENU_ENUM.ME:
      case DEFAULT_MENU_ENUM.MORE:
        return [];
      default:
        return [];
    }
  }

  String _getStringbyScreen() {
    switch (_default_menu_item) {
      case DEFAULT_MENU_ENUM.HOME:
        return 'Início';
      case DEFAULT_MENU_ENUM.TIME_LINE:
        return 'Linha';
      case DEFAULT_MENU_ENUM.SEARCH:
        return '';
      case DEFAULT_MENU_ENUM.ME:
        return 'Eu';
      case DEFAULT_MENU_ENUM.MORE:
        return 'Mais';
      default:
        return '';
    }
  }
}
