import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';
import '../kayo_package_utils.dart';
import 'base_build_context_extension.dart';

extension OnTapExtension on void Function()? {
  void Function() safeTap({int? time = 500, Function()? onSafe}) {
    if (null == this) return this ?? () {};
    return BaseSysUtils.safeTap(this!, time: time, onSafe: onSafe);
  }
}
