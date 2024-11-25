// ignore_for_file: avoid_hard_coded_colors
import 'package:flutter/material.dart';

import '../../app.dart';

class AppColors {
  const AppColors({
    required this.primaryColor,
    required this.secondaryColor,
    required this.primaryTextColor,
    required this.secondaryTextColor,
    required this.primaryGradient,
  });

  static late AppColors current;

  final Color primaryColor;
  final Color secondaryColor;
  final Color primaryTextColor;
  final Color secondaryTextColor;

  /// gradient
  final LinearGradient primaryGradient;

  static const defaultAppColor = AppColors(
    primaryColor: Color.fromARGB(255, 6, 127, 227),
    secondaryColor: Color.fromARGB(255, 150, 198, 255),
    primaryTextColor: Color.fromARGB(255, 6, 172, 227),
    secondaryTextColor: Color.fromARGB(255, 62, 62, 70),
    primaryGradient: LinearGradient(colors: [Color.fromARGB(255, 6, 127, 227), Color.fromARGB(255, 150, 198, 255),Color.fromARGB(255, 198, 226, 255)]),
  );

  static const darkThemeColor = AppColors(
    primaryColor: Color.fromARGB(255, 34, 59, 87),
    secondaryColor: Color.fromARGB(255, 150, 198, 255),
    primaryTextColor: Color.fromARGB(255, 6, 172, 227),
    secondaryTextColor: Color.fromARGB(255, 62, 62, 70),
    primaryGradient: LinearGradient(colors: [Color.fromARGB(255, 6, 127, 227), Color.fromARGB(255, 150, 198, 255),Color.fromARGB(255, 198, 226, 255)]),
  );

  static AppColors of(BuildContext context) {
    final appColor = Theme.of(context).appColor;
    current = appColor;
    return current;
  }

  AppColors copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? primaryTextColor,
    Color? secondaryTextColor,
    LinearGradient? primaryGradient,
  }) {
    return AppColors(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      primaryTextColor: primaryTextColor ?? this.primaryTextColor,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      primaryGradient: primaryGradient ?? this.primaryGradient,
    );
  }
}
