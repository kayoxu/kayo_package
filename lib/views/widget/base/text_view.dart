import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';

///  kayo_plugin
///  views.widget
///
///  Refactored for elegance and performance.
class TextView extends StatelessWidget {
  final String? text;
  final Color? color;
  final Color? borderColor;
  final String? fontFamily;
  final double size;
  final double? height; // Container height
  final double? width; // Container width
  final double? heightText; // Line height multiplier
  final EdgeInsets? padding;
  final EdgeInsets? margin;
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
  final TextOverflow? overflow;
  final TextScaler? textScaler;
  final Color? rightIconColor;
  final bool? textDarkOnlyOpacity;
  final MainAxisAlignment mainAxisAlignment;
  final bool? darkTransColor;
  final TextStyle? textStyle;

  const TextView(
    this.text, {
    Key? key,
    this.color = BaseColorUtils.colorGrey,
    this.borderColor,
    this.fontFamily,
    this.heightText,
    this.textScaler,
    this.borderWidth = 1,
    this.size = 14,
    this.height,
    this.width,
    this.padding,
    this.margin,
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
    this.rightIconColor,
    this.textDarkOnlyOpacity,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.darkTransColor = true,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 1. Build the Text Widget
    Widget textWidget = Text(
      text ?? '',
      textScaler: textScaler,
      maxLines: maxLine,
      overflow: overflow ?? TextOverflow.ellipsis,
      softWrap: true,
      textAlign: textAlign,
      style: textStyle ??
          TextStyle(
            height: heightText,
            color: color?.toDark(
                darkTransColor: darkTransColor,
                textDarkOnlyOpacity: textDarkOnlyOpacity),
            fontSize: size,
            fontFamily: fontFamily,
            fontWeight: fontWeight,
            decoration: TextDecoration.none,
          ),
    );

    // 2. Add Left Widget if present
    if (left != null) {
      textWidget = Row(
        mainAxisSize: mainAxisSize ?? MainAxisSize.max,
        mainAxisAlignment: mainAxisAlignment,
        children: <Widget>[left!, textWidget],
      );
    }

    // 3. Add Right Icon if present
    if (rightIcon != null) {
      // Note: Assuming ImageView is essentially an Image or similar.
      // If ImageView is refactored, this might need import update or usage change.
      // For now, using ImageView as it was likely imported.
      // If ImageView is local, we use it.
      Widget icon = ImageView(
        src: rightIcon,
        height: rightIconHeight,
        width: rightIconWidth,
        margin: rightIconMargin,
        color: rightIconColor?.dark,
      );

      // If textWidget was already a Row (has left), we might need to handle it.
      // But the original logic nested them.
      textWidget = Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          textWidget,
          icon,
        ],
      );
    }

    // 4. Wrap in Container if styling/layout is needed
    // Check if we need a container
    bool needsContainer = width != null ||
        height != null ||
        bgColor != null ||
        borderRadius != null ||
        (border == true) ||
        borderColor != null ||
        padding != null ||
        margin != null ||
        gradient != null ||
        alignment != null;

    if (needsContainer) {
      // Logic for Border
      BoxBorder? boxBorder;
      if (border == true) {
        boxBorder = Border.all(
          width: borderWidth,
          color: (borderColor ?? color ?? Colors.transparent).dark!,
        );
      }

      // Logic for Decoration
      BoxDecoration? decoration;
      if (bgColor != null || border == true || gradient != null) {
        decoration = BoxDecoration(
          color: bgColor?.toDark(
              darkTransColor: darkTransColor,
              textDarkOnlyOpacity: textDarkOnlyOpacity),
          borderRadius: borderRadius ?? BorderRadius.circular(radius),
          border: boxBorder,
          gradient: gradient,
        );
      }

      textWidget = Container(
        alignment: alignment,
        width: width,
        height: height,
        decoration: decoration,
        padding: padding,
        margin: onTap == null
            ? margin
            : null, // Handle margin outside InkWell if tap enabled
        child: textWidget,
      );
    }

    // 5. Wrap in InkWell/GestureDetector if clickable
    if (onTap != null) {
      // If we have a margin and we want the tap ripple to NOT include the margin,
      // we wrap the container in Padding (applied via margin) BEFORE InkWell?
      // Original logic: "margin: null == onTap ? margin : null" on Container,
      // and "margin: null == onTap ? null : margin" on Clickable.
      // This means the margin is OUTSIDE the tap area.

      return Padding(
        padding: margin ?? EdgeInsets.zero,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius ?? BorderRadius.circular(radius),
          child: needsContainer
              ? textWidget
              : Padding(padding: EdgeInsets.zero, child: textWidget),
          // If no container, InkWell needs a child. textWidget is fine.
          // Note: If needsContainer was true, textWidget is the Container.
        ),
      );
    }

    return textWidget;
  }
}
