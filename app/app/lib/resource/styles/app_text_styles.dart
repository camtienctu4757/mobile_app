// ignore_for_file: avoid_hard_coded_text_style
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared/shared.dart';

import '../../app.dart';

/// AppTextStyle format as follows:
/// s[fontSize][fontWeight][Color]
/// Example: s18w400Primary

class AppTextStyles {
  AppTextStyles._();
  static const _defaultLetterSpacing = 0.03;

  static const _baseTextStyle = TextStyle(
    letterSpacing: _defaultLetterSpacing,
    // height: 1.0,
  );
  static TextStyle s16w500Normal({
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize:
              Dimens.d14.responsive(tablet: tablet, ultraTablet: ultraTablet),
          fontWeight: FontWeight.w500,
          color: ColorConstant.black,
        ),
      ));

  static TextStyle s20w500Cookie({
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(GoogleFonts.cookie(
        textStyle: TextStyle(
          fontSize:
              Dimens.d20.responsive(tablet: tablet, ultraTablet: ultraTablet),
          fontWeight: FontWeight.w500,
          color: ColorConstant.textblack,
        ),
      ));

  static TextStyle s14w400Primary({
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize:
              Dimens.d14.responsive(tablet: tablet, ultraTablet: ultraTablet),
          fontWeight: FontWeight.w400,
          color: AppColors.current.primaryTextColor,
        ),
      ));

  static TextStyle s14w700Black({
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize:
              Dimens.d14.responsive(tablet: tablet, ultraTablet: ultraTablet),
          fontWeight: FontWeight.w600,
          color: ColorConstant.textblack,
        ),
      ));

  static TextStyle s16w600Primary({
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize:
              Dimens.d16.responsive(tablet: tablet, ultraTablet: ultraTablet),
          fontWeight: FontWeight.w600,
          color: AppColors.current.primaryTextColor,
        ),
      ));

    static TextStyle s16wBoldPrimary({
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize:
              Dimens.d16.responsive(tablet: tablet, ultraTablet: ultraTablet),
          fontWeight: FontWeight.bold,
          color: AppColors.current.primaryColor,
        ),
      ));
  static TextStyle s18w600Primary({
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize:
              Dimens.d18.responsive(tablet: tablet, ultraTablet: ultraTablet),
          fontWeight: FontWeight.w600,
          color: AppColors.current.primaryTextColor,
        ),
      ));
  static TextStyle s18w700Primary({
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize:
              Dimens.d18.responsive(tablet: tablet, ultraTablet: ultraTablet),
          fontWeight: FontWeight.w700,
          color: ColorConstant.primary,
        ),
      ));
  static TextStyle s16w400White({
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize:
              Dimens.d16.responsive(tablet: tablet, ultraTablet: ultraTablet),
          fontWeight: FontWeight.w400,
          color: ColorConstant.white,
        ),
      ));
   static TextStyle s16wboldWhite({
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize:
              Dimens.d16.responsive(tablet: tablet, ultraTablet: ultraTablet),
          fontWeight: FontWeight.bold,
          color: ColorConstant.white,
        ),
      ));
  static TextStyle s18w400White({
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize:
              Dimens.d18.responsive(tablet: tablet, ultraTablet: ultraTablet),
          fontWeight: FontWeight.w400,
          color: ColorConstant.white,
        ),
      ));

  static TextStyle s16w400Black({
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize:
              Dimens.d14.responsive(tablet: tablet, ultraTablet: ultraTablet),
          fontWeight: FontWeight.w400,
          color: ColorConstant.black,
        ),
      ));

    static TextStyle s16Blackbold({
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize:
              Dimens.d14.responsive(tablet: tablet, ultraTablet: ultraTablet),
          fontWeight: FontWeight.bold,
          color: ColorConstant.black,
        ),
      ));
  static TextStyle s16w600White({
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize:
              Dimens.d16.responsive(tablet: tablet, ultraTablet: ultraTablet),
          fontWeight: FontWeight.w600,
          color: ColorConstant.white,
        ),
      ));

  static TextStyle s32w600Primary({
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize:
              Dimens.d14.responsive(tablet: tablet, ultraTablet: ultraTablet),
          fontWeight: FontWeight.w400,
          color: AppColors.current.primaryTextColor,
        ),
      ));

  static TextStyle s14w400Hint({
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize:
              Dimens.d14.responsive(tablet: tablet, ultraTablet: ultraTablet),
          fontWeight: FontWeight.w400,
          color: ColorConstant.text_hint,
        ),
      ));

  static TextStyle s14w400Black({
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize:
              Dimens.d14.responsive(tablet: tablet, ultraTablet: ultraTablet),
          fontWeight: FontWeight.w400,
          color: ColorConstant.black,
        ),
      ));
  static TextStyle s18w600Black({
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize:
              Dimens.d18.responsive(tablet: tablet, ultraTablet: ultraTablet),
          fontWeight: FontWeight.w600,
          color: ColorConstant.black,
        ),
      ));
  static TextStyle s16w700White({
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize:
              Dimens.d16.responsive(tablet: tablet, ultraTablet: ultraTablet),
          fontWeight: FontWeight.w700,
          color: ColorConstant.white,
        ),
      ));
  static TextStyle s16w600Black({
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize:
              Dimens.d16.responsive(tablet: tablet, ultraTablet: ultraTablet),
          fontWeight: FontWeight.w600,
          color: ColorConstant.black,
        ),
      ));

  static TextStyle s16w600Light({
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize:
              Dimens.d16.responsive(tablet: tablet, ultraTablet: ultraTablet),
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 179, 184, 190),
        ),
      ));

  static TextStyle s14w400Price({
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize:
              Dimens.d16.responsive(tablet: tablet, ultraTablet: ultraTablet),
          fontWeight: FontWeight.w600,
          color: ColorConstant.textprice,
        ),
      ));
  static TextStyle s14w400Secondary({
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(TextStyle(
        fontSize:
            Dimens.d14.responsive(tablet: tablet, ultraTablet: ultraTablet),
        fontWeight: FontWeight.w400,
        color: AppColors.current.secondaryTextColor,
      ));
     
}
