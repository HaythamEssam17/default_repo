import 'package:flutter/material.dart';
import 'package:pharmacy/core/responsive/app_responsive.dart';

extension ResponsiveContext on BuildContext {
  double get screenWidth {
    return AppResponsive.width(this);
  }

  double get screenHeight {
    return AppResponsive.height(this);
  }

  bool get isSmallScreen {
    return AppResponsive.isSmall(this);
  }

  bool get isStandardScreen {
    return AppResponsive.isStandard(this);
  }

  bool get isLargeScreen {
    return AppResponsive.isLarge(this);
  }

  double get horizontalPadding {
    return AppResponsive.horizontalPadding(this);
  }

  double get verticalPadding {
    return AppResponsive.verticalPadding(this);
  }

  double get contentMaxWidth {
    return AppResponsive.contentMaxWidth(this);
  }

  double get responsiveScale {
    return AppResponsive.scale(this);
  }
}
