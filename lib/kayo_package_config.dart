import 'package:flutter/material.dart';

typedef KayoOnNotifyPop = void Function(
  BuildContext context,
  String page,
  Map<String, dynamic>? resultArgs,
  dynamic resultData,
);

class KayoPackageConfig {
  final String? nullText;
  final String? loadingText;
  final String? formatDefault;
  final String? imageSourcePrefix;
  final String? dataPickerLocale;
  final Locale? locale;
  final bool? ignoreSSL;
  final bool? enableDark;
  final int? reLoginCode;
  final Color? colorPrimary;
  final Color? colorPrimaryLight;
  final Color? colorPrimaryDark;
  final Color? colorAccent;
  final Color? colorAccentLite;
  final Color? colorAccentLiteLite;
  final Function(BuildContext context)? onTapToolbarBack;
  final KayoOnNotifyPop? onNotifyPop;

  const KayoPackageConfig({
    this.nullText,
    this.loadingText,
    this.formatDefault,
    this.imageSourcePrefix,
    this.dataPickerLocale,
    this.locale,
    this.ignoreSSL,
    this.enableDark,
    this.reLoginCode,
    this.colorPrimary,
    this.colorPrimaryLight,
    this.colorPrimaryDark,
    this.colorAccent,
    this.colorAccentLite,
    this.colorAccentLiteLite,
    this.onTapToolbarBack,
    this.onNotifyPop,
  });
}
