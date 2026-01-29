import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';

extension ColorExtension on Color? {
  String toColorHex({Color defaultColor = BaseColorUtils.colorBlack}) {
    if (null != this) {
      return '#${this!.toARGB32().toRadixString(16).toUpperCase()}';
    }
    return defaultColor.toColorHex();
  }

  Color darkFuc({BuildContext? context, double opacity = 0.65}) {
    return (this ?? Colors.grey).withValues(
        alpha: (context ?? KayoPackage.share.maybeContext).isDark
            ? opacity
            : 1);
  }

  WidgetStateProperty<Color?>? materialStatePropertyFuc() {
    return WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      return this;
    });
  }

  ///深色模式颜色调暗
  // Color get dark => this.darkFuc();
  Color? get dark => this.toDark();

  Color? get darkNull => this.toDark();

  Color darkColor(Color? color) {
    return (KayoPackage.share.isDark() ? (color ?? (this.toDark())) : this) ??
        BaseColorUtils.colorAccent;
  }

  Color darkOpacity({double opacity = 1}) {
    return (this ?? Colors.grey)
        .withValues(alpha: KayoPackage.share.isDark() ? opacity : 1);
  }

  Color? toDark(
      {bool? textDarkOnlyOpacity,
      bool userDark = false,
      bool? darkTransColor = true}) {
    if (!KayoPackage.share.enableDark) return this;
    if (this == null || this!.a == 0) return this;
    if (darkTransColor != true) return this;

    if (!KayoPackage.share.isDark()) return this;

    // Use HSL color model for cleaner processing
    final hsl = HSLColor.fromColor(this!);
    // Invert lightness but keep it within readable range
    return hsl.withLightness((1 - hsl.lightness).clamp(0.2, 0.8)).toColor();
  }

  ///深色模式颜色调暗
  Color get darkLite => this.darkFuc(opacity: .90);

  WidgetStateProperty<Color?>? get materialStateProperty =>
      this.materialStatePropertyFuc();
}
