import 'package:flutter/material.dart';
import 'package:kayo_package/utils/base_color_utils.dart';

///  kayo_plugin
///  views.widget.base
///
///  Created by kayoxu on 2019/2/14 9:53 AM.
///  Copyright © 2019 kayoxu. All rights reserved.

class ShadowView extends StatefulWidget {
  final Widget? child;
  final double? radius;
  final double? elevation;
  final Color? shadowColor;
  final Color? bgColor;
  final BorderRadius? borderRadius;

  /*
  * 水波纹
  * */
  // final bool inkWell;

  ShadowView({
    Key? key,
    required this.child,
    this.radius = 0,
    this.elevation = 0,
    this.shadowColor = BaseColorUtils.colorGreyLite,
    this.bgColor,
    this.borderRadius,
    // this.inkWell = false,
  }) : super(key: key);

  @override
  ShadowViewState createState() => ShadowViewState();
}

class ShadowViewState extends State<ShadowView> {
  @override
  Widget build(BuildContext context) {
    return /*(null == widget.elevation || 0 == widget.elevation) &&
            (true != widget.inkWell)
        ? widget.child!
        :*/
      //     Material(
      //   borderRadius: null != widget.borderRadius
      //       ? widget.borderRadius
      //       : BorderRadius.circular(widget.radius ?? 0),
      //   elevation: widget.elevation ?? 0,
      //   shadowColor: widget.shadowColor,
      //   color: widget.bgColor,
      //   child: widget.child,
      // );
      widget.child!;
  }
}
