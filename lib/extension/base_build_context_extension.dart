import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';

extension BuildContextExtension on BuildContext? {
  bool get isDark => theme.brightness == Brightness.dark;

  Color get backgroundColor => theme.scaffoldBackgroundColor;

  Color get dialogBackgroundColor => theme.canvasColor;

  Color get surfaceColor => theme.colorScheme.surface;
  Color get onSurfaceColor => theme.colorScheme.onSurface;
  Color get cardColor => theme.cardColor;
  Color get dividerColor => theme.dividerColor;

  ///获取主题
  ThemeData get theme {
    final context = this ?? KayoPackage.share.maybeContext;
    return context == null ? ThemeData.fallback() : Theme.of(context);
  }
}
