import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';

extension BuildContextExtension on BuildContext? {
  // bool get isDark =>
  //     Theme.of(this ?? KayoPackage.share.navigatorKey.currentContext!)
  //         .brightness ==
  //     Brightness.dark;
  bool get isDark => false;

  Color get backgroundColor => BaseColorUtils.colorWindowWhite;

  Color get dialogBackgroundColor => BaseColorUtils.colorWindowWhite;

///获取主题
// ThemeData get theme =>
//     Theme.of(this ?? KayoPackage.share.navigatorKey.currentContext!);
}
