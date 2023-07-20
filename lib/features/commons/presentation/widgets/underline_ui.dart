import 'package:flutter/material.dart';
import 'package:logique_test/features/commons/presentation/widgets/rounded_container.dart';

class UnderlineUI extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  final EdgeInsets? margin;
  final Color? color;

  const UnderlineUI({
    Key? key,
    this.radius,
    this.height,
    this.width,
    this.margin,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      radius: radius,
      margin:
          margin ?? const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 8),
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? 1,
      color: color ?? Colors.grey[300],
    );
  }
}
