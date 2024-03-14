import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';
import '../kayo_package_utils.dart';
import 'base_build_context_extension.dart';

extension ColorExtension on Color? {
  Color darkFuc({BuildContext? context, double opacity = 0.65}) {
    return (this ?? Colors.grey).withOpacity(
        (context ?? KayoPackage.share.navigatorKey.currentContext).isDark
            ? opacity
            : 1);
  }

  MaterialStateProperty<Color?>? materialStatePropertyFuc() {
    return MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          return this;
        });
  }

  ///深色模式颜色调暗
  // Color get dark => this.darkFuc();
  Color get dark => this.toDark()!;

  Color? get darkNull => this.toDark();

  Color darkColor(Color? color) {
    return (KayoPackage.share.isDark() ? (color ?? (this.toDark())) : this) ??
        BaseColorUtils.colorAccent;
  }

  Color darkOpacity({double opacity = 1}) {
    return (this ?? Colors.grey)
        .withOpacity(KayoPackage.share.isDark() ? opacity : 1);
  }

  Color? toDark() {
    if (null == this) {
      return this;
    }
    if (null == this) {
      return this;
    }
    Color color = this!;
    final double opacity = color.opacity;
    if (opacity == 0) {
      return this;
    }

    if (KayoPackage.share.navigatorKey.currentContext.isDark) {
      //  如果color是黑色则转换为白色，如果为灰色则转换为灰白 。
      //  记住 浅黑则转换为浅白，浅灰则转换为浅灰白。如果是深黑则转换为深白，如果是深灰则转换为深灰白
      if (color == null) {
        // 如果输入颜色为 null，则返回默认颜色（例如 BaseColorUtils.colorAccent）
        return BaseColorUtils.colorAccent;
      }

      // 提取红色、绿色和蓝色分量
      final int red = color.red;
      final int green = color.green;
      final int blue = color.blue;

      // 计算颜色的亮度
      final double luminance = 0.299 * red + 0.587 * green + 0.114 * blue;
      // 根据亮度判断是否使用浅色或深色
      if (luminance < 128) {
        int s = (red > 189 ? 1 : 0) + (green > 189 ? 1 : 0) +
            (blue > 189 ? 1 : 0);
        if (s < 3 && s > 0) {
          return color.withOpacity(.89);
        }
        // 深色：反转 RGB 值
        final int darkRed = 255 - red;
        final int darkGreen = 255 - green;
        final int darkBlue = 255 - blue;
        return Color.fromRGBO(darkRed, darkGreen, darkBlue, 1.0);
      } else if (red > 189 && green > 189 && blue > 189) {
        if (red > 250 && green > 250 && blue > 250) {
          return '#333333'.toColor();
        }
        final int darkRed = 255 - red;
        final int darkGreen = 255 - green;
        final int darkBlue = 255 - blue;
        return Color.fromRGBO(darkRed, darkGreen, darkBlue, 1.0);
      } else {
        // 浅色：降低不透明度以减弱颜色强度，但避免与原色相差太大
        final double opacity = 0.89;
        final int adjustedRed = (red * opacity).toInt();
        final int adjustedGreen = (green * opacity).toInt();
        final int adjustedBlue = (blue * opacity).toInt();

        // 避免红色变成绿色
        final int minComponent = 50; // 最小分量值
        final int adjustedGreenSafe = adjustedGreen.clamp(minComponent, 255);
        return Color.fromRGBO(
            adjustedRed, adjustedGreenSafe, adjustedBlue, 1.0);
      }
    } else {
      return color;
    }
  }

  ///深色模式颜色调暗
  Color get darkLite => this.darkFuc(opacity: .90);

  MaterialStateProperty<Color?>? get materialStateProperty =>
      this.materialStatePropertyFuc();
}
