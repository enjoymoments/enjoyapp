import 'package:flutter/material.dart';
import 'package:mozin/features/me/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:mozin/features/me/presentation/pages/widgets/connected/connected.dart';
import 'package:mozin/features/me/presentation/pages/widgets/login/widgets/me_loading.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';

class MeScreen extends StatelessWidget {
  const MeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (root<AuthenticationBloc>().state.isLoading!) {
      return MeLoading();
    }

    if (root<AuthenticationBloc>().state.authenticated!) {
      return Connected(
        user: getItInstance<UserWrapper>().getUser,
      );
    }

    return MeLoading();
  }
}
