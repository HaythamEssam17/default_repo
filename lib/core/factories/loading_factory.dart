import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/core/theme/app_spacing.dart';

abstract class LoadingFactory {
  Widget buildLoading({required BuildContext context});

  factory LoadingFactory(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.android:
        return AndroidLoading();
      case TargetPlatform.iOS:
        return IOSLoading();

      default:
        return AndroidLoading();
    }
  }
}

class AndroidLoading implements LoadingFactory {
  @override
  Widget buildLoading({required BuildContext context}) {
    return CircularProgressIndicator.adaptive(
      backgroundColor: Theme.of(context).hoverColor,
      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
    );
  }
}

class IOSLoading implements LoadingFactory {
  @override
  Widget buildLoading({required BuildContext context}) {
    return CupertinoActivityIndicator.partiallyRevealed(
      radius: AppSpacing.radiusMd,
      color: Theme.of(context).primaryColor,
    );
  }
}

/// Use This in UI
class PlatformLoading {
  static Widget buildLoading({required BuildContext context}) {
    return LoadingFactory(
      Theme.of(context).platform,
    ).buildLoading(context: context);
  }
}
