import 'package:flutter/material.dart';
import 'package:kayo_package/utils/base_color_utils.dart';
import 'package:kayo_package/views/widget/base/shadow_view.dart';

///  kayo_plugin
///  views.widget.base
///
///  Created by kayoxu on 2019/2/13 6:24 PM.
///  Copyright © 2019 kayoxu. All rights reserved.

class Clickable extends StatefulWidget {
  final Widget child;
  final GestureTapCallback onTap;
  final GestureTapCallback onDoubleTap;
  final GestureLongPressCallback onLongPress;
  final GestureTapDownCallback onTapDown;
  final GestureTapCancelCallback onTapCancel;
  final ValueChanged<bool> onHighlightChanged;
  final Color highlightColor;
  final Color splashColor;
  final InteractiveInkFeatureFactory splashFactory;
  double radius;

  final BorderRadius borderRadius;
  final ShapeBorder customBorder;
  final bool enableFeedback;

  final bool excludeFromSemantics;

  final EdgeInsets margin;
  final EdgeInsets padding;
  Color bgColor;
  double elevation;
  Color shadowColor;
  Decoration decoration;
  Alignment alignment;

  Color selectColor;
  bool selected;

  Clickable({
    Key key,
    @required this.child,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.onTapDown,
    this.onTapCancel,
    this.onHighlightChanged,
    this.highlightColor,
    this.splashColor,
    this.splashFactory,
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
  }) : super(
          key: key,
        );

  @override
  ClickableState createState() => ClickableState();
}

class ClickableState extends State<Clickable> {
  @override
  Widget build(BuildContext context) {
    widget.elevation = widget.elevation ?? 0;
    widget.shadowColor = widget.shadowColor ?? BaseColorUtils.colorGreyLite;
    widget.radius = widget.radius ?? 0;

    return Container(
      decoration: widget.decoration,
      margin: widget.margin,
      alignment: widget.alignment,
      child: (null == widget.onTap &&
              null == widget.onDoubleTap &&
              null == widget.onLongPress &&
              null == widget.onTapDown &&
              null == widget.onTapCancel)
          ? ShadowView(
              elevation: widget.elevation,
              shadowColor: widget.shadowColor,
              bgColor: widget.bgColor,
              borderRadius: BorderRadius.circular(widget.radius),
              child: Container(
                child: widget.child,
                padding: widget.padding,
              ),
            )
          : ShadowView(
              elevation: widget.elevation,
              shadowColor: widget.shadowColor,
              bgColor: (widget.selected ?? false && null != widget.selectColor)
                  ? widget.selectColor
                  : widget.bgColor,
              inkWell: true,
              borderRadius: BorderRadius.circular(widget.radius),
              child: Container(
                child: InkWell(
                  child: Container(
                    child: widget.child,
                    padding: widget.padding,
                  ),

                  onTap: widget.onTap,
                  onDoubleTap: widget.onDoubleTap,
                  onLongPress: widget.onLongPress,
                  onTapDown: widget.onTapDown,
                  onTapCancel: widget.onTapCancel,
                  onHighlightChanged: widget.onHighlightChanged,
                  highlightColor: null != widget.highlightColor
                      ? widget.highlightColor
                      : BaseColorUtils.colorGreyLiteLite.withOpacity(.1),
                  splashColor: null != widget.splashColor
                      ? widget.splashColor
                      : BaseColorUtils.colorGreyLiteLite.withOpacity(.3),
                  splashFactory: widget.splashFactory,
//                radius: widget.radius,
//                borderRadius: widget.borderRadius,
                  borderRadius: null != widget.borderRadius
                      ? widget.borderRadius
                      : BorderRadius.all(Radius.circular(widget.radius)),
                  customBorder: widget.customBorder,
                  enableFeedback: widget.enableFeedback,
                  excludeFromSemantics: widget.excludeFromSemantics,
                ),
              ),
            ),
    );
  }
}
