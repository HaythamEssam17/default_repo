import 'package:flutter/material.dart';

abstract final class AppResponsive {
  static const double smallWidth = 360;
  static const double standardWidth = 390;
  static const double largeWidth = 430;

  static const double standardHeight = 844;

  static double width(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    debugPrint('screen width: $screenWidth');
    return screenWidth;
  }

  static double height(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    debugPrint('screen height: $screenHeight');
    return screenHeight;
  }

  static bool isSmall(BuildContext context) {
    return width(context) < standardWidth;
  }

  static bool isStandard(BuildContext context) {
    final value = width(context);
    return value >= standardWidth && value < largeWidth;
  }

  static bool isLarge(BuildContext context) {
    return width(context) >= largeWidth;
  }

  static double horizontalPadding(BuildContext context) {
    final value = width(context);
    if (value < standardWidth) {
      return 16;
    }
    if (value < largeWidth) {
      return 20;
    }
    return 24;
  }

  static double verticalPadding(BuildContext context) {
    final value = height(context);
    if (value < standardHeight) {
      return 16;
    }
    if (value < standardHeight) {
      return 20;
    }
    return 24;
  }

  static double contentMaxWidth(BuildContext context) {
    final value = width(context);
    if (value < largeWidth) {
      return value;
    }
    return 480;
  }

  static double scale(BuildContext context) {
    final value = width(context);
    return (value / standardWidth).clamp(0.90, 1.10);
  }
}
