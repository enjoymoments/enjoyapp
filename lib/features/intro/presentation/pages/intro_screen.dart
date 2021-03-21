import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/intro/presentation/bloc/intro_bloc.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/package_view/custom_circular_progress_indicador.dart';
import 'package:mozin/package_view/custom_scaffold.dart';
import 'package:mozin/package_view/extension.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  IntroBloc _introBloc;

  @override
  void initState() {
    _introBloc = getItInstance<IntroBloc>()..add(VerifyScreen());
    super.initState();
  }

  @override
  void dispose() {
    _introBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IntroBloc, IntroState>(
      cubit: _introBloc,
      listener: (context, state) {
        if (state is Error) {
          context.showSnackBar('Ops... houve um erro ao tentar logar');
        } else if (state.redirectOnboarding) {
          ExtendedNavigator.of(context).pushAndRemoveUntil(Routes.onboarding_screen, (route) => false);
        } else if (state.redirectHome) {
          ExtendedNavigator.of(context).pushAndRemoveUntil(Routes.screen_manager_screen, (route) => false);
        }
      },
      builder: (BuildContext context, IntroState state) {
        if (state.isLoading) {
          return CustomScaffold(
            backgroundColor: Theme.of(context).primaryColor,
            appBar: null,
            bottomNavigationBar: null,
            child: CustomCircularProgressIndicator(),
          );
        }

        return SizedBox.shrink();
      },
    );
  }
}
