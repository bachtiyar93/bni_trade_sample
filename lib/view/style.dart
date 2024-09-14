import 'package:bni_trade/view/color_component.dart';
import 'package:flutter/material.dart';

class AppStyles {
  AppStyles._();

  static const _family = 'Inter';
  static const _familyArabic = 'LPMQIsepMisbah';

  static const defaultArabText = TextStyle(
    fontFamily: _familyArabic,
    fontSize: 24,
    height: 2,
    fontWeight: FontWeight.w400,
  );

  static const caption = TextStyle(
    fontFamily: _family,
    fontSize: 10,
    height: 1.2,
    fontWeight: FontWeight.w400,
  );

  static const textS = TextStyle(
    fontFamily: _family,
    fontSize: 12,
    height: 1.3,
    fontWeight: FontWeight.w400,
  );

  static const textM = TextStyle(
    fontFamily: _family,
    fontSize: 14,
    height: 1.4,
    fontWeight: FontWeight.w400,
  );

  static const textL = TextStyle(
    fontFamily: _family,
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w400,
  );

  static const headingS = TextStyle(
    fontFamily: _family,
    fontSize: 18,
    height: 1.55,
    fontWeight: FontWeight.w400,
  );

  static const headingM = TextStyle(
    fontFamily: _family,
    fontSize: 20,
    height: 1.6,
    fontWeight: FontWeight.w400,
  );

  static const headingL = TextStyle(
    fontFamily: _family,
    fontSize: 24,
    height: 1.66,
    fontWeight: FontWeight.w400,
  );
  static const bukuMu = TextStyle(
    fontFamily: _family,
    fontSize: 28,
    height: 1.66,
    fontWeight: FontWeight.w500,
  );

  static const clockPrayerBanner = TextStyle(
    fontFamily: _family,
    fontSize: 36,
    fontWeight: FontWeight.w400,
  );

  static const clockPrayer = TextStyle(
    fontFamily: _family,
    fontSize: 80,
    height: 1.66,
    fontWeight: FontWeight.w400,
  );
}

extension StyleExt on TextStyle {
  TextStyle get underline => apply(decoration: TextDecoration.underline);
}

extension Weight on TextStyle {
  TextStyle get medium => apply(fontWeightDelta: 1);

  TextStyle get semiBold => apply(fontWeightDelta: 2);

  TextStyle get bold => apply(fontWeightDelta: 3);

  TextStyle get extraBold => apply(fontWeightDelta: 4);
}

extension Coloring on TextStyle {
  TextStyle get mainButton => apply(color: Col.mainButtonColor);

  TextStyle get secondaryButton => apply(color: Col.secondaryButtonColor);

  TextStyle get darkButton => apply(color: Col.darkButtonColor);

  TextStyle get greyButton => apply(color: Col.greyButtonColor);

  TextStyle get white => apply(color: Colors.white);

  TextStyle get blueText => apply(color: Col.textBlue);
  TextStyle get greyText => apply(color: Col.textGrey);
  TextStyle get black => apply(color: Colors.black);
}
