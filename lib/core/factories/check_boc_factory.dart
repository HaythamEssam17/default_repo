import 'package:flutter/material.dart';
import 'package:pharmacy/core/theme/app_spacing.dart';
import 'package:pharmacy/core/widgets/common_title_text.dart';

abstract class CheckboxFactory {
  Widget buildCheckbox({
    required BuildContext context,
    required bool value,
    required Function(bool?) onChanged,
    required String label,
    String? subtitle,
    bool isEnabled = true,
  });

  factory CheckboxFactory(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.iOS:
        return IOSCheckbox();
      case TargetPlatform.android:
      default:
        return AndroidCheckbox();
    }
  }
}

class AndroidCheckbox implements CheckboxFactory {
  @override
  Widget buildCheckbox({
    required BuildContext context,
    required bool value,
    required Function(bool?) onChanged,
    required String label,
    String? subtitle,
    bool isEnabled = true,
  }) {
    return InkWell(
      onTap: isEnabled ? () => onChanged(!value) : null,
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: isEnabled ? onChanged : null,
            activeColor: Theme.of(context).primaryColor,
          ),
          SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTitleText(
                  label,
                  color: isEnabled ? null : Theme.of(context).disabledColor,
                ),
                if (subtitle != null)
                  CommonTitleText(
                    subtitle,
                    fontSize: 12,
                    color: Theme.of(context).dividerColor,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IOSCheckbox implements CheckboxFactory {
  @override
  Widget buildCheckbox({
    required BuildContext context,
    required bool value,
    required Function(bool?) onChanged,
    required String label,
    String? subtitle,
    bool isEnabled = true,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.md),
      child: GestureDetector(
        onTap: isEnabled ? () => onChanged(!value) : null,
        child: Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: value
                      ? (isEnabled
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).primaryColorLight)
                      : Theme.of(context).primaryColorLight,
                  width: 2,
                ),
                color: value
                    ? (isEnabled
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).dividerColor)
                    : Colors.transparent,
              ),
              child: value
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
            SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonTitleText(
                    label,
                    color: isEnabled ? null : Theme.of(context).disabledColor,
                  ),
                  if (subtitle != null)
                    CommonTitleText(
                      subtitle,
                      fontSize: 12,
                      color: Theme.of(context).dividerColor,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlatformCheckbox {
  static Widget buildCheckbox({
    required BuildContext context,
    required bool value,
    required Function(bool?) onChanged,
    required String label,
    String? subtitle,
    bool isEnabled = true,
  }) {
    return CheckboxFactory(Theme.of(context).platform).buildCheckbox(
      context: context,
      value: value,
      onChanged: onChanged,
      label: label,
      subtitle: subtitle,
      isEnabled: isEnabled,
    );
  }
}
