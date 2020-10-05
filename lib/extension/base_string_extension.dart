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

  double toDouble({double value = 0}) {
    try {
      if (this?.isNotEmpty == true) {
        value = double.tryParse(this);
      }
    } catch (e) {
      print(e);
    } finally {
      return value;
    }
  }

  String fixDouble({String unit = ''}) {
    var data = '${this ?? '0'}$unit';
    if (data.endsWith('.0$unit')) {
      data.replaceAll('.0$unit', '$unit');
    }
    return data;
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

  String toTimeStr({String format, String defaultTime}) {
    try {
      if (this?.isNotEmpty == true) {
        if (BaseSysUtils.isNumber(this)) {
          var t = BaseSysUtils.str2Int(this);
          if (this.length == 10) {
            return BaseTimeUtils.timestampToTimeStr(t * 1000, format: format);
          } else if (this.length == 13) {
            return BaseTimeUtils.timestampToTimeStr(t, format: format);
          } else {
            return BaseTimeUtils.timestampToTimeStr((t - 60 * 60 * 8) * 1000,
                format: format);
          }
        } else {
          return this;
        }
      }
      return defaultTime;
    } catch (e) {
      print(e);
      return this ?? defaultTime;
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
}
