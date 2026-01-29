import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:kayo_package/http/base_code.dart';
import 'package:kayo_package/kayo_package_config.dart';
import 'package:kayo_package/l10n/generated/kayo_package_localizations.dart';
import 'package:kayo_package/utils/base_color_utils.dart';
import 'package:kayo_package/utils/base_time_utils.dart';
import 'package:kayo_package/views/widget/alert/flutter_cupertino_data_picker.dart';

///
///  kayo_package
///  kayo_package_utils.dart
///
///  Created by kayoxu on 2021/5/25
///  Copyright © 2021 kayoxu. All rights reserved.
///

class KayoPackage {
  factory KayoPackage._init() {
    if (_singleton == null) {
      _singleton = KayoPackage._();
    }
    return _singleton!;
  }

  KayoPackage._();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static KayoPackage get share => KayoPackage._init();
  static KayoPackage? _singleton;

  String nullText = 'null';
  String loadingText = 'Loading...';
  bool ignoreSSL = false;
  Locale? locale = const Locale('en');
  String? imageSourcePrefix = '';
  int reLoginCode = BaseCode.RESULT_ERROR_SIGN_ERROR_401;
  bool enableDark = false;
  void Function(BuildContext context)? onTapToolbarBack;
  KayoOnNotifyPop? onNotifyPop;

  bool isDark() {
    final context = navigatorKey.currentContext;
    if (context != null) {
      return Theme.of(context).brightness == Brightness.dark;
    }
    try {
      return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
    } catch (_) {
      return false;
    }
  }

  BuildContext? get maybeContext => navigatorKey.currentContext;

  ThemeData get theme => _resolveTheme(maybeContext);

  BuildContext get context {
    final context = maybeContext;
    if (context == null) {
      throw StateError(
          'KayoPackage navigatorKey has no context yet. Ensure it is attached to a MaterialApp.');
    }
    return context;
  }

  KayoPackageLocalizations localizations([BuildContext? context]) {
    final ctx = context ?? maybeContext;
    final l10n = ctx == null ? null : KayoPackageLocalizations.of(ctx);
    if (l10n != null) return l10n;
    final resolved = _resolveLocale(locale);
    return _localizationsFor(resolved);
  }

  void setLocale(Locale? locale) {
    final resolved = _resolveLocale(locale);
    this.locale = resolved;
    _applyLocale(resolved);
  }

  void configure(KayoPackageConfig config) {
    init(
      nullText: config.nullText,
      loadingText: config.loadingText,
      formatDefault: config.formatDefault,
      imageSourcePrefix: config.imageSourcePrefix,
      dataPickerLocale: config.dataPickerLocale,
      locale: config.locale,
      ignoreSSL: config.ignoreSSL,
      enableDark: config.enableDark,
      reLoginCode: config.reLoginCode,
      colorPrimary: config.colorPrimary,
      colorPrimaryLight: config.colorPrimaryLight,
      colorPrimaryDark: config.colorPrimaryDark,
      colorAccent: config.colorAccent,
      colorAccentLite: config.colorAccentLite,
      colorAccentLiteLite: config.colorAccentLiteLite,
      onTapToolbarBack: config.onTapToolbarBack,
      onNotifyPop: config.onNotifyPop,
    );
  }

  init({
    String? nullText,
    String? loadingText,
    String? formatDefault,
    String? imageSourcePrefix,
    String? dataPickerLocale,
    Locale? locale,
    bool? ignoreSSL,
    bool? enableDark,
    int? reLoginCode,
    Color? colorPrimary,
    Color? colorPrimaryLight,
    Color? colorPrimaryDark,
    Color? colorAccent,
    Color? colorAccentLite,
    Color? colorAccentLiteLite,
    void Function(BuildContext context)? onTapToolbarBack,
    KayoOnNotifyPop? onNotifyPop,
  }) {
    final resolvedLocale = _resolveLocale(locale);
    this.locale = resolvedLocale;

    _applyColors(
      colorPrimary: colorPrimary,
      colorPrimaryLight: colorPrimaryLight,
      colorPrimaryDark: colorPrimaryDark,
      colorAccent: colorAccent,
      colorAccentLite: colorAccentLite,
      colorAccentLiteLite: colorAccentLiteLite,
    );

    this.reLoginCode = reLoginCode ?? this.reLoginCode;
    this.enableDark = enableDark ?? this.enableDark;

    this.imageSourcePrefix = imageSourcePrefix ?? this.imageSourcePrefix ?? '';
    this.ignoreSSL = ignoreSSL ?? this.ignoreSSL;

    _applyLocale(resolvedLocale);

    this.nullText = nullText ?? this.nullText;
    this.loadingText = loadingText ?? this.loadingText;
    BaseTimeUtils.formatDefault = formatDefault ?? BaseTimeUtils.formatDefault;
    DataPicker.defaultDataPickerLocale =
        dataPickerLocale ?? DataPicker.defaultDataPickerLocale;

    this.onTapToolbarBack = onTapToolbarBack ?? this.onTapToolbarBack;
    this.onNotifyPop = onNotifyPop ?? this.onNotifyPop;
  }

  setBuddhist(bool buddhist) {
    BaseTimeUtils.calendarType =
        buddhist == true ? CalendarType.Buddhist : CalendarType.normal;
  }

  setDateFormat(String? format) {
    BaseTimeUtils.formatDefault = format ?? BaseTimeUtils.formatDefault;
  }

  initHive() async {
    await Hive.initFlutter();
    await Hive.openBox('chat');
  }

  ThemeData _resolveTheme(BuildContext? context) {
    return context == null ? ThemeData.fallback() : Theme.of(context);
  }

  Locale _resolveLocale(Locale? locale) {
    final candidate = locale ?? _deviceLocale();
    if (_isSupportedLocale(candidate)) {
      return candidate;
    }
    return const Locale('en');
  }

  Locale _deviceLocale() {
    try {
      return WidgetsBinding.instance.platformDispatcher.locale;
    } catch (_) {
      return const Locale('en');
    }
  }

  bool _isSupportedLocale(Locale locale) {
    try {
      lookupKayoPackageLocalizations(locale);
      return true;
    } catch (_) {
      return false;
    }
  }

  KayoPackageLocalizations _localizationsFor(Locale locale) {
    try {
      return lookupKayoPackageLocalizations(locale);
    } catch (_) {
      return lookupKayoPackageLocalizations(const Locale('en'));
    }
  }

  void _applyLocale(Locale locale) {
    final localizations = _localizationsFor(locale);
    nullText = localizations.nullText;
    loadingText = localizations.loadingText;
    BaseTimeUtils.formatDefault = localizations.dateFormat;
    DataPicker.defaultDataPickerLocale = locale.languageCode == 'zh'
        ? DataPickerLocale.zh_cn
        : DataPickerLocale.en_us;
  }

  void _applyColors({
    Color? colorPrimary,
    Color? colorPrimaryLight,
    Color? colorPrimaryDark,
    Color? colorAccent,
    Color? colorAccentLite,
    Color? colorAccentLiteLite,
  }) {
    final primary = colorPrimary ?? BaseColorUtils.colorPrimary;
    final accent = colorAccent ?? primary;

    BaseColorUtils.colorPrimary = primary;
    BaseColorUtils.colorPrimaryLight = colorPrimaryLight ?? primary;
    BaseColorUtils.colorPrimaryDark = colorPrimaryDark ?? primary;

    BaseColorUtils.colorAccent = accent;
    BaseColorUtils.colorAccentLite = colorAccentLite ?? accent;
    BaseColorUtils.colorAccentLiteLite = colorAccentLiteLite ?? accent;
    BaseColorUtils.colorPrimaryColor = BaseColorUtils.colorPrimary.toARGB32();
  }
}
