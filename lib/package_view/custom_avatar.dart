import 'package:flutter/material.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';

class CustomAvatar extends StatelessWidget {
  final ImageProvider backgroundImage;
  final double radius;

  const CustomAvatar({
    Key key,
    this.backgroundImage,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius ?? SizeConfig.sizeByPixel(18),
      backgroundColor: Theme.of(context).primaryColor,
      backgroundImage: backgroundImage ?? _getImageAvatar(),
    );
  }

  ImageProvider _getImageAvatar() {
    final UserAppModel _user = getItInstance<UserWrapper>().getUser;

    if (_user.photo != null && _user.photo.isNotEmpty) {
      return NetworkImage(_user.photo);
    }

    return AssetImage('assets/images/default_avatar.png');
  }
}
