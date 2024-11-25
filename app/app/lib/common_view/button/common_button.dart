import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class CommonButton extends StatelessWidget {
  final String? text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final double? borderRadius;
  final double? elevation;
  final EdgeInsetsGeometry? padding;
  final Widget? icon;
  final double? width;
  final double? height;
  final bool isLoading;
  final TextStyle? style;
  final bool isText;

  const CommonButton({
    Key? key,
    this.text,
    required this.isText,
    required this.onPressed,
    this.backgroundColor = ColorConstant.primary,
    this.borderRadius = 8.0,
    this.elevation = 2.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.icon,
    this.width,
    this.height,
    this.style,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            padding: padding,
            elevation: elevation,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
            ),
          ),
          child: isLoading
              ? const CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(ColorConstant.primary),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) icon!,
                    if (icon != null && isText== true)
                      const SizedBox(width: 8), // khoảng cách giữa icon và text
                    if(isText == true) Text(text!,
                      style: style,
                    ),
                  ],
                ),
        ),
      );
    });
  }
}
