import 'package:flutter/material.dart';
import 'package:mozin/modules/config/app_colors.dart';

ThemeData getTheme(BuildContext context) {
  return ThemeData(
    fontFamily: 'Abel',
    appBarTheme: AppBarTheme(
      color: AppColors.primary,
      iconTheme: IconThemeData(
        color: AppColors.secundary,
      ),
    ),
    iconTheme: IconThemeData(
      size: 18.0,
      color: AppColors.iconsColor,
    ),
    hintColor: AppColors.hintColor,
    bottomAppBarColor: AppColors.menuColor,
    primaryColor: AppColors.primary,
    backgroundColor: AppColors.secundary,
    textTheme: TextTheme(
      headline5: TextStyle(color: AppColors.iconsColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.primary,
          width: 1.5,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.primary,
          width: 1.5,
        ),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.primary,
          width: 1.5,
        ),
      ),
    ),
  );
}
