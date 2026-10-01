import 'package:flutter/material.dart';
import 'package:pharmacy/core/theme/app_spacing.dart';
import 'package:pharmacy/core/widgets/common_title_text.dart';

abstract class RadioFactory<T> {
  Widget buildRadio({
    required BuildContext context,
    required T value,
    required T groupValue,
    required Function(T?) onChanged,
    required String label,
    String? subtitle,
    bool isEnabled = true,
  });

  factory RadioFactory(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.iOS:
        return IOSRadio<T>();
      case TargetPlatform.android:
      default:
        return AndroidRadio<T>();
    }
  }
}

class AndroidRadio<T> implements RadioFactory<T> {
  @override
  Widget buildRadio({
    required BuildContext context,
    required T value,
    required T groupValue,
    required Function(T?) onChanged,
    required String label,
    String? subtitle,
    bool isEnabled = true,
  }) {
    return InkWell(
      onTap: isEnabled ? () => onChanged(value) : null,
      child: Row(
        children: [
          RadioGroup<T>(
            groupValue: groupValue,
            onChanged: (val) {
              if (isEnabled) onChanged(val);
            },
            child: Radio<T>(
              value: value,
              enabled: isEnabled,
              activeColor: Theme.of(context).primaryColor,
            ),
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

class IOSRadio<T> implements RadioFactory<T> {
  @override
  Widget buildRadio({
    required BuildContext context,
    required T value,
    required T groupValue,
    required Function(T?) onChanged,
    required String label,
    String? subtitle,
    bool isEnabled = true,
  }) {
    final isSelected = value == groupValue;

    return Padding(
      padding: EdgeInsetsGeometry.only(bottom: AppSpacing.md),
      child: GestureDetector(
        onTap: isEnabled ? () => onChanged(value) : null,
        child: Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? (isEnabled
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).disabledColor)
                      : Theme.of(context).disabledColor,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: isEnabled
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).disabledColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
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

class PlatformRadio {
  static Widget buildRadio<T>({
    required BuildContext context,
    required T value,
    required T groupValue,
    required Function(T?) onChanged,
    required String label,
    String? subtitle,
    bool isEnabled = true,
  }) {
    return RadioFactory<T>(Theme.of(context).platform).buildRadio(
      context: context,
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      label: label,
      subtitle: subtitle,
      isEnabled: isEnabled,
    );
  }
}
