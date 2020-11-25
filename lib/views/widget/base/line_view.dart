import 'package:flutter/material.dart';
import 'package:kayo_package/utils/base_color_utils.dart';
import 'package:kayo_package/views/widget/visible_view.dart';

///  kayo_plugin
///  views.widget.base
///
///  Created by kayoxu on 2019/2/14 2:21 PM.
///  Copyright © 2019 kayoxu. All rights reserved.

class LineView extends StatefulWidget {
  Visible visible;
  EdgeInsets margin;
  EdgeInsets padding;
  double height;
  double width;
  Color color;
  double radius;

  LineView(
      {Key key,
      this.visible,
      this.margin,
      this.padding,
      this.height,
      this.width,
      this.radius,
      this.color})
      : super(key: key);

  @override
  LineViewState createState() => LineViewState();
}

class LineViewState extends State<LineView> {
  @override
  Widget build(BuildContext context) {
    widget.height = widget.height ?? .5;
    widget.width = widget.width ?? double.infinity;
    widget.color = widget.color ?? BaseColorUtils.colorGreyLiteLiteLite;
    widget.visible = widget.visible ?? Visible.visible;

    return VisibleView(
      visible: widget.visible,
      child: Container(
        margin: widget.margin,
        padding: widget.padding,
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            color: widget.color,
            borderRadius:
                BorderRadius.all(Radius.circular(widget.radius ?? 0))),
      ),
    );
  }
}
