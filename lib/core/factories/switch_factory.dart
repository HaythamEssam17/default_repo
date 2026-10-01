import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/core/widgets/common_title_text.dart';

abstract class SwitchFactory {
  Widget buildSwitch({
    required BuildContext context,
    required bool value,
    required Function(bool p1) onChanged,
    required String label,
    required String subtitle,
  });

  factory SwitchFactory(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.android:
        return AndroidSwitch();
      case TargetPlatform.iOS:
        return IOSSwitch();

      default:
        return AndroidSwitch();
    }
  }
}

class AndroidSwitch implements SwitchFactory {
  @override
  Widget buildSwitch({
    required BuildContext context,
    required bool value,
    required Function(bool p1) onChanged,
    required String label,
    required String subtitle,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTitleText(label),
              CommonTitleText(
                subtitle,
                fontSize: 12,
                color: Theme.of(context).dividerColor,
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: Theme.of(context).primaryColor,
          activeTrackColor: Theme.of(context).disabledColor,
          inactiveThumbColor: Theme.of(context).disabledColor,
          inactiveTrackColor: Theme.of(context).disabledColor,
          trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
          thumbIcon: WidgetStateProperty.all(
            Icon(Icons.circle_rounded, color: Theme.of(context).disabledColor),
          ),
        ),
      ],
    );
  }
}

class IOSSwitch implements SwitchFactory {
  @override
  Widget buildSwitch({
    required BuildContext context,
    required bool value,
    required Function(bool p1) onChanged,
    required String label,
    required String subtitle,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTitleText(label),
              CommonTitleText(
                subtitle,
                fontSize: 12,
                color: Theme.of(context).dividerColor,
              ),
            ],
          ),
        ),
        CupertinoSwitch(value: value, onChanged: onChanged),
      ],
    );
  }
}

/// Use This in UI
class PlatformSwitch {
  static Widget buildSwitch({
    required BuildContext context,
    required bool value,
    required Function(bool p1) onChanged,
    required String label,
    required String subtitle,
  }) {
    return SwitchFactory(Theme.of(context).platform).buildSwitch(
      context: context,
      value: value,
      onChanged: onChanged,
      label: label,
      subtitle: subtitle,
    );
  }
}
