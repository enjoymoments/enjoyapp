import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/me/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:mozin/features/me/presentation/pages/widgets/login/login_wrapper_screen.dart';
import 'package:mozin/features/screen_manager/presentation/root_screen_manager.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/custom_view_migrate/onboading_screen.dart';
import 'package:mozin/modules/shared/general/services/local_storage_service.dart';
import 'package:mozin_core/constants.dart';
import 'package:custom_utilities/custom_utilities.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      bloc: root<AuthenticationBloc>(),
      buildWhen: (previous, current) {
        return previous.authenticated != current.authenticated ||
            previous.closeOnboardingScreen != current.closeOnboardingScreen;
      },
      builder: (context, state) {
        if (state.authenticated!) {
          return RootScreenManager();
        }

        return _buildRedirectToPage();
      },
    );
  }

  Widget _buildRedirectToPage() {
    var __localStorageService = getItInstance<LocalStorageService>();
    if (__localStorageService.containsKey(bypass_onboarding_screen)) {
      return LoginWrapperScreen();
    }

    __localStorageService.put(KeyValue<String, String>(
        key: bypass_onboarding_screen, value: bypass_onboarding_screen));

    return OnBoardingScreen();
  }
}
