import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/setup.dart';
import 'package:mozin/views/intro/bloc/intro_bloc.dart';
import 'package:mozin/views/me/widgets/login/bloc/authentication_bloc.dart';
import 'package:mozin/views/onboading.dart';
import 'package:mozin/views/screen_manager.dart';
import 'package:mozin/views/shared/blocs/default_state.dart';
import 'package:mozin/views/shared/custom_circular_progress_indicador.dart';
import 'package:mozin/views/shared/custom_scaffold.dart';
import 'package:mozin/views/shared/extension.dart';

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
    return BlocConsumer<IntroBloc, DefaultState>(
      cubit: _introBloc,
      listener: (context, state) {
        if (state is Error) {
          context.showSnackBar('Ops... houve um erro ao tentar logar');
        } else if (state is RedirectOnboarding) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => OnBoardingPage()),
            (route) => false,
          );
        } else if (state is RedirectHome) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => ScreenManager(
                authenticationBloc: getItInstance<AuthenticationBloc>(),
              ),
            ),
            (route) => false,
          );
        }
      },
      builder: (BuildContext context, DefaultState state) {
        if (state is Loading) {
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
