import 'package:flutter/material.dart';
import 'package:mozin/views/interest/widgets/interest_onboarding.dart';
import 'package:mozin/views/shared/custom_scaffold.dart';

class InterestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: _buildBody(context),
      appBar: _buildAppBar(context),
      bottomNavigationBar: null,
    );
  }

  Widget _buildBody(BuildContext context) {
    return InterestOnBoarding();
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: new Text('Interesses'),
    );
  }
}
