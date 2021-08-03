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
 final Function()? onTap;
 final String? iconSrc;
 final  Color? iconTint;
 final  double? iconSize;
 final double countSize;
 final String? count;
 final Color? countColor;
 final  Color? countBgColor;
 final  EdgeInsets? margin;
 final  EdgeInsets? padding;
 final EdgeInsets? iconPadding;

  SuperScriptView(
      {this.onTap,
      this.iconTint,
      this.iconSrc,
      this.count,
      this.margin,
      this.countBgColor,
      this.padding,
      this.iconPadding,
      this.iconSize,
      this.countSize = 8,
      this.countColor});

  @override
  Widget build(BuildContext context) {
    var superScriptValue = BaseSysUtils.getSuperScriptValue(
        BaseSysUtils.str2Int(count ?? '0', defaultValue: 0));
    return Clickable(
      onTap: onTap,
      alignment: Alignment.center,
      padding: padding,
      radius: 6,
      margin: margin ?? EdgeInsets.only(right: 10),
      child: Stack(
        children: <Widget>[
          Positioned(
              child: ImageView(
            margin: iconPadding ?? EdgeInsets.all(0),
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
                    '$superScriptValue',
                    radius: 20,
                    size: countSize,
                    height: countSize + 2,
                    padding: EdgeInsets.only(
                        left: countSize / 3, right: countSize / 3),
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
