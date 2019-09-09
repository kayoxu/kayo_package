import 'package:flutter/material.dart';
import 'package:kayo_package/utils/base_color_utils.dart';

/**
 *  kayo_plugin
 *  views.widget.base
 *
 *  Created by kayoxu on 2019/2/13 3:18 PM.
 *  Copyright © 2019 kayoxu. All rights reserved.
 */

class Scrollview extends StatelessWidget {
  List<Widget> children;
  EdgeInsets padding;
  EdgeInsets margin;
  Axis orientation;
  Color bgColor;
  Decoration decoration;
  Widget headerView;
  double height;

  Scrollview({Key key,
    @required this.children,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.orientation = Axis.vertical,
    this.bgColor = BaseColorUtils.colorWindow,
    this.decoration,
    this.height,
    this.headerView})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (null != headerView) children.insert(0, headerView);

    return Container(
      color: bgColor,
      padding: padding,
      height: height,
      margin: margin,
      decoration: decoration,
      child: ListView(
        scrollDirection: orientation,
        children: children,
        reverse: false,
        shrinkWrap: false,
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
        addSemanticIndexes: false,
      ),
    );
  }
}
