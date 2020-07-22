import 'package:flutter/material.dart';
import 'package:mozin/app_colors.dart';

ThemeData getTheme(BuildContext context) {
  return ThemeData(
    fontFamily: 'Abel',
    appBarTheme: AppBarTheme(
      color: AppColors.primary,
      iconTheme: IconThemeData(
        color: AppColors.secundary,
      ),
    ),
    primaryColor: AppColors.primary,
    backgroundColor: AppColors.secundary,
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
