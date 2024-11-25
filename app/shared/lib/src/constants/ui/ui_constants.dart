import 'package:flutter/services.dart';

class UiConstants {
  const UiConstants._();

  /// shimmer
  /// số items load giả lập tạo hiệu ứng shimmer
  static const shimmerItemCount = 20;

  /// material app
  static const materialAppTitle = 'My App';
// ignore: avoid_hard_coded_colors
  static const taskMenuMaterialAppColor = Color.fromARGB(255, 6, 147, 227);

  /// orientation
  static const mobileOrientation = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ];

  static const tabletOrientation = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ];

  /// status bar color
  static const systemUiOverlay = SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
// ignore: avoid_hard_coded_colors
    statusBarColor: Color.fromARGB(255, 6, 147, 227),
  );

  static const textFieldTextStyleHeight = 1.3;

  static const imageDefaultService = '';
}
