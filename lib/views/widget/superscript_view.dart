import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';

import 'base/clickable.dart';
import 'base/image_view.dart';
import 'base/text_view.dart';

///
///  kayo_package
///  superscript_view.dart
///
///  Created by kayoxu on 2020/6/15 at 10:59 AM
///  Copyright © 2020 kayoxu. All rights reserved.
///

class SuperScriptView extends StatelessWidget {
  Function onTap;
  String iconSrc;
  Color iconTint;
  double iconSize;
  double countSize;
  String count;
  Color countColor;
  Color countBgColor;
  EdgeInsets margin;
  EdgeInsets padding;

  SuperScriptView(
      {this.onTap,
      this.iconTint,
      this.iconSrc,
      this.count,
      this.margin,
      this.countBgColor,
      this.padding,
      this.iconSize,
      this.iconSize,
      this.countSize,
      this.countColor});

  @override
  Widget build(BuildContext context) {
    var superScriptValue = BaseSysUtils.getSuperScriptValue(
        BaseSysUtils.str2Int(count ?? '0', defaultValue: 0));
    return Clickable(
      onTap: onTap,
      alignment: Alignment.center,
      radius: 6,
      padding: padding,
      margin: margin ?? EdgeInsets.only(right: 10),
      child: Stack(
        children: <Widget>[
          Positioned(
              child: ImageView(
            height: iconSize ?? 24,
            width: iconSize ?? 24,
            color: iconTint,
            src: iconSrc,
          )),
          Positioned(
              right: 1,
              top: 3,
              child: VisibleView(
                  visible: BaseSysUtils.empty(superScriptValue)
                      ? Visible.invisible
                      : Visible.visible,
                  child: TextView(
                    '${superScriptValue}',
                    radius: 10,
                    size: countSize ?? 8,
//                    height: 10,
                    padding: EdgeInsets.only(left: 2, right: 2),
                    textAlign: TextAlign.center,
                    alignment: Alignment.center,
                    color: countColor ?? BaseColorUtils.white,
                    bgColor: countBgColor ?? BaseColorUtils.colorRed,
                  ))),
        ],
      ),
    );
  }
}
