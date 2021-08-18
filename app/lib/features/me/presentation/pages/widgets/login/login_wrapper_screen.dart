import 'package:flutter/material.dart';
import 'package:custom_view/custom_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/me/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:mozin/features/me/presentation/pages/widgets/login/login_screen.dart';
import 'package:mozin/features/me/presentation/pages/widgets/login/widgets/me_loading.dart';
import 'package:mozin/modules/config/setup.dart';

class LoginWrapperScreen extends StatelessWidget {
  const LoginWrapperScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: _buildBody(),
      appBar: _buildAppBar(),
      bottomNavigationBar: null,
    );
  }

  Widget _buildBody() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      cubit: root<AuthenticationBloc>(),
      builder: (context, state) {
        if (root<AuthenticationBloc>().state.isLoading || root<AuthenticationBloc>().state.authenticated){
          return MeLoading();
        }

        return Center(
          child: SingleChildScrollView(
            child: LoginScreen(),
          ),
        );
      },
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text('_getStringbyScreen(state),'),
      actions: [],
    );
  }
}
