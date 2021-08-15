import 'package:flutter/material.dart';
import 'package:kayo_package/utils/base_color_utils.dart';

import 'clickable.dart';

///  flutter_demo
///
///
///  Created by kayoxu on 2019/1/23.
///  Copyright © 2019 kayoxu. All rights reserved.

@deprecated
class ButtonView extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? bgColor;
  final Color? color;
  final String? text;
  final double? width;
  final double? height;
  final double? radius;
  final BorderRadius? borderRadius;

  final EdgeInsets? margin;
  final EdgeInsets? padding;

  final Alignment? alignment;

  final bool? showShadow;

  final double? textSize;

  final FontWeight? fontWeight;

  final Widget? left;
  final bool? safeArea;
  final Color? borderColor;
  final double? borderWidth;
  final Color? bgStartColor;
  final Color? bgEndColor;

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
  Widget build(BuildContext context) {
    return safeArea == true
        ? SafeArea(child: buildContainer())
        : buildContainer();
  }

  Container buildContainer() {
    return Container(
      margin: margin,
      alignment: alignment,
      child: null == borderColor
          ? RaisedButton(
              onPressed: onPressed,
              elevation: (showShadow == true) ? 3 : 0,
              highlightElevation: showShadow == true ? 8 : 0,
              disabledElevation: 0,
              child: Padding(
                padding: padding ?? EdgeInsets.only(left: 0),
                child: Container(
                  width: width,
                  height: height,
                  alignment: null == height ? null : Alignment.center,
                  child: null == left
                      ? textV()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[left!, textV()],
                        ),
                ),
              ),
              color: bgColor,
              shape: RoundedRectangleBorder(
                  borderRadius: null == borderRadius
                      ? BorderRadius.circular(radius ?? 0)
                      : borderRadius!),
            )
          : Clickable(
              radius: radius ?? 0,
              bgColor: BaseColorUtils.transparent,
              decoration: (null != borderColor &&
                      null == bgStartColor &&
                      null == bgEndColor)
                  ? ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(radius ?? 0)),
                          side: BorderSide(
                              color: borderColor!,
                              style: BorderStyle.solid,
                              width: borderWidth!)))
                  : (null == bgStartColor && null == bgEndColor
                      ? null
                      : BoxDecoration(
                          gradient: LinearGradient(colors: [
                            bgStartColor ?? bgColor!,
                            bgEndColor ?? bgColor!
                          ]),
                          borderRadius: BorderRadius.circular(radius ?? 0))),
              onTap: onPressed,
              child: Container(
                width: width,
                height: height,
                alignment: null == height ? null : Alignment.center,
                child: null == left
                    ? textV()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[left!, textV()],
                      ),
              ),
            ),
    );
  }

  Text textV() {
    return Text(
      text ?? '',
      textAlign: TextAlign.center,
      style:
          TextStyle(color: color, fontSize: textSize, fontWeight: fontWeight),
    );
  }
}
