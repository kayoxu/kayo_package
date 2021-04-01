import 'package:flutter/material.dart';
import 'package:kayo_package/utils/base_color_utils.dart';

import 'clickable.dart';

///  flutter_demo
///
///
///  Created by kayoxu on 2019/1/23.
///  Copyright © 2019 kayoxu. All rights reserved.

class ButtonView extends StatefulWidget {
  VoidCallback? onPressed;
  Color? bgColor;
  Color? color;
  String? text;
  double? width;
  double? height;
  double? radius;
  BorderRadius? borderRadius;

  EdgeInsets? margin;
  EdgeInsets? padding;

  Alignment? alignment;

  bool? showShadow;

  double? textSize;

  FontWeight? fontWeight;

  Widget? left;
  bool? safeArea;
  Color? borderColor;
  double? borderWidth;
  Color? bgStartColor;
  Color? bgEndColor;

  ButtonView({
    Key? key,
    this.bgColor = BaseColorUtils.colorAccent,
    this.color = BaseColorUtils.colorWhite,
    required VoidCallback this.onPressed,
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
    this.borderColor,
    this.borderWidth = 1,
    this.bgStartColor,
    this.bgEndColor,
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
      child: null == widget.borderColor
          ? RaisedButton(
              onPressed: widget.onPressed,
              elevation: (widget.showShadow == true) ? 3 : 0,
              highlightElevation: widget.showShadow == true ? 8 : 0,
              disabledElevation: 0,
              child: Padding(
                padding: widget.padding ?? EdgeInsets.only(left: 0),
                child: Container(
                  width: widget.width,
                  height: widget.height,
                  alignment: null == widget.height ? null : Alignment.center,
                  child: null == widget.left
                      ? text()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[widget.left!, text()],
                        ),
                ),
              ),
              color: widget.bgColor,
              shape: RoundedRectangleBorder(
                  borderRadius: null == widget.borderRadius
                      ? BorderRadius.circular(widget.radius ?? 0)
                      : widget.borderRadius!),
            )
          : Clickable(
              radius: widget.radius ?? 0,
              bgColor: BaseColorUtils.transparent,
              decoration: (null != widget.borderColor &&
                      null == widget.bgStartColor &&
                      null == widget.bgEndColor)
                  ? ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(widget.radius ?? 0)),
                          side: BorderSide(
                              color: widget.borderColor!,
                              style: BorderStyle.solid,
                              width: widget.borderWidth!)))
                  : (null == widget.bgStartColor && null == widget.bgEndColor
                      ? null
                      : BoxDecoration(
                          gradient: LinearGradient(colors: [
                            widget.bgStartColor ?? widget.bgColor!,
                            widget.bgEndColor ?? widget.bgColor!
                          ]),
                          borderRadius:
                              BorderRadius.circular(widget.radius ?? 0))),
              onTap: widget.onPressed,
              child: Container(
                width: widget.width,
                height: widget.height,
                alignment: null == widget.height ? null : Alignment.center,
                child: null == widget.left
                    ? text()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[widget.left!, text()],
                      ),
              ),
            ),
    );
  }

  Text text() {
    return Text(
      widget.text ?? '',
      textAlign: TextAlign.center,
      style: TextStyle(
          color: widget.color,
          fontSize: widget.textSize,
          fontWeight: widget.fontWeight),
    );
  }
}
