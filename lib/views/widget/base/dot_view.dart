import 'package:flutter/material.dart';

///
///  kayo_package
///  dot_view.dart
///
///  Created by kayoxu on 2020/9/16 at 9:55 AM
///  Copyright © 2020 kayoxu. All rights reserved.
///

class DotView extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final double? radius;
  final EdgeInsets? margin;

  const DotView(
      {Key? key, this.width, this.height, this.color, this.radius, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width ?? 0,
        height: height ?? 0,
        margin: margin,
        decoration: BoxDecoration(
            color: color ?? Colors.black38,
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 0))));
  }
}
