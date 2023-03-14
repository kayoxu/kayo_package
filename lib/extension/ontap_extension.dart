import 'package:kayo_package/kayo_package.dart';

extension OnTapExtension on void Function()? {
  void Function() safeTap({int? time = 500, Function()? onSafe}) {
    if (null == this) return this ?? () {};
    return BaseSysUtils.safeTap(this!, time: time, onSafe: onSafe);
  }
}
