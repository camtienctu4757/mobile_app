import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared/shared.dart';
Widget field(String text, String initial) {
  return Row(
    // mainAxisAlignment: MainAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
          text,
          style: AppTextStyles.s16w600Black(),
        ),
      SizedBox(
        width: Dimens.d250,
        height: Dimens.d40,
        child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          initialValue: initial,
          style: AppTextStyles.s16w400Black(),
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: Dimens.d5, horizontal: Dimens.d16),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius:
                    BorderRadius.all(Radius.circular(Dimens.d15)), 
              ),
              filled: true,
              fillColor: ColorConstant.bg_textfiled),
        ),
      ),
    ],
  );
}