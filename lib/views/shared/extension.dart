import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

extension Texts on String {
  Widget headline(BuildContext context,
          {double fontSize,
          TextAlign textAlign,
          double height,
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
            height: height,
            decoration: decoration,
            color: color ?? Theme.of(context).textTheme.headline5.color,
            letterSpacing: letterSpacing,
            fontWeight: fontWeight),
      );

  Widget body1(
    BuildContext context, {
    double fontSize,
    Color color,
    int maxLines,
    FontWeight fontWeight,
    TextDecoration decoration,
    double height,
  }) =>
      AutoSizeText(
        this,
        maxLines: maxLines,
        style: Theme.of(context).textTheme.bodyText2.copyWith(
            fontSize: fontSize,
            color: color,
            fontWeight: fontWeight,
            decoration: decoration,
            height: height),
      );

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
}
