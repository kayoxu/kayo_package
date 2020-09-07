import 'package:flutter/material.dart';
import 'package:kayo_package/utils/base_color_utils.dart';
import 'package:kayo_package/views/widget/base/clickable.dart';

///  kayo_plugin
///  views.widget
///
///  Created by kayoxu on 2019/2/11 4:17 PM.
///  Copyright © 2019 kayoxu. All rights reserved.

class CardView extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color shadowColor;
  final double elevation;
  final double shadowRadius;
  final double radius;
  final VoidCallback onPressed;
  final LinearGradient linearGradient;
  final List<Color> bgColors;
  final Alignment colorAlignmentBegin;
  final Alignment colorAlignmentEnd;

  const CardView({
    @required this.child,
    Key key,
    this.margin,
    this.padding,
    this.shadowRadius,
    this.radius,
    this.elevation,
    this.linearGradient,
    this.bgColors,
    this.colorAlignmentBegin,
    this.colorAlignmentEnd,
    this.onPressed,
    this.shadowColor = const Color(0X80CCCCC),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Material(
        borderRadius: BorderRadius.circular(shadowRadius),
        shadowColor: shadowColor,
        borderOnForeground: false,
        elevation: elevation,
        child: Clickable(
          bgColor: BaseColorUtils.transparent,
          radius: radius,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            gradient: linearGradient ??
                LinearGradient(
                    begin: colorAlignmentBegin ?? Alignment.topCenter,
                    end: colorAlignmentEnd ?? Alignment.bottomCenter,
                    colors: bgColors ?? [BaseColorUtils.white]),
          ),
          padding: padding,
          child: child,
          onTap: onPressed,
        ),
      ),
    );
  }
}
