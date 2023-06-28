import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';
import 'package:kayo_package/utils/base_color_utils.dart';
import 'package:kayo_package/views/widget/base/shadow_view.dart';

///  kayo_plugin
///  views.widget.base
///
///  Created by kayoxu on 2019/2/13 6:24 PM.
///  Copyright © 2019 kayoxu. All rights reserved.

class Clickable extends StatelessWidget {
  final Widget? child;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onDoubleTap;
  final GestureLongPressCallback? onLongPress;
  final GestureTapDownCallback? onTapDown;
  final GestureTapCancelCallback? onTapCancel;
  final ValueChanged<bool>? onHighlightChanged;
  final Color? highlightColor;
  final Color? splashColor;

  // final InteractiveInkFeatureFactory? splashFactory;
  final double? radius;

  final BorderRadius? borderRadius;
  final ShapeBorder? customBorder;
  final bool? enableFeedback;

  final bool? excludeFromSemantics;

  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? bgColor;
  final double? elevation;
  final Color? shadowColor;
  final Decoration? decoration;
  final BoxConstraints? constraints;
  final Alignment? alignment;

  final Color? selectColor;
  final bool? selected;
  final bool? materialBtn;
  final double? height;
  final double? width;

  Clickable({Key? key,
    required this.child,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.onTapDown,
    this.onTapCancel,
    this.onHighlightChanged,
    this.highlightColor,
    this.splashColor,
    this.constraints,
    // this.splashFactory,
    this.radius = 0,
    this.borderRadius,
    this.customBorder,
    this.enableFeedback = true,
    this.excludeFromSemantics = false,
    this.margin,
    this.padding,
    this.bgColor = BaseColorUtils.transparent,
    this.elevation = 0,
    this.shadowColor = BaseColorUtils.colorGreyLite,
    this.decoration,
    this.alignment,
    this.selectColor,
    this.selected,
    this.materialBtn = true,
    this.height,
    this.width})
      : super(
    key: key,
  );

  @override
  Widget build(BuildContext context) {
    var childTmp = Container(
      child: child,
      constraints: constraints,
      padding: padding,
      decoration: decoration ??
          BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.all((radius ?? 0).toRadius())),
      height: height,
      width: width,
      alignment: alignment,
    );


    return Container(
      margin: margin,
      child: GestureDetector(
        child: childTmp,
        onTap: onTap,
        onDoubleTap: onDoubleTap,
        onLongPress: onLongPress,
        onTapDown: onTapDown,
        onTapCancel: onTapCancel,
        excludeFromSemantics: excludeFromSemantics ?? false,
      ),);
  }
}
