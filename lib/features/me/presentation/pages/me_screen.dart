import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/me/presentation/pages/widgets/connected/connected.dart';
import 'package:mozin/features/me/presentation/pages/widgets/connected/cubit/connected_cubit.dart';
import 'package:mozin/features/me/presentation/pages/widgets/login/bloc/authentication_bloc.dart';
import 'package:mozin/features/me/presentation/pages/widgets/login/login_screen.dart';
import 'package:mozin/features/me/presentation/pages/widgets/login/widgets/me_loading.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';

class MeScreen extends StatefulWidget {
  @override
  _MeScreenState createState() => _MeScreenState();
}

class _MeScreenState extends State<MeScreen> {
  AuthenticationBloc _authenticationBloc;
  ConnectedCubit _connectedCubit;

  @override
  void initState() {
    _authenticationBloc = root<AuthenticationBloc>()
      ..add(CheckAuthenticated());
    
    _connectedCubit = getItInstance<ConnectedCubit>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _connectedCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      cubit: _authenticationBloc,
      builder: (BuildContext context, AuthenticationState state) {
        if (state.isLoading) {
          return MeLoading();
        }

        if (state.authenticated) {
          _connectedCubit.loadAds();

          return Connected(
            user: getItInstance<UserWrapper>().getUser,
            connectedCubit: _connectedCubit, 
          );
        }

        if (!state.authenticated) {
          return Center(
            child: SingleChildScrollView(
              child: LoginScreen(),
            ),
          );
        }

        return MeLoading();
      },
    );
  }
}
