import 'package:flutter/material.dart';
import 'package:mozin/modules/shared/models/user_app_model.dart';
import 'package:mozin/setup.dart';
import 'package:mozin/views/day_one/day_one_screen.dart';
import 'package:mozin/views/shared/custom_container.dart';
import 'package:mozin/views/shared/extension.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserAppModel _user;

  @override
  void initState() {
    _user = getItInstance<UserAppModel>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return CustomContainer(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DayOneScreen()),
          );
        },
        child: Center(
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_user.id == null || _user.id.isEmpty) {
      return "Olá,\nSeja bem vindo".labelIntro(context);
    }

    return 'Olá,\n${_user.name}'.labelIntro(context);
  }
}
