import 'package:auto_size_text/auto_size_text.dart';
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

extension Texts on String {
  Widget description(BuildContext context,
          {double fontSize = 14,
          TextAlign textAlign,
          int maxLines,
          Color color,
          TextDecoration decoration,
          double letterSpacing,
          FontWeight fontWeight}) =>
      AutoSizeText(
        this,
        textAlign: textAlign,
        maxLines: maxLines,
        style: Theme.of(context).textTheme.headline5.copyWith(
            fontSize: fontSize,
            decoration: decoration,
            color: color ?? Theme.of(context).textTheme.headline5.color,
            letterSpacing: letterSpacing,
            fontWeight: fontWeight),
      );

  Widget date(
    BuildContext context, {
    double fontSize = 13,
    Color color,
    int maxLines,
    double letterSpacing,
    FontWeight fontWeight,
  }) {
    return AutoSizeText(
      this,
      maxLines: maxLines,
      style: Theme.of(context).textTheme.headline6.copyWith(
            fontSize: fontSize,
            color: color,
            letterSpacing: letterSpacing,
            fontWeight: fontWeight,
          ),
    );
  }

  Widget title(
    BuildContext context, {
    double fontSize,
    Color color,
    int maxLines,
    double letterSpacing,
    FontWeight fontWeight,
  }) {
    return AutoSizeText(
      this,
      maxLines: maxLines,
      style: Theme.of(context).textTheme.headline6.copyWith(
            fontSize: fontSize,
            color: color,
            letterSpacing: letterSpacing,
            fontWeight: fontWeight,
          ),
    );
  }

  Widget label(
    BuildContext context, {
    double fontSize = 17,
    Color color,
    int maxLines,
    double letterSpacing,
    FontWeight fontWeight,
  }) {
    return AutoSizeText(
      this,
      maxLines: maxLines,
      style: Theme.of(context).textTheme.headline6.copyWith(
            fontSize: fontSize,
            color: color,
            letterSpacing: letterSpacing,
            fontWeight: fontWeight,
          ),
    );
  }
}
