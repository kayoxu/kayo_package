import 'package:flutter/material.dart';
import 'package:kayo_package/utils/BaseColorUtils.dart';
 
/**
 *  kayo_plugin
 *  views.widget
 *
 *  Created by kayoxu on 2019/2/1 11:26 AM.
 *  Copyright © 2019 kayoxu. All rights reserved.
 */

class TextView extends StatefulWidget {
  TextView(
    this.text, {
    this.color = BaseColorUtils.colorGrey,
    this.size = 16,
    this.height = null,
    this.width = null,
    this.padding = const EdgeInsets.only(left: 0, top: 4, right: 0, bottom: 4),
    this.margin = const EdgeInsets.all(0),
    this.textAlign = TextAlign.left,
    this.fontWeight,
    this.bgColor,
    this.radius = 0,
    this.maxLine,
    this.left,
    this.gradient,
    this.border,
  });

  Color color;
  String text;
  double size;
  double height;
  double width;
  EdgeInsets padding;
  EdgeInsets margin;
  TextAlign textAlign;
  FontWeight fontWeight;

  Color bgColor;
  double radius;

  int maxLine;

  Widget left;
  Gradient gradient;
  bool border;

//      : super(key: key)

  @override
  TextViewState createState() => TextViewState();
}

class TextViewState extends State<TextView> {
  @override
  Widget build(BuildContext context) {
    var text = Text(
      widget.text,
      maxLines: widget.maxLine,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
      textAlign: widget.textAlign,
      style: TextStyle(
          color: widget.color,
          fontSize: widget.size,
          fontWeight: widget.fontWeight,
          decoration: TextDecoration.none
          /*background:Paint()..color = Colors.yellowAccent*/),
    );

    return Container(
      width: widget.width,
      decoration: ((null != widget.bgColor || true == widget.border)
          ? BoxDecoration(
              color: widget.bgColor,
              borderRadius: BorderRadius.circular(widget.radius),
              border: widget.border != true
                  ? null
                  : Border.all(width: 1, color: widget.color),
              gradient: widget.gradient,
            )
          : null),
      padding: widget.padding,
      margin: widget.margin,
      child: null == widget.left
          ? text
          : Row(
              children: <Widget>[widget.left, text],
            ),
    );
  }
}
