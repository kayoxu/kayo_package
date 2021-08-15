import 'package:flutter/material.dart';
import 'package:kayo_package/utils/base_color_utils.dart';
import 'package:kayo_package/views/widget/visible_view.dart';

///  kayo_plugin
///  views.widget.base
///
///  Created by kayoxu on 2019/2/14 2:21 PM.
///  Copyright © 2019 kayoxu. All rights reserved.

class LineView extends StatefulWidget {
  final Visible? visible;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? height;
  final double? width;
  final Color? color;
  final double? radius;

  const LineView(
      {Key? key,
      this.visible,
      this.margin,
      this.padding,
      this.height,
      this.width,
      this.color,
      this.radius})
      : super(key: key);

  @override
  LineViewState createState() => LineViewState();
}

class LineViewState extends State<LineView> {
  @override
  Widget build(BuildContext context) {
    var container = Container(
      margin: widget.margin,
      padding: widget.padding,
      width: widget.width ?? double.infinity,
      height: widget.height ?? .5,
      decoration: BoxDecoration(
          color: widget.color ?? BaseColorUtils.colorGreyLiteLiteLite,
          borderRadius: BorderRadius.all(Radius.circular(widget.radius ?? 0))),
    );
    return widget.visible == null
        ? container
        : VisibleView(
            visible: widget.visible ?? Visible.visible,
            child: container,
          );
  }
}
