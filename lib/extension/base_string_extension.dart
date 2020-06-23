import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';

extension BaseStringExtension on String {
  int toInt({int value = 0}) {
    try {
      if (this?.isNotEmpty == true) {
        value = int.tryParse(this);
      }
    } catch (e) {
      print(e);
    } finally {
      return value;
    }
  }

  Color toColor({Color defaultColor = const Color(0xff333333)}) {
    try {
      if (this?.isNotEmpty == true) {
        if (this.length == 6 &&
            int.tryParse(this.substring(0, 6), radix: 16) != null) {
          //        000000
          return Color(int.parse(this.substring(0, 6), radix: 16) + 0xFF000000);
        } else if (this.length == 7 &&
            int.tryParse(this.substring(1, 7), radix: 16) != null) {
          //        #000000
          return Color(int.parse(this.substring(1, 7), radix: 16) + 0xFF000000);
        } else if (this.length == 8 &&
            int.tryParse(this.substring(0, 8), radix: 16) != null) {
          //        ff000000
          return Color(int.parse(this.substring(0, 8), radix: 16));
        } else if (this.length == 9 &&
            int.tryParse(this.substring(1, 9), radix: 16) != null) {
          //        #ff000000
          return Color(int.parse(this.substring(1, 9), radix: 16));
        } else {
          return defaultColor;
        }
      }
    } catch (e) {
      print(e);
      return defaultColor;
    }
  }

  String toTimeStr() {
    try {
      if (this?.isNotEmpty == true) {
        if (BaseSysUtils.isNumber(this)) {
          var t = BaseSysUtils.str2Int(this);
          if (this.length == 10) {
            return BaseTimeUtils.timestampToTimeStr(t * 1000);
          } else if (this.length == 13) {
            return BaseTimeUtils.timestampToTimeStr(t);
          }
        }
      }
    } catch (e) {
      print(e);
      return this;
    }
  }

  int toTimestamp(
      {bool second = true, String format = BaseTimeUtils.formatDefault}) {
    if (this?.isNotEmpty == true) {
      var timestamp = BaseTimeUtils.timeStrToTimestamp(this, format: format);
      return second == true ? timestamp ~/ 1000 : timestamp;
    } else {
      return this ?? 0;
    }
  }

  String defaultStr({String data = '无'}) {
    if (this == null || this.isEmpty) {
      return data;
    } else {
      return this;
    }
  }
}
