import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';

extension BaseNullExtension on Null {
  String defaultStr2({String data = '无'}) {
    if (null == this || '' == this) {
      return data;
    } else {
      return this;
    }
  }
}
