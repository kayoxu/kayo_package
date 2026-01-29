import 'package:flutter/material.dart';
import 'package:kayo_package/utils/base_color_utils.dart';

///  Refactored ShadowView
///  A simple wrapper for Material to provide shadow/elevation.
class ShadowView extends StatelessWidget {
  final Widget? child;
  final double radius;
  final double elevation;
  final Color shadowColor;
  final Color? bgColor;
  final BorderRadius? borderRadius;

  const ShadowView({
    Key? key,
    required this.child,
    this.radius = 0,
    this.elevation = 0,
    this.shadowColor = BaseColorUtils.colorGreyLite,
    this.bgColor,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: borderRadius ?? BorderRadius.circular(radius),
      elevation: elevation,
      shadowColor: shadowColor,
      color: bgColor,
      child: child,
      // clipBehavior: Clip.antiAlias, // Optional: might want this if radius > 0
    );
  }
}
