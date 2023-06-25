import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../kayo_package_utils.dart';
import 'base_build_context_extension.dart';
import 'package:flutter/ui/ui.dart' as ui;

extension ColorExtension on Color? {
  Color darkFuc({BuildContext? context, double opacity = 0.65}) {
    return (this ?? Colors.grey).withOpacity(
        (context ?? KayoPackage.share.navigatorKey.currentContext).isDark
            ? opacity
            : 1);
  }

  // MaterialStateProperty<Color?>? materialStatePropertyFuc() {
  //   return MaterialStateProperty.resolveWith<Color?>(
  //           (Set<MaterialState> states) {
  //         return this;
  //       });
  // }

  ///深色模式颜色调暗
  Color get dark => this.darkFuc();

  ///深色模式颜色调暗
  Color get darkLite => this.darkFuc(opacity: .90);

  // MaterialStateProperty<Color?>? get materialStateProperty =>
  //     this.materialStatePropertyFuc();
}
