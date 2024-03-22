import 'package:flutter/material.dart';
import 'package:kayo_package/utils/base_color_utils.dart';
import 'package:kayo_package/extension/base_widget_extension.dart';

import 'clickable.dart';
import 'text_view.dart';

///  flutter_demo
///
///
///  Created by kayoxu on 2019/1/23.
///  Copyright © 2019 kayoxu. All rights reserved.

class ButtonRootView extends StatelessWidget {
  final bool safeArea;
  final bool warp;
  final List<Widget> children;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  const ButtonRootView({
    Key? key,
    required this.children,
    this.margin,
    this.padding,
    this.safeArea = false,
    this.warp = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return safeArea == true
        ? SafeArea(child: buildContainer())
        : buildContainer();
  }

  Widget buildContainer() {
    var widget = true == warp
        ? Wrap(
            children: children,
          )
        : Row(children: children);
    return null != padding || null != margin
        ? Container(child: widget, padding: padding, margin: margin)
        : widget;
  }
}

Widget buttonView(
    {String? title = '确定',
    Color? color,
    Color? bgColor,
    EdgeInsets? margin,
    EdgeInsets? padding,
    bool? textDarkOnlyOpacity,
    int? flex,
    Function()? onTap}) {
  return TextView(
    title,
    margin: margin ?? EdgeInsets.only(left: 8, right: 8),
    bgColor: bgColor ?? BaseColorUtils.colorAccent,
    color: color ?? BaseColorUtils.white,
    textAlign: TextAlign.center,
    textDarkOnlyOpacity: textDarkOnlyOpacity,
    padding: padding ?? EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
    radius: 4,
    onTap: onTap,
  ).addExpanded(flex: flex);
}
