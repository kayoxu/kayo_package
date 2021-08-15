import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';

extension BaseWidgetExtension on Widget? {
  ///设置widget的显示、隐藏、隐藏占位
  Widget setVisible({Key? key, required Visible? visible}) {
    if (null != this) {
      return VisibleView(
        key: key,
        visible: visible ?? Visible.visible,
        child: this,
      );
    }
    return SizedBox();
  }

  ///给widget增加点击事件
  Widget setOnClick({Key? key,
    required GestureTapCallback onTap,
    double? radius,
    bool? materialBtn = true,
    EdgeInsets? margin,
    EdgeInsets? padding,
    double? elevation,
    Color? bgColor,
    Color? shadowColor,
    Alignment? alignment}) {
    if (null != this) {
      return Clickable(
        key: key,
        child: this,
        materialBtn: materialBtn,
        alignment: alignment,
        margin: margin,
        elevation: elevation,
        bgColor: bgColor,
        shadowColor: shadowColor,
        padding: padding,
        radius: radius,
        onTap: onTap,
      );
    }
    return SizedBox();
  }

  ///添加padding
  Widget setPadding({Key? key, required EdgeInsets padding}) {
    if (null != this) {
      return Padding(
        key: key,
        padding: padding,
        child: this,
      );
    }
    return SizedBox();
  }

  ///设置Align
  Widget setAlign({Key? key,
    required AlignmentGeometry alignment,
    double? widthFactor,
    double? heightFactor}) {
    if (null != this) {
      return Align(
        key: key,
        alignment: alignment,
        widthFactor: widthFactor,
        heightFactor: heightFactor,
        child: this,
      );
    }
    return SizedBox();
  }

  ///外面包一层container
  Widget addContainer({Key? key,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Alignment? alignment,
    Color? color,
    Decoration? decoration}) {
    if (null != this) {
      return Container(
        key: key,
        padding: padding,
        margin: margin,
        alignment: alignment,
        child: this,
        color: null == decoration ? color : null,
        decoration: decoration,
      );
    }
    return SizedBox();
  }

  ///外面包一层SafeArea
  Widget addSafeArea({Key? key,
    bool? left,
    bool? top,
    bool? right,
    bool? bottom,
    EdgeInsets? minimum,
    bool? maintainBottomViewPadding}) {
    if (null != this) {
      return SafeArea(
          key: key,
          child: this!,
          left: left ?? true,
          top: top ?? true,
          right: right ?? true,
          bottom: bottom ?? true,
          minimum: minimum ?? EdgeInsets.zero,
          maintainBottomViewPadding: maintainBottomViewPadding ?? false);
    }
    return SizedBox();
  }

  ///外面包一层Expanded
  Widget addExpanded({int? flex = 1, Key? key}) {
    if (null != this) {
      if (null == flex) {
        return this!;
      }
      return Expanded(
        key: key,
        child: this!,
        flex: flex,
      );
    }
    return SizedBox();
  }

  ///外面包一层Flexible
  Widget addFlexible({int? flex, Key? key, FlexFit? fit}) {
    if (null != this) {
      return Flexible(
        key: key,
        fit: fit ?? FlexFit.loose,
        child: this!,
        flex: flex ?? 1,
      );
    }
    return SizedBox();
  }
}
