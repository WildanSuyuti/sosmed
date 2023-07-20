import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final double? height, width, radius;
  final Color? color;
  final Border? border;
  final BorderRadius? borderRadius;
  final Widget? child;
  final bool isWithShadow;
  final bool isWithBlurShadow;
  final EdgeInsets? margin, padding;
  final Color? blurColor;
  final double? blurRadius;

  const RoundedContainer({
    Key? key,
    this.height,
    this.width,
    this.color,
    this.blurColor,
    this.border,
    this.borderRadius,
    this.radius,
    this.child,
    this.margin,
    this.padding,
    this.isWithShadow = false,
    this.isWithBlurShadow = false,
    this.blurRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        margin: margin,
        padding: padding,
        width: width,
        height: height,
        decoration: BoxDecoration(
            boxShadow: isWithShadow
                ? [
                    BoxShadow(
                        color: blurColor ?? Colors.grey.shade200,
                        blurRadius: isWithBlurShadow ? (blurRadius ?? 10) : 1,
                        blurStyle: BlurStyle.outer,
                        spreadRadius: isWithBlurShadow ? 0 : 1)
                  ]
                : null,
            color: color,
            border: border,
            borderRadius: _borderRadius),
        child: child,
      );

  BorderRadius get _borderRadius {
    if (borderRadius != null) return borderRadius!;
    return BorderRadius.circular(radius ?? 8);
  }
}
