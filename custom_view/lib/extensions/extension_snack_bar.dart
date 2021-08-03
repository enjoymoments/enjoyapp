import 'package:flutter/material.dart';

extension Snackbar on BuildContext {
  void showSnackBar(String message) {
    Scaffold.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message)),
      );
  }
}