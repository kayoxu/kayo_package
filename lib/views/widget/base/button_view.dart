import 'package:flutter/material.dart';
import 'package:kayo_package/utils/base_color_utils.dart';
 
/**
 *  flutter_demo
 *
 *
 *  Created by kayoxu on 2019/1/23.
 *  Copyright © 2019 kayoxu. All rights reserved.
 */

class ButtonView extends StatefulWidget {
  VoidCallback onPressed;
  Color bgColor;
  Color color;
  String text;
  double width;
  double height;
  double radius;
  BorderRadius borderRadius;

  EdgeInsets margin;
  EdgeInsets padding;

  Alignment alignment;

  bool showShadow;

  double textSize;

  FontWeight fontWeight;

  Widget left;
  bool safeArea;

  ButtonView({
    Key key,
    this.bgColor = BaseColorUtils.colorAccent,
    this.color = BaseColorUtils.colorWhite,
    @required VoidCallback this.onPressed,
    this.text = '提交',
    this.width,
    this.height,
    this.radius = 3,
    this.borderRadius,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.alignment,
    this.showShadow = true,
    this.textSize = 14,
    this.fontWeight,
    this.left,
    this.safeArea = false,
  }) : super(key: key);

  @override
  ButtonViewState createState() => ButtonViewState();
}

class ButtonViewState extends State<ButtonView> {
  @override
  Widget build(BuildContext context) {
    return widget.safeArea == true
        ? SafeArea(child: buildContainer())
        : buildContainer();
  }

  Container buildContainer() {
    return Container(
      margin: widget.margin,
      alignment: widget.alignment,
      child: RaisedButton(
        onPressed: widget.onPressed,
        elevation: widget.showShadow ? 4 : 0,
        highlightElevation: widget.showShadow ? 8 : 0,
        disabledElevation: 0,
        child: Padding(
          padding: widget.padding,
          child: Container(
            width: widget.width,
            height: widget.height,
            alignment: null == widget.height ? null : Alignment.center,
            child: null == widget.left
                ? text()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[widget.left, text()],
                  ),
          ),
        ),
        color: widget.bgColor,
        shape: RoundedRectangleBorder(
            borderRadius: null == widget.borderRadius
                ? BorderRadius.circular(widget.radius)
                : widget.borderRadius),
      ),
    );
  }

  Text text() {
    return Text(
      widget.text,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: widget.color,
          fontSize: widget.textSize,
          fontWeight: widget.fontWeight),
    );
  }
}
