import 'package:flutter/material.dart';
import 'package:kayo_package/utils/base_color_utils.dart';

///  kayo_plugin
///  views.widget.base
///
///  Created by kayoxu on 2019/2/13 3:18 PM.
///  Copyright © 2019 kayoxu. All rights reserved.

class Scrollview extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Axis? orientation;
  final Color? bgColor;
  final Decoration? decoration;
  final Widget? headerView;
  final double? height;

  Scrollview(
      {Key? key,
      required this.children,
      this.padding,
      this.margin,
      this.orientation,
      this.bgColor,
      this.decoration,
      this.height,
      this.headerView})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (null != headerView) children.insert(0, headerView!);

    return Container(
      color: bgColor ?? BaseColorUtils.colorWindow,
      padding: padding ?? EdgeInsets.all(0),
      height: height,
      margin: margin ?? EdgeInsets.all(0),
      decoration: decoration,
      child: ListView(
        scrollDirection: orientation ?? Axis.vertical,
        children: children,
        reverse: false,
        shrinkWrap: false,
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
        addSemanticIndexes: false,
      ),
    );
  }
}
