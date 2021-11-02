import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';

extension BaseDateTimeExtension on DateTime? {
  String toTimeStr({String? format, String? defaultTime}) {
    try {
      if (null != this) {
        var seconds = this!.millisecondsSinceEpoch;
        return BaseTimeUtils.timestampToTimeStr(seconds, format: format);
      }
      return defaultTime ?? KayoPackage.share.nullText;
    } catch (e) {
      print(e);
      return defaultTime ?? KayoPackage.share.nullText;
    }
  }
}
