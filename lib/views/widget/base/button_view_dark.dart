import 'package:flutter/material.dart';
import 'package:kayo_package/extension/base_build_context_extension.dart';
import 'package:kayo_package/views/widget/base/button_view.dart';

/// 默认字号18，白字蓝底，高度48
class ButtonViewDark extends StatelessWidget {

  const ButtonViewDark({
    Key? key,
    this.text = '',
    this.fontSize = 18,
    this.textColor,
    this.disabledTextColor,
    this.backgroundColor,
    this.disabledBackgroundColor,
    this.minHeight = 48.0,
    this.minWidth = double.infinity,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.radius = 2.0,
    this.side = BorderSide.none,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final double fontSize;
  final Color? textColor;
  final Color? disabledTextColor;
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;
  final double? minHeight;
  final double? minWidth;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;
  final double radius;
  final BorderSide side;

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;

    return ButtonView(
      onPressed: onPressed  ,
      text: text,
      textSize: fontSize,
      color: textColor,
      bgColor: backgroundColor,
      // width: minWidth,
    );
  }
}
