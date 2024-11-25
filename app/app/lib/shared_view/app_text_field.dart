import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import '../app.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.title,
    this.hintText = '',
    this.suffixIcon,
    this.controller,
    this.onChanged,
    this.onTap,
    this.keyboardType = TextInputType.text,
    super.key,
    this.obscure,
    this.onSubmitted,
    this.errorText
  });

  final String title;
  final String hintText;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final bool? obscure;
  final void Function(String)? onSubmitted;
  final String? errorText;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // const SizedBox(height: Dimens.d16,),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: AppTextStyles.s16w600Black(),
          ),
        ),
        SizedBox(height: Dimens.d8.responsive()),
        TextField(
          onTap: onTap,
          onChanged: onChanged,
          // onSubmitted: onSubmitted,
          controller: controller,
          obscureText: obscure!,
          decoration: InputDecoration(hintText: hintText,fillColor: ColorConstant.bg_textfiled, hintStyle:AppTextStyles.s14w400Hint(), filled: true,border: InputBorder.none, suffixIcon: suffixIcon, errorText: errorText),
          
          keyboardType: keyboardType,
        ),
      ],
    );
  }
}
