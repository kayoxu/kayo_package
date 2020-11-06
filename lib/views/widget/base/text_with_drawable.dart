import 'package:flutter/material.dart';


class TextWithDrawable extends StatelessWidget {
  final String text;
  final Color fontColor;
  final double fontSize;
  final FontWeight fontWeight;
  final Widget drawableStart;
  final Widget drawableTop;
  final Widget drawableEnd;
  final Widget drawableBottom;
  final double drawableStartPadding;
  final double drawableTopPadding;
  final double drawableEndPadding;
  final double drawableBottomPadding;
  final double drawablePadding;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Decoration decoration;
  final int maxLines;
  final bool isFill;
  final TextAlign textAlign;

  TextWithDrawable({
    this.text = '',
    this.fontColor = const Color(0xff666666),
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.drawableStart,
    this.drawableTop,
    this.drawableEnd,
    this.drawableBottom,
    this.drawableStartPadding,
    this.drawableTopPadding,
    this.drawableEndPadding,
    this.drawableBottomPadding,
    this.drawablePadding = 0,
    this.padding,
    this.margin,
    this.decoration,
    this.maxLines = 1,
    this.isFill = false,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    bool onlyRow = (null != drawableStart || null != drawableEnd) &&
        (null == drawableTop && null == drawableBottom);
    bool onlyColumn = (null != drawableTop || null != drawableBottom) &&
        (null == drawableStart && null == drawableEnd);
    Widget txt = Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: fontColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
    Widget onlyRowWidget = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        if (null != drawableStart) drawableStart,
        SizedBox(
            width: null == drawableStartPadding
                ? drawablePadding
                : drawableStartPadding),
        isFill ? Expanded(child: txt) : txt,
        SizedBox(
            width: null == drawableEndPadding
                ? drawablePadding
                : drawableEndPadding),
        if (null != drawableEnd) drawableEnd,
      ],
    );
    Widget onlyColumnWidget = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        if (null != drawableTop) drawableTop,
        SizedBox(
            height: null == drawableTopPadding
                ? drawablePadding
                : drawableTopPadding),
        isFill ? Expanded(child: txt) : txt,
        SizedBox(
            height: null == drawableBottomPadding
                ? drawablePadding
                : drawableBottomPadding),
        if (null != drawableBottom) drawableBottom,
      ],
    );
    Widget child;
    if (onlyRow) {
      child = onlyRowWidget;
    } else if (onlyColumn) {
      child = onlyColumnWidget;
    } else {
//      child = Row(
//        mainAxisSize: MainAxisSize.min,
//        crossAxisAlignment: CrossAxisAlignment.center,
//        children: <Widget>[
//          if (null != drawableStart) drawableStart,
//          SizedBox(
//              width: null == drawableStartPadding
//                  ? drawablePadding
//                  : drawableStartPadding),
//          onlyColumnWidget,
//          SizedBox(
//              width: null == drawableEndPadding
//                  ? drawablePadding
//                  : drawableEndPadding),
//          if (null != drawableEnd) drawableEnd,
//        ],
//      );
      child = onlyRowWidget;
    }
    return Container(
      width: isFill && onlyRow ? double.infinity : null,
      height: isFill && onlyColumn ? double.infinity : null,
      padding: padding,
      margin: margin,
      decoration: decoration,
      child: child,
    );
  }
}
