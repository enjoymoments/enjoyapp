import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/me/presentation/pages/widgets/connected/connected.dart';
import 'package:mozin/features/me/presentation/pages/widgets/login/bloc/authentication_bloc.dart';
import 'package:mozin/features/me/presentation/pages/widgets/login/login_screen.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:mozin/package_view/custom_circular_progress_indicador.dart';
import 'package:mozin/package_view/extension.dart';

class MeScreen extends StatefulWidget {
  @override
  _MeScreenState createState() => _MeScreenState();
}

class _MeScreenState extends State<MeScreen> {
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    _authenticationBloc = getItInstance<AuthenticationBloc>()
      ..add(CheckAuthenticated());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      cubit: _authenticationBloc,
      listener: (BuildContext context, AuthenticationState state) {
        if (state is Error) {
          context.showSnackBar('message');
        }
      },
      builder: (BuildContext context, AuthenticationState state) {
        if (state.isLoading) {
          return CustomCircularProgressIndicator();
        }

        if (!state.unauthenticated) {
          return Connected(
            user: getItInstance<UserWrapper>().getUser,
          );
        }

        if (state.unauthenticated) {
          return Center(
            child: SingleChildScrollView(
              child: LoginScreen(),
            ),
          );
        }

        return SizedBox.shrink();
      },
    );
  }
}
