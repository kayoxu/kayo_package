import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';

///
///  kayo_package
///  kayo_pakcage_utils.dart
///
///  Created by kayoxu on 2021/5/25 at 4:40 下午
///  Copyright © 2021 kayoxu. All rights reserved.
///

class KayoPackage {
  factory KayoPackage._init() {
    if (_singleton == null) {
      _singleton = KayoPackage._();
    }
    return _singleton!;
  }

  KayoPackage._();

  static KayoPackage get share => KayoPackage._init();
  static KayoPackage? _singleton;

  String nullText = '无';

  init({String? nullText, String? formatDefault}) {
    this.nullText = nullText ?? this.nullText;
    BaseTimeUtils.formatDefault = formatDefault ?? BaseTimeUtils.formatDefault;
  }
}
