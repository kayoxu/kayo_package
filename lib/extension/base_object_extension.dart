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

  int defaultInt({int data = 0}) {
    if (null == this) {
      return data;
    } else {
      return this;
    }
  }

  String defaultStr({String data = '无'}) {
    if (null == this && '' == this) {
      return data;
    } else {
      return this;
    }
  }

  double defaultDouble({double data = 0}) {
    if (null == this) {
      return data;
    } else {
      return this;
    }
  }
}
