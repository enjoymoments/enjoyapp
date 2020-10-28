import 'package:flutter/material.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:mozin/package_view/custom_avatar.dart';
import 'package:mozin/package_view/spacer_box.dart';
import 'package:mozin/package_view/extension.dart';

class CustomAvatarWithName extends StatelessWidget {
  final ImageProvider backgroundImage;
  final Widget child;

  const CustomAvatarWithName({Key key, this.child, this.backgroundImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomAvatar(
          backgroundImage: backgroundImage,
        ),
        SpacerBox.h8,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildName(context),
            SpacerBox.v2,
            child ?? SizedBox.shrink(),
          ],
        ),
      ],
    );
  }

  Widget _buildName(BuildContext context) {
    final UserAppModel _user = getItInstance<UserWrapper>().getUser;
    return 'Felipe Augusto'.label(context);
    //return _user.name.description(context);
  }
}
