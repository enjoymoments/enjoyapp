import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/views/home/home_screen.dart';
import 'package:mozin/views/more/more_screen.dart';
import 'package:mozin/views/me/me_screen.dart';
import 'package:mozin/views/shared/blocs/screen_manager/screen_manager_bloc.dart';
import 'package:mozin/views/shared/custom_scaffold.dart';
import 'package:mozin/views/shared/default_menu.dart';
import 'package:mozin/views/shared/enum/default_menu_enum.dart';
import 'package:mozin/features/time_line/presentation/pages/time_line_screen.dart';
import 'package:mozin/views/shared/extension.dart';

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
    return BlocConsumer<ScreenManagerBloc, ScreenManagerState>(
      cubit: _screenManagerBloc,
      listener: (consumerContext, state) {
        if (state.isSuccess) {
          consumerContext.showSnackBar('Opa, deu certo !');
        }
      },
      builder: (BuildContext context, ScreenManagerState state) {
        return CustomScaffold(
          child: _buildContent(state),
          appBar: _buildAppBar(state),
          bottomNavigationBar: DefaultMenu(onTap: (itemSelected) {
            _tapScreen(itemSelected);
          }),
        );
      },
    );
  }

  void _tapScreen(DEFAULT_MENU_ENUM itemSelected) {
    if (itemSelected == DEFAULT_MENU_ENUM.SEARCH) {
      ExtendedNavigator.of(context).push(Routes.interest_screen);
      return;
    }

    _screenManagerBloc.add(TapScreen(itemSelected));
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
      case DEFAULT_MENU_ENUM.MORE:
        return MoreScreen();
      case DEFAULT_MENU_ENUM.HOME:
      default:
        return HomeScreen();
    }
  }

  List<Widget> _buildActionButtons(ScreenManagerState state) {
    switch (state.currentScreen) {
      case DEFAULT_MENU_ENUM.TIME_LINE:
        return [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              ExtendedNavigator.of(context).push(Routes.add_time_line_screen);
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

  String _getStringbyScreen(ScreenManagerState state) {
    switch (state.currentScreen) {
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
