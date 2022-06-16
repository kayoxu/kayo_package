import 'package:flutter/material.dart';
import 'package:kayo_package/extension/_index_extension.dart';

///  kayo_plugin
///  lib.utils
///
///  Created by kayoxu on 2019-06-11 16:09.
///  Copyright © 2019 kayoxu. All rights reserved.
class BaseColorUtils {
  static const Color colorBlue = Color(0xFF5793FA);
  static const Color colorRed = Color(0xFFFF4759);
  static const Color colorRedDark = Color(0xFFE03E4E);
  static const Color colorOrange = Color(0xFFFF8547);
  static const Color colorYellow = Color(0xFFFF8547);

  static const Color colorWindow = Color(0xfff1f1f1);
  static const Color colorWindowDark = Color(0xFF18191A);

  static const Color colorWhite = Color(0xFFFFFFFF);
  static const Color colorWhiteLight = Color(0xffbfbfbf);
  static const Color colorWhiteDark = Color(0xFF303233);

  static const Color colorBlack = Color(0xFF333333);
  static const Color colorBlackLite = Color(0xFF666666);
  static const Color colorBlackLiteLite = Color(0xFF999999);
  static const Color colorBlackDark = Color(0xFFB8B8B8);
  static const Color colorBlackDarkLite = Color(0xFF999999);
  static const Color colorBlackDarkLiteLite = Color(0xFF999999);

  static const Color colorGray = Color(0xFF999999);
  static const Color colorGrayDark = Color(0xFF666666);
  static const Color colorGrayLight = Color(0xFFcccccc);

  static const Color colorLine = Color(0xFFEEEEEE);
  static const Color colorLineDark = Color(0xFF3A3C3D);

  static const Color colorItemUnSelectedDark = Color(0xffbfbfbf);
  static const Color colorItemUnSelected = Color(0xFF4D4D4D);

  static const Color stickyHeaderColor = Color(0xFFFAFAFA);
  static const Color stickyHeaderColorDark = Color(0xFF242526);

  static int colorPrimaryColor = colorPrimary.value;
  static Color colorPrimary = Color(0xFF2B7FFB);
  static Color colorPrimaryLight = Color(0xFF2B7FFB);
  static Color colorPrimaryDark = Color(0xFF2B7FFB);

  static Color colorAccent = Color(0xFF2B7FFB);
  static Color colorAccentLite = Color(0xFF00A2FF);
  static Color colorAccentLiteLite = Color(0xFFaaaae8);

  static const Color colorWindowWhite = Color(0xFFFFFFFF);

  static const Color colorWhiteLite = Color(0xFFE6E7ED);

  static const Color colorYellowLite = Color(0xFFF4CC4C);

  static const Color colorBlueLite = Color(0x8800ABF9);

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

  static Color darkWhite({required BuildContext? context}) {
    return context.isDark
        ? BaseColorUtils.colorWhiteDark
        : BaseColorUtils.colorWhite;
  }

  static Color darkBlack({required BuildContext? context}) {
    return context.isDark
        ? BaseColorUtils.colorBlackDark
        : BaseColorUtils.colorBlack;
  }

  static Color darkBlackLite({required BuildContext? context}) {
    return context.isDark
        ? BaseColorUtils.colorBlackDarkLite
        : BaseColorUtils.colorBlackLite;
  }

  static Color darkBlackLiteLite({required BuildContext? context}) {
    return context.isDark
        ? BaseColorUtils.colorBlackDarkLiteLite
        : BaseColorUtils.colorBlackLiteLite;
  }

  static Color darkWindow({required BuildContext? context}) {
    return context.isDark
        ? BaseColorUtils.colorWindowDark
        : BaseColorUtils.colorWindow;
  }

  static Color darkWindowLite({required BuildContext? context}) {
    return context.isDark
        ? BaseColorUtils.colorItemUnSelected
        : BaseColorUtils.colorWindow;
  }

  static Color darkPrimary({required BuildContext? context}) {
    return context.theme.primaryColor;
  }

  static Color darkPrimary2({required BuildContext? context}) {
    return context.theme.colorScheme.secondary.dark;
  }
}
