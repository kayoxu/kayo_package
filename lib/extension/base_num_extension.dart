import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';

extension BaseNumExtension on num? {
  String toTimeStr({String? format, String? defaultTime}) {
    try {
      if (null != this) {
        if ('${this!.round()}'.length == 10) {
          return BaseTimeUtils.timestampToTimeStr(this!.round() * 1000,
              format: format);
        } else if ('${this!.round()}'.length == 13) {
          return BaseTimeUtils.timestampToTimeStr(this!.round(),
              format: format);
        } else {
          return BaseTimeUtils.timestampToTimeStr(
              (this!.round() - 60 * 60 * 0) * 1000,
              format: format);
        }
      }
      return defaultTime ?? KayoPackage.share.nullText;
    } catch (e) {
      print(e);
      return defaultTime ?? KayoPackage.share.nullText;
    }
  }

  String? toStr() {
    if (null != this) {
      return '${this}';
    }
    return null;
  }

  Radius toRadius() {
    if (null != this) {
      return Radius.circular(this! + 0.0);
    } else {
      return Radius.circular(0);
    }
  }
}
