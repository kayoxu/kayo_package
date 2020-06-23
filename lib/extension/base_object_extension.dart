import 'dart:ui';

import 'package:kayo_package/kayo_package.dart';

extension BaseStringExtension on Object {
  Object processNull({Object data}) {
    if (null == this) {
      return data;
    } else {
      return this;
    }
  }
}
