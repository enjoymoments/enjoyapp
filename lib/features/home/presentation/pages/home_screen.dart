import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/extension.dart';
import 'package:mozin/package_view/spacer_box.dart';

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
    return CustomContainer(
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (_user == UserAppModel.empty) {
      return Center(
        child: "Olá,\nSeja bem vindo".labelIntro(context),
      );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          'Olá,\n${_user.name}'.labelIntro(context),
          SpacerBox.v16,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _generateItem(context, Routes.calendar, 'Calendário'),
              SpacerBox.h16,
              _generateItem(context, Routes.calendar, 'Sugestões'),
            ],
          ),
        ],
      ),
    );
  }

  //TODO:review this - create widget
  Widget _generateItem(BuildContext context, String routeName, String name) {
    return GestureDetector(
      onTap: () {
        ExtendedNavigator.of(context).push(routeName);
      },
      child: Container(
        alignment: Alignment.center,
        width: SizeConfig.sizeByPixel(140),
        height: SizeConfig.sizeByPixel(120),
        decoration: BoxDecoration(
          color: Theme.of(context).hintColor,
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: name.label(
          context,
        ),
      ),
    );
  }
}
