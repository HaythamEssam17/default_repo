import 'package:flutter/material.dart';

class CommonTitleText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final Color? color;
  final double fontSize;

  const CommonTitleText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.color,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style:
          style ??
          theme.textTheme.bodyMedium!.copyWith(
            color: color ?? theme.primaryColor,
            fontSize: fontSize,
          ),
    );
  }
}
