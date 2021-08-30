import 'package:flutter/material.dart';

///  kayo_plugin
///  lib.utils
///
///  Created by kayoxu on 2019-06-11 16:09.
///  Copyright © 2019 kayoxu. All rights reserved.
class BaseColorUtils {
  BaseColorUtils._();

  static BaseColorUtils get share => BaseColorUtils._share();

  static BaseColorUtils? _instance;

  factory BaseColorUtils._share() {
    if (_instance == null) {
      _instance = BaseColorUtils._();
    }
    return _instance!;
  }

  int get _colorPrimaryColor2 {
    return colorPrimary2.value;
  }

  Color get colorPrimary2 {
    return Color(0xFF2B7FFB);
  }

  Color get colorPrimaryLight2 {
    return Color(0xFF2B7FFB);
  }

  Color get colorPrimaryDark2 {
    return Color(0xFF2B7FFB);
  }

  Color get colorAccent2 {
    return Color(0xFF2B7FFB);
  }

  Color get colorAccentLite2 {
    return Color(0xFF00A2FF);
  }

  Color get colorAccentLiteLite2 {
    return Color(0xFFaaaae8);
  }

  static int colorPrimaryColor = share._colorPrimaryColor2;
  static Color colorPrimary = share.colorPrimary2;
  static Color colorPrimaryLight = share.colorPrimaryLight2;
  static Color colorPrimaryDark = share.colorPrimaryDark2;

  static Color colorAccent = share.colorAccent2;
  static Color colorAccentLite = share.colorAccentLite2;
  static Color colorAccentLiteLite = share.colorAccentLiteLite2;

  static const Color colorWindow = Color(0xFFf8f8f8);
  static const Color colorWindowWhite = Color(0xFFFFFFFF);

  static const Color colorBlack = Color(0xFF333333);
  static const Color colorBlackLite = Color(0xFF666666);
  static const Color colorBlackLiteLite = Color(0xFF999999);

  static const Color colorWhite = Color(0xFFFFFFFF);
  static const Color colorWhiteLite = Color(0xFFE6E7ED);
  static const Color colorWhiteDark = Color(0xFFCCCCCC);

  static const Color colorYellow = Color(0xFFEB962B);
  static const Color colorYellowLite = Color(0xFFF4CC4C);

  static const Color colorBlue = Color(0xFF00ABF9);
  static const Color colorBlueLite = Color(0x8800ABF9);

  static const Color colorRed = Color(0xFFFF6666);
  static const Color colorRedLite = Color(0xFFEE8888);
  static const Color colorRedLiteLite = Color(0xFFFFF5E7);

  static const Color colorGreen = Color(0xFF73d575);
  static const Color colorGreenLite = Color(0xFFE2F5E6);

  static const Color colorGrey = Color(0xFF666666);
  static const Color colorGreyLite = Color(0xFF8F8F8F);
  static const Color colorGreyLiteLite = Color(0xFFB8B8B8);
  static const Color colorGreyLiteLiteLite = Color(0x88DEDEDE);

  static const Color colorTransparent = Color(0x00000000);
  static const Color transparent = Color(0x00000000);

  static const Color cardShadow = Color(0xFFd0d0d0);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color miWhite = Color(0xffececec);
  static const Color white = Color(0xFFFFFFFF);
  static const Color actionBlue = Color(0xff267aff);
  static const Color subTextColor = Color(0xff959595);
  static const Color subLightTextColor = Color(0xffc4c4c4);

  static const Color mainBackgroundColor = miWhite;

  static const Color mainTextColor = colorGrey;
  static const Color textColorWhite = white;

  static const String miWhiteString = "#ececec";
  static const String actionBlueString = "#267aff";
  static const String webDraculaBackgroundColorString = "#282a36";
  static const String primaryLightValueString = "#2B7FFB";
}
