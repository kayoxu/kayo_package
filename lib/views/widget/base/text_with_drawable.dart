import 'package:flutter/material.dart';

@Deprecated('Use `Other` widget instead')
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

@Deprecated('Use `Other` widget instead')
class ShowInfoRow extends StatelessWidget {
  final String left;
  final Widget leftWidget;
  final String right;
  final Widget rightWidget;
  final int leftFlex;
  final int rightFlex;
  final Color bgColor;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color leftColor;
  final Color rightColor;
  final double leftFontSize;
  final double rightFontSize;
  final FontWeight leftFontWeight;
  final FontWeight rightFontWeight;
  final GestureTapCallback onTap;

  ShowInfoRow({
    this.left,
    this.leftWidget,
    this.right,
    this.rightWidget,
    this.leftFlex = 1,
    this.rightFlex = 2,
    this.bgColor = Colors.transparent,
    this.borderRadius,
    this.padding,
    this.margin,
    this.leftColor = const Color(0xff333333),
    this.rightColor = const Color(0xff666666),
    this.leftFontSize = 14,
    this.rightFontSize = 14,
    this.leftFontWeight = FontWeight.w600,
    this.rightFontWeight = FontWeight.normal,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget view = Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: borderRadius,
      ),
      child: Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: leftFlex,
            child: leftWidget ??
                Text(
                  left,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: leftColor,
                    fontSize: leftFontSize,
                    fontWeight: leftFontWeight,
                  ),
                ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: rightFlex,
            child: rightWidget ??
                Text(
                  right,
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: rightColor,
                    fontSize: rightFontSize,
                    fontWeight: rightFontWeight,
                  ),
                ),
          ),
        ],
      ),
    );
    Widget child;
    if (null == onTap) {
      child = view;
    } else {
      child = InkWell(
        onTap: onTap,
        child: view,
      );
    }
    return child;
  }
}

@Deprecated('Use `Other` widget instead')
class TextWithBg extends StatelessWidget {
  final double width;
  final double height;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final String text;
  final double fontSize;
  final Color fontColor;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final String bgImg;
  final Color bgColor;
  final BoxBorder border;
  final BorderRadiusGeometry borderRadius;
  final List<BoxShadow> boxShadow;
  final BoxShape shape;
  final Gradient gradient;
  final int maxLines;

  TextWithBg({
    this.width,
    this.height,
    this.alignment,
    this.padding,
    this.margin,
    this.text = "",
    this.fontSize = 14,
    this.fontColor,
    this.fontWeight,
    this.textAlign,
    this.bgImg,
    this.bgColor,
    this.border,
    this.borderRadius,
    this.boxShadow,
    this.shape = BoxShape.rectangle,
    this.gradient,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: alignment,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        image: null == bgImg
            ? null
            : DecorationImage(image: AssetImage(bgImg), fit: BoxFit.cover),
        color: bgColor,
        border: border,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
        shape: shape,
        gradient: gradient,
      ),
      child: Text(
        text,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: fontSize,
          color: fontColor,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
