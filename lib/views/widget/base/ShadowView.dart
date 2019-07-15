import 'package:flutter/material.dart';
import 'package:kayo_package/utils/BaseColorUtils.dart';
 
/**
 *  kayo_plugin
 *  views.widget.base
 *
 *  Created by kayoxu on 2019/2/14 9:53 AM.
 *  Copyright © 2019 kayoxu. All rights reserved.
 */

class ShadowView extends StatefulWidget {
  Widget child;
  double radius;
  double elevation;
  Color shadowColor;
  Color bgColor;
  BorderRadius borderRadius;

  /*
  * 水波纹
  * */
  bool inkWell;

  ShadowView({
    Key key,
    @required this.child,
    this.radius = 0,
    this.elevation = 0,
    this.shadowColor = BaseColorUtils.colorGreyLite,
    this.bgColor,
    this.borderRadius,
    this.inkWell = false,
  }) : super(key: key);

  @override
  ShadowViewState createState() => ShadowViewState();
}

class ShadowViewState extends State<ShadowView> {
  @override
  Widget build(BuildContext context) {
    return (null == widget.elevation || 0 == widget.elevation) &&
            !widget.inkWell
        ? widget.child
        : Material(
            borderRadius: null != widget.borderRadius
                ? widget.borderRadius
                : BorderRadius.circular(widget.radius),
            elevation: widget.elevation,
            shadowColor: widget.shadowColor,
            color: widget.bgColor,
            child: widget.child,
          );
  }
}
