import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';
import 'package:kayo_package/utils/base_color_utils.dart';

///  kayo_plugin
///  views.widget
///
///  Created by kayoxu on 2019/2/1 11:26 AM.
///  Copyright © 2019 kayoxu. All rights reserved.

class TextView extends StatefulWidget {
  TextView(this.text,
      {this.color = BaseColorUtils.colorGrey,
      this.borderColor,
      this.borderWidth = 1,
      this.size = 16,
      this.height,
      this.width,
      this.padding = const EdgeInsets.all(0),
      this.margin = const EdgeInsets.all(0),
      this.textAlign = TextAlign.left,
      this.fontWeight,
      this.borderRadius,
      this.bgColor,
      this.radius = 0,
      this.maxLine,
      this.left,
      this.gradient,
      this.border,
      this.alignment,
      this.mainAxisSize,
      this.rightIcon,
      this.rightIconHeight = 10,
      this.rightIconWidth = 8,
      this.rightIconMargin = const EdgeInsets.only(left: 3),
      this.onTap,
      this.overflow,
      this.rightIconColor});

  final Color color;
  final Color? borderColor;
  final String text;
  final double size;
  final double? height;
  final double? width;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final TextAlign textAlign;
  final FontWeight? fontWeight;
  final BorderRadius? borderRadius;

  final Color? bgColor;
  final double radius;
  final double borderWidth;

  final int? maxLine;

  final Widget? left;
  final Gradient? gradient;
  final bool? border;
  final Alignment? alignment;
  final MainAxisSize? mainAxisSize;
  final String? rightIcon;
  final double rightIconHeight;
  final double rightIconWidth;
  final EdgeInsets rightIconMargin;
  final Function()? onTap;
  final Color? rightIconColor;
  final TextOverflow? overflow;

  @override
  TextViewState createState() => TextViewState();
}

class TextViewState extends State<TextView> {
  @override
  Widget build(BuildContext context) {
    var text = Text(
      widget.text ?? '',
      maxLines: widget.maxLine,
      overflow: widget.overflow ?? TextOverflow.ellipsis,
      softWrap: true,
      textAlign: widget.textAlign,
      style: TextStyle(
        color: widget.color,
        fontSize: widget.size,
        fontWeight: widget.fontWeight,
        decoration: TextDecoration.none,
        /*background:Paint()..color = Colors.yellowAccent*/
      ),
    );

    var v = null == widget.left
        ? text
        : Row(
            mainAxisSize: widget.mainAxisSize ?? MainAxisSize.max,
            children: <Widget>[widget.left!, text],
          );

    var c = Container(
      alignment: widget.alignment,
      width: widget.width,
      height: widget.height,
      decoration: ((null != widget.bgColor || true == widget.border)
          ? BoxDecoration(
              color: widget.bgColor,
              borderRadius:
                  widget.borderRadius ?? BorderRadius.circular(widget.radius),
              border: widget.border != true
                  ? null
                  : Border.all(
                      width: widget.borderWidth,
                      color: widget.borderColor ?? widget.color),
              gradient: widget.gradient,
            )
          : null),
      padding: widget.padding,
      margin: null == widget.onTap ? widget.margin : null,
      child: null == widget.rightIcon
          ? v
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                v,
                ImageView(
                  height: widget.rightIconHeight,
                  width: widget.rightIconWidth,
                  margin: widget.rightIconMargin,
                  src: widget.rightIcon,
                  color: widget.rightIconColor,
                )
              ],
            ),
    );

    return null == widget.onTap
        ? c
        : Clickable(
            radius: widget.radius,
            margin: null == widget.onTap ? null : widget.margin,
            onTap: widget.onTap,
            bgColor: BaseColorUtils.transparent,
            child: c,
          );
  }
}
