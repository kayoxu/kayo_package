import 'package:flutter/material.dart';
import 'package:kayo_package/utils/BaseColorUtils.dart';
 
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

  Scrollview(
      {Key key,
      @required this.children,
      this.padding = const EdgeInsets.all(0),
      this.margin = const EdgeInsets.all(0),
      this.orientation = Axis.vertical,
      this.bgColor = BaseColorUtils.colorWindow,
      this.decoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      padding: padding,
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
