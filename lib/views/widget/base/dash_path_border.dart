import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

///  kayo_package
///  views.widget.base
///
///  Created by kayoxu on 2019-08-06 19:59.
///  Copyright © 2019 kayoxu. All rights reserved.
class DashPathBorder extends Border {
  DashPathBorder({
    required this.dashArray,
    BorderSide top = BorderSide.none,
    BorderSide left = BorderSide.none,
    BorderSide right = BorderSide.none,
    BorderSide bottom = BorderSide.none,
  }) : super(
          top: top,
          left: left,
          right: right,
          bottom: bottom,
        );

  factory DashPathBorder.all({
    BorderSide borderSide = const BorderSide(),
    required CircularIntervalList<double> dashArray,
  }) {
    return DashPathBorder(
      dashArray: dashArray,
      top: borderSide,
      right: borderSide,
      left: borderSide,
      bottom: borderSide,
    );
  }

  final CircularIntervalList<double> dashArray;

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    TextDirection? textDirection,
    BoxShape shape = BoxShape.rectangle,
    BorderRadius? borderRadius,
  }) {
    if (isUniform) {
      switch (top.style) {
        case BorderStyle.none:
          return;
        case BorderStyle.solid:
          switch (shape) {
            case BoxShape.circle:
              assert(borderRadius == null,
                  'A borderRadius can only be given for rectangular boxes.');
              canvas.drawPath(
                dashPath(Path()..addOval(rect), dashArray: dashArray),
                top.toPaint(),
              );
              break;
            case BoxShape.rectangle:
              if (borderRadius != null) {
                final RRect rrect =
                    RRect.fromRectAndRadius(rect, borderRadius.topLeft);
                canvas.drawPath(
                  dashPath(Path()..addRRect(rrect), dashArray: dashArray),
                  top.toPaint(),
                );
                return;
              }
              canvas.drawPath(
                dashPath(Path()..addRect(rect), dashArray: dashArray),
                top.toPaint(),
              );

              break;
          }
          return;
      }
    }

    assert(borderRadius == null,
        'A borderRadius can only be given for uniform borders.');
    assert(shape == BoxShape.rectangle,
        'A border can only be drawn as a circle if it is uniform.');
  }
}

Widget dashLine(BuildContext context,
    {Color? color,
    double? rootHeight,
    double? dashHeight,
    double? dashWidth,
    double? dashSpace}) {
  dashSpace = dashSpace ?? 3;
  dashHeight = dashHeight ?? 1;
  dashWidth = dashWidth ?? 2;
  rootHeight = rootHeight ?? dashHeight;
  return CustomPaint(
    // size：当child为null时，代表默认绘制区域大小，如果有child则忽略此参数，画布尺寸则为child尺寸
    size: Size(double.infinity, rootHeight),
    painter: DashPainter(
        color: color,
        rootHeight: rootHeight,
        dashHeight: dashHeight,
        dashSpace: dashSpace,
        dashWidth: dashWidth),
  );
}

class DashPainter extends CustomPainter {
  final Color? color;
  final double? rootHeight;
  final double? dashHeight;
  final double? dashSpace;
  final double? dashWidth;

  DashPainter(
      {this.color,
      this.rootHeight,
      this.dashHeight,
      this.dashSpace,
      this.dashWidth});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint() // 创建一个画笔并配置其属性
      ..strokeWidth = this.dashHeight??1 // 画笔的宽度
      ..isAntiAlias = true // 是否抗锯齿
      ..color = this.color ?? Color(0xffECECEC); // 画笔颜色

    var max = size.width; // size获取到宽度
    var dashWidth = this.dashWidth;
    var dashSpace = this.dashSpace;
    double startX = 0;
    final space = (dashSpace! + dashWidth!);

    while (startX < max) {
      canvas.drawLine(Offset(startX, rootHeight! / 2),
          Offset(startX + dashWidth, rootHeight! / 2), paint);
      startX += space;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
