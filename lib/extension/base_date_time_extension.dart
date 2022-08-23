import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';

extension BaseDateTimeExtension on DateTime? {
  String toTimeStr({String? format, String? defaultTime, bool tz = false}) {
    try {
      if (null != this) {
        var seconds = this!.millisecondsSinceEpoch;
        var replaceAll = BaseTimeUtils.timestampToTimeStr(seconds, format: format).replaceAll(" ", "T");
        return "${replaceAll}Z";
      }
      return defaultTime ?? KayoPackage.share.nullText;
    } catch (e) {
      print(e);
      return defaultTime ?? KayoPackage.share.nullText;
    }
  }
}
