import 'package:flutter/material.dart';
import 'package:bazargan/core/constants/colors.dart';

class Button extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool enabled;
  final bool isLoading;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double elevation;
  final Color? backgroundColor;
  final Color? textColor;

  final Color? borderColor;
  final double borderWidth;
  final Widget? icon;
  final bool iconOnRight;

  const Button({
    super.key,
    required this.label,
    required this.onPressed,
    this.enabled = true,
    this.isLoading = false,
    this.width,
    this.height,
    this.padding,
    this.borderRadius = 8.0,
    this.elevation = 0,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderWidth = 2,
    this.icon,
    this.iconOnRight = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isButtonEnabled = enabled && !isLoading;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isButtonEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isButtonEnabled
              ? backgroundColor ?? AppColors.primary
              : AppColors.primaryShade5,
          foregroundColor: textColor ?? AppColors.white,
          padding:
              padding ??
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 32.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: borderWidth,
            ),
          ),
          elevation: elevation,
          textStyle: const TextStyle(
            fontSize: 16,
            fontFamily: 'IRANYekanX',
            fontWeight: FontWeight.w600,
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : _buildChild(),
      ),
    );
  }

  Widget _buildChild() {
    if (icon == null) {
      return Text(label);
    }

    final children = <Widget>[
      if (!iconOnRight) icon!,
      if (!iconOnRight) const SizedBox(width: 8),
      Text(label),
      if (iconOnRight) const SizedBox(width: 8),
      if (iconOnRight) icon!,
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}
