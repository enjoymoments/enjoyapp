import 'package:flutter/material.dart';
import 'package:mozin/features/me/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:mozin/features/me/presentation/blocs/unsync_option/unsyncoption_cubit.dart';
import 'package:mozin/features/me/presentation/pages/widgets/connected/connected.dart';
import 'package:mozin/features/me/presentation/pages/widgets/login/widgets/me_loading.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';

class MeScreen extends StatefulWidget {
  @override
  _MeScreenState createState() => _MeScreenState();
}

class _MeScreenState extends State<MeScreen> {
  AuthenticationBloc _authenticationBloc;
  UnsyncOptionCubit _unsyncOptionCubit;

  @override
  void initState() {
    _unsyncOptionCubit = getItInstance<UnsyncOptionCubit>()..existCoupleId();
    _authenticationBloc = root<AuthenticationBloc>();

    super.initState();
  }

  @override
  void dispose() {
    _unsyncOptionCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_authenticationBloc.state.isLoading) {
      return MeLoading();
    }

    if (_authenticationBloc.state.authenticated) {
      return Connected(
        user: getItInstance<UserWrapper>().getUser,
        unsyncOptionCubit: _unsyncOptionCubit,
      );
    }

    return MeLoading();
  }
}
