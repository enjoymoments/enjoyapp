import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/invite/presentation/bloc/invite_cubit.dart';
import 'package:mozin/modules/shared/core_migrate/extension_utils.dart';
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
      var _inviteCubit = getItInstance<InviteCubit>();
      _inviteCubit.getUserSyncInfo(_routeSplit[2]);

      ExtendedNavigator.of(context).pushNamedIfNotCurrent(Routes.invite_screen,
          arguments: InviteScreenArguments(inviteCubit: _inviteCubit));
      return;
    }
    //TODO:review this
    //ExtendedNavigator.of(context).push(_routeName);
  }
}
