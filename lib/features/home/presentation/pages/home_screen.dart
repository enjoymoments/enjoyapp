import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/extension.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserAppModel _user;

  @override
  void initState() {
    _user = getItInstance<UserWrapper>().getUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return CustomContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildAnimation(),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildAnimation() {
    return Container(
      height: 250,
      child: FlareActor("assets/animations/welcome.flr",
          alignment: Alignment.center,
          fit: BoxFit.contain,
          animation: "couple"),
    );
  }

  Widget _buildContent() {
    if (_user.id == null || _user.id.isEmpty) {
      return "Olá,\nSeja bem vindo".labelIntro(context);
    }

    return 'Olá,\n${_user.name}'.labelIntro(context);
  }
}
