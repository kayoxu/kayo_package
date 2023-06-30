import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayo_package/utils/base_color_utils.dart';

extension BuildContextExtension on BuildContext? {
  bool get isDark => false;

  Color get backgroundColor => BaseColorUtils.colorWindowWhite;

  Color get dialogBackgroundColor => BaseColorUtils.colorWindowWhite;
}
