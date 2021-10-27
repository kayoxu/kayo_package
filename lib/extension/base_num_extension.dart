import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';

extension BaseNumExtension on num? {
  Radius toRadius() {
    if (null != this) {
      return Radius.circular(this! + 0.0);
    } else {
      return Radius.circular(0);
    }
  }
}
