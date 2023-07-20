import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double? fontSize, height, width, radius;
  final EdgeInsets? margin;
  final String text;
  final Color? background, foreground;
  final FontWeight? fontWeight;

  const MyButton({
    Key? key,
    this.onPressed,
    this.width,
    this.height,
    this.radius,
    this.margin,
    required this.text,
    this.background,
    this.foreground,
    this.fontWeight,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        margin: margin,
        width: width,
        child: MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 45))),
          color: background ?? Colors.blue,
          height: height ?? 45,
          // onPressed: onPressed,
          onPressed: onPressed,
          disabledColor: Colors.grey[200],
          child: Text(
            text,
            style: TextStyle(
                fontSize: fontSize ?? 18,
                color:
                    foreground ?? (_isDisable ? Colors.blueGrey : Colors.white),
                fontWeight: fontWeight ??
                    (_isDisable ? FontWeight.w600 : FontWeight.w400)),
          ),
        ),
      );

  bool get _isDisable => onPressed == null;
}
