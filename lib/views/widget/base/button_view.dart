import 'package:flutter/material.dart';
import 'package:kayo_package/extension/_index_extension.dart';
import 'package:kayo_package/utils/base_color_utils.dart';

///  Refactored ButtonView
///  Moved from MaterialButton to ElevatedButton/OutlinedButton/InkWell paradigm.
class ButtonView extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? bgColor;
  final Color? color;
  final String? text;
  final double? width;
  final double? height;
  final double radius;
  final BorderRadius? borderRadius;

  final EdgeInsets? margin;
  final EdgeInsets? padding;

  final Alignment? alignment;

  final bool showShadow;

  final double textSize;

  final FontWeight? fontWeight;

  final Widget? left;
  final bool safeArea;
  final Color? borderColor;
  final double borderWidth;
  final Color? bgStartColor;
  final Color? bgEndColor;
  final bool? textDarkOnlyOpacity;

  const ButtonView({
    Key? key,
    required this.onPressed,
    this.bgColor,
    this.color = BaseColorUtils.colorWhite,
    this.text = '提交',
    this.width,
    this.height,
    this.radius = 3,
    this.borderRadius,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
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
    this.textDarkOnlyOpacity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buttonContent = _buildContent(context);

    if (safeArea) {
      buttonContent = SafeArea(child: buttonContent);
    }

    // Outer container for margin/alignment
    if (margin != null || alignment != null) {
      return Container(
        margin: margin,
        alignment: alignment,
        child: buttonContent,
      );
    }

    return buttonContent;
  }

  Widget _buildContent(BuildContext context) {
    // CONTENT (Text + Optional Icon)
    Widget child = Container(
      width: width,
      height: height,
      alignment: (height != null) ? Alignment.center : null,
      child: Row(
        mainAxisSize: MainAxisSize.min, // shrink to fit text
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (left != null) ...[left!, const SizedBox(width: 8)],
          Flexible(
            child: Text(
              text ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color?.toDark(
                    userDark: context.isDark,
                    textDarkOnlyOpacity: textDarkOnlyOpacity),
                fontSize: textSize,
                fontWeight: fontWeight,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );

    BorderRadiusGeometry effectiveRadius =
        borderRadius ?? BorderRadius.circular(radius);

    // Case 1: Gradient Button
    if (bgStartColor != null || bgEndColor != null) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: effectiveRadius,
          gradient: LinearGradient(
            colors: [
              (bgStartColor ?? bgColor ?? BaseColorUtils.colorAccent)
                  .darkFuc(context: context),
              (bgEndColor ?? bgColor ?? BaseColorUtils.colorAccent)
                  .darkFuc(context: context)
            ],
          ),
          boxShadow: showShadow
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                  )
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: effectiveRadius as BorderRadius?,
            // Note: casting broadly here, usually safe. If effectiveRadius is non-uniform, might issue.
            // But API implies standard border radius usage.
            child: Padding(
              padding: padding ?? EdgeInsets.zero,
              child: child,
            ),
          ),
        ),
      );
    }

    // Case 2: Border (Outlined) Button
    if (borderColor != null) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: borderColor!.toDark(userDark: context.isDark)!,
            width: borderWidth,
          ),
          shape: RoundedRectangleBorder(borderRadius: effectiveRadius),
          padding: padding,
          elevation: 0,
          backgroundColor: bgColor?.toDark(userDark: context.isDark) ??
              Colors.transparent, // Allow fill even if outlined
        ),
        child: child,
      );
    }

    // Case 3: Filled Button (ElevatedButton equivalent)
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: (bgColor ?? BaseColorUtils.colorAccent)
            .toDark(userDark: context.isDark),
        elevation: showShadow ? 3 : 0,
        shape: RoundedRectangleBorder(borderRadius: effectiveRadius),
        padding: padding,
      ),
      child: child,
    );
  }
}
