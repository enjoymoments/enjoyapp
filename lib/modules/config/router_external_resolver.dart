import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/invite/presentation/bloc/invite_cubit.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/general/enums.dart';

class RouterExternalResolver {
  void resolver(
    BuildContext context, {
    @required String path,
  }) {
    var _routeSplit = path.split('/');
    var _routeName = _routeSplit[1];
    
    if(_routeName == DynamicLinksTypeEnum.Sync.value) {
      getItInstance<InviteCubit>().syncUser(_routeSplit[2]);
      return;
    }
    //TODO:review this
    //ExtendedNavigator.of(context).push(_routeName);
  }
}
