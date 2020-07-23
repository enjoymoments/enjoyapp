import 'package:flutter/material.dart';
import 'package:mozin/views/shared/custom_menu.dart';

class CustomScaffold extends StatelessWidget {
  final Widget child;
  final AppBar appBar;
  final Widget bottomNavigationBar;

  const CustomScaffold(
      {Key key,
      @required this.child,
      @required this.appBar,
      this.bottomNavigationBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: appBar,
      body: child,
      bottomNavigationBar: bottomNavigationBar ?? CustomMenu(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          size: 24.0,
        ),
        elevation: 2.0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
