import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';

extension BaseIntExtension on int? {
  String toTimeStr({String? format, String? defaultTime}) {
    try {
      if (null != this) {
        if ('${this!}'.length == 10) {
          return BaseTimeUtils.timestampToTimeStr(this! * 1000, format: format);
        } else if ('${this!}'.length == 13) {
          return BaseTimeUtils.timestampToTimeStr(this!, format: format);
        } else {
          return BaseTimeUtils.timestampToTimeStr((this! - 60 * 60 * 0) * 1000,
              format: format);
        }
      }
      return defaultTime ?? KayoPackage.share.nullText;
    } catch (e) {
      print(e);
      return defaultTime ?? KayoPackage.share.nullText;
    }
  }
}
