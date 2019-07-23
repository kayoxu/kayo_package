import 'package:flutter/material.dart';
import 'package:kayo_package/utils/BaseColorUtils.dart';
 import 'package:kayo_package/views/widget/base/Clickable.dart';

/**
 *  kayo_plugin
 *  views.widget
 *
 *  Created by kayoxu on 2019/2/11 4:17 PM.
 *  Copyright © 2019 kayoxu. All rights reserved.
 */

class CardItem extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color color;
  final Color shadowColor;
  final RoundedRectangleBorder shape;
  final double elevation;
  final VoidCallback onPressed;

  CardItem({
    @required this.child,
    this.margin,
    this.padding,
    this.color,
    this.shape,
    this.elevation = .5,
    this.onPressed,
    this.shadowColor = BaseColorUtils.colorGreyLiteLite,
  });

  @override
  Widget build(BuildContext context) {
    EdgeInsets margin = this.margin;
    EdgeInsets padding = this.padding;

    RoundedRectangleBorder shape = this.shape;
    Color color = this.color;
    margin ??= EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 0);

    padding ??= EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0, bottom: 8.0);

    shape ??= new RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(3)));
    color ??= BaseColorUtils.cardWhite;

    return Clickable(
      elevation: elevation,
      radius: 3,
      bgColor: color,
      child: child,
      shadowColor:shadowColor ,
      margin: margin,
      padding: padding,
      onTap: onPressed,
//            alignment: Alignment.topLeft,
    );

    /*null == onPressed
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(3)),
              color: color,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: ColorUtils.cardShadow,
                    blurRadius: 4.0,
                    spreadRadius: 2.0,
                    offset: Offset(0, 2)),
              ],
            ),
            margin: margin,
            padding: padding,
            child: child,
//            alignment: Alignment.topLeft,
          )
        : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(3)),
              color: color,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: ColorUtils.cardShadow,
                    blurRadius: 4.0,
                    spreadRadius: 2.0,
                    offset: Offset(0, 2)),
              ],
            ),
            margin: margin,
            child: FlatButton(
              padding: EdgeInsets.all(0),
              child: Container(
                padding: padding,
                child: child,
//                alignment: Alignment.topLeft,
              ),
              onPressed: onPressed,
            ),
          );*/

//    Card(
//        elevation: elevation,
//        shape: shape,
//        color: color,
//        margin: margin,
//        child: null == onPressed
//            ? Container(
//
//          padding: padding,
//          child: child,
////          alignment: Alignment.topLeft,
//        )
//            : FlatButton(
//          padding: EdgeInsets.all(0),
//          child: Container(
//            padding: padding,
//            child: child,
////            alignment: Alignment.topLeft,
//          ),
//          onPressed: onPressed,
//        ));
  }
}
