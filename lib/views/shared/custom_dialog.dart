import 'package:flutter/material.dart';

Future<void> simpleDialog(BuildContext context, String title, Widget content,
    bool barrierDismissible, List<Widget> actions) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(child: content),
          actions: actions);
    },
  );
}
