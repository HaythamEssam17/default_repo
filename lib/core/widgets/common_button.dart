import 'package:flutter/material.dart';
import 'package:pharmacy/core/factories/loading_factory.dart';
import 'package:pharmacy/core/utils/painters/button_painter.dart';

class CommonButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double height;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;

  const CommonButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height = 48.0,
    this.textStyle,
    this.padding,
  });

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  bool get _canTap =>
      widget.isEnabled && !widget.isLoading && widget.onPressed != null;

  void _onTapDown(TapDownDetails details) {
    if (_canTap) {
      _scaleController.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (_canTap) {
      _scaleController.reverse();
    }
  }

  void _onTapCancel() {
    if (_canTap) {
      _scaleController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveEnabled = widget.isEnabled && widget.onPressed != null;
    final primaryColor = widget.backgroundColor ?? theme.primaryColor;
    final disabledColor = theme.disabledColor;
    final currentBgColor = effectiveEnabled ? primaryColor : disabledColor;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: SizedBox(
        width: widget.width ?? double.infinity,
        height: widget.height,
        child: GestureDetector(
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onTapCancel: _onTapCancel,
          onTap: _canTap ? widget.onPressed : null,
          child: AnimatedBuilder(
            animation: _scaleController,
            builder: (context, child) {
              return CustomPaint(
                painter: ButtonPainter(
                  context,
                  color: currentBgColor,
                  isEnabled: effectiveEnabled,
                ),
                child: child,
              );
            },
            child: Container(
              padding:
                  widget.padding ?? const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              child: AnimatedCrossFade(
                firstChild: Center(
                  child: Text(
                    widget.text,
                    style:
                        widget.textStyle ??
                        theme.textTheme.bodyLarge?.copyWith(
                          color:
                              widget.textColor ?? theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                secondChild: Center(
                  child: PlatformLoading.buildLoading(
                    context: context,
                    color: Colors.white,
                  ),
                ),
                alignment: AlignmentDirectional.center,
                crossFadeState: widget.isLoading
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 250),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
