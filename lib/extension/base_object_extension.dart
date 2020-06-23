import 'dart:ui';

import 'package:kayo_package/kayo_package.dart';

extension BaseObjectExtension on Object {
  Object processNull(Object data) {
    if (null == this) {
      return data;
    } else {
      return this;
    }
  }
}
