import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../kayo_package_utils.dart';
import 'base_build_context_extension.dart';

extension ColorExtension on Color? {
  Color darkFuc({BuildContext? context, double opacity = 0.65}) {
    return (this ?? Colors.grey).withOpacity(
        (context ?? KayoPackage.share.navigatorKey.currentContext).isDark
            ? 0.65
            : 1);
  }

  ///深色模式颜色调暗
  Color get dark => this.darkFuc();
}
