import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:kayo_package/kayo_package.dart';

extension BaseObjectExtension on Object {
  Object defaultValue({Object data}) {
    if (null == this) {
      if (this is String) {
        return data ?? '无';
      } else {
        return data;
      }
    } else {
      return this;
    }
  }
}
