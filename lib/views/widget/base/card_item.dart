import 'package:flutter/material.dart';
import 'package:kayo_package/utils/base_color_utils.dart';
import 'package:kayo_package/views/widget/base/clickable.dart';

///  kayo_plugin
///  views.widget
///
///  Created by kayoxu on 2019/2/11 4:17 PM.
///  Copyright © 2019 kayoxu. All rights reserved.

class CardItem extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color color;
  final Color shadowColor;
  final RoundedRectangleBorder shape;
  final double elevation;
  final VoidCallback onPressed;
  final Decoration decoration;

  const CardItem(
      {@required this.child,
      Key key,
      this.margin,
      this.padding,
      this.color,
      this.shape,
      this.elevation = 1,
      this.onPressed,
      this.shadowColor = BaseColorUtils.colorGreyLiteLite,
      this.decoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    EdgeInsets margin = this.margin;
    EdgeInsets padding = this.padding;

    RoundedRectangleBorder shape = this.shape;
    Color color = this.color;
    margin ??= EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 0);

    padding ??= EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0, bottom: 8.0);

    shape ??= new RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(3)));
    color ??= BaseColorUtils.cardWhite;

    return Clickable(
      elevation: elevation,
      radius: 3,
      decoration: decoration,
      bgColor: color,
      child: child,
      shadowColor: shadowColor,
      margin: margin,
      padding: padding,
      onTap: onPressed,
    );
  }
}
