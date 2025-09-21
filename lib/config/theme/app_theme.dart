import 'package:bazargan/core/constants/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = AppColors.primary;
  static const Color secondaryColor = AppColors.secondary;
  static const Color tertiaryColor = AppColors.tertiary;
  static const Color backgroundColor = AppColors.white;

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        surface: backgroundColor,
      ),

      fontFamily: 'IRANYekanX',

      scaffoldBackgroundColor: backgroundColor,

      appBarTheme: AppBarTheme(
        toolbarHeight: 60,
        surfaceTintColor: AppColors.white,
        foregroundColor: AppColors.neutralMidnight,
        centerTitle: true,
        actionsPadding: const EdgeInsets.only(left: 8),
        shape: LinearBorder.bottom(
          side: BorderSide(color: AppColors.neutralEDEDED),
        ),
        elevation: 12,
        titleTextStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: AppColors.neutralMidnight,
          fontFamily: 'IRANYekanX',
        ),
      ),
    );
  }
}
