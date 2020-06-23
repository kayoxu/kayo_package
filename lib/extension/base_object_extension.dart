import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:kayo_package/kayo_package.dart';

extension BaseObjectExtension on Object {
  Object defaultValue({@required Object data}) {
    if (null == this) {
      return data;
    } else {
      return this;
    }
  }
}
