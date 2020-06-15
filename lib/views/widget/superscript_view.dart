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
  String count;
  EdgeInsets margin;

  SuperScriptView(
      {this.onTap, this.iconTint, this.iconSrc, this.count, this.margin});

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onTap: onTap,
      alignment: Alignment.center,
      margin: margin ?? EdgeInsets.only(right: 20),
      child: Stack(
        children: <Widget>[
          Positioned(
              child: ImageView(
            height: 24,
            width: 24,
            color: iconTint,
            src: iconSrc,
          )),
          Positioned(
              right: 1,
              top: 3,
              child: TextView(
                count ?? '',
                radius: 10,
                size: 8,
                height: 10,
                padding: EdgeInsets.only(left: 2, right: 2),
                textAlign: TextAlign.center,
                alignment: Alignment.center,
                color: BaseColorUtils.white,
                bgColor: BaseColorUtils.colorRed,
              )),
        ],
      ),
    );
  }
}
