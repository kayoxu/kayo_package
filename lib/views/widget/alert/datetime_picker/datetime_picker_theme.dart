import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DatePickerTheme extends Diagnosticable {
  final TextStyle cancelStyle;
  final Color doneColor;
  final TextStyle itemStyle;
  final Color backgroundColor;

  final double containerHeight;
  final double titleHeight;
  final double itemHeight;

  final double timeTitleHeight;
  final double timeTimeHeight;
  final double centerLineHeight;
  final double doneBtnHeight;

  const DatePickerTheme({
    this.cancelStyle = const TextStyle(color: Color(0xff999999), fontSize: 18),
    this.doneColor = const Color(0xff1E6FF4),
    this.itemStyle = const TextStyle(
        color: Color(0xFF333333), fontSize: 15, fontWeight: FontWeight.w500),
    this.backgroundColor = Colors.white,
    this.containerHeight = 132.0, //130
    this.titleHeight = 44.0,
    this.itemHeight = 42.0, //36
    this.timeTitleHeight = 27.0,
    this.timeTimeHeight = 27.0,
    this.centerLineHeight = 28.0, //32
    this.doneBtnHeight = 66,
  });
}
