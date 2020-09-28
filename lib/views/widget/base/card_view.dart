import 'package:flutter/material.dart';
import 'package:kayo_package/utils/base_color_utils.dart';
import 'package:kayo_package/views/widget/base/clickable.dart';
import 'package:kayo_package/views/widget/base/image_view.dart';

///  kayo_plugin
///  views.widget
///
///  Created by kayoxu on 2020/9/01 11:12 AM.
///  Copyright © 2020 kayoxu. All rights reserved.

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
  final String bgImg;
  final BoxFit bgImgFit;

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
    this.shadowColor,
    this.bgImg,
    this.bgImgFit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Material(
        borderRadius: BorderRadius.circular(shadowRadius ?? 0),
        shadowColor: shadowColor ?? BaseColorUtils.transparent,
        borderOnForeground: false,
        elevation: elevation ?? 0,
        child: Clickable(
          bgColor: BaseColorUtils.transparent,
          radius: radius ?? 0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
            gradient: linearGradient ??
                LinearGradient(
                    begin: colorAlignmentBegin ?? Alignment.topCenter,
                    end: colorAlignmentEnd ?? Alignment.bottomCenter,
                    colors: bgColors ??
                        [
                          BaseColorUtils.transparent,
                          BaseColorUtils.transparent
                        ]),
          ),
          padding: padding,
          child: null == bgImg
              ? child
              : Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
                      color: Colors.transparent,
                      image: DecorationImage(
                          image: AssetImage(bgImg),
                          fit: bgImgFit ?? BoxFit.contain)),
                  child: child,
                ),
          onTap: onPressed,
        ),
      ),
    );
  }
}
