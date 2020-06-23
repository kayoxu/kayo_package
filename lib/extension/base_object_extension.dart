import 'dart:ui';

import 'package:kayo_package/kayo_package.dart';

extension BaseObjectExtension on Object {
  Object defaultValue(Object data) {
    if (null == this) {
      return data;
    } else {
      return this;
    }
  }
}
