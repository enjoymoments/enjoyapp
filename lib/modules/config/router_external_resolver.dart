import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/user_action/presentation/bloc/user_action/user_action_cubit.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/general/enums.dart';

class RouterExternalResolver {
  void resolver(
    BuildContext context, {
    @required String path,
  }) {
    var _routeSplit = path.split('/');
    var _routeName = _routeSplit[1];

    if (_routeName == DynamicLinksTypeEnum.Sync.value) {
      var _userActionCubit = getItInstance<UserActionCubit>();
      //TODO:review this
      ///_userActionCubit.syncUser(_routeSplit[2]);

      ExtendedNavigator.of(context).push(Routes.invite_screen,
          arguments: InviteScreenArguments(userActionCubit: _userActionCubit));
      return;
    }
    //TODO:review this
    //ExtendedNavigator.of(context).push(_routeName);
  }
}
