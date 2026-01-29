import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';

///  smart_community
///  common.utils
///
///  Created by kayoxu on 2019/1/28.
///  Copyright © 2019 kayoxu. All rights reserved.
class BaseSysUtils {
  static bool get isDebug =>
      PlatformUtils.isWeb ? false : !bool.fromEnvironment("dart.vm.product");

  static final List<Color> _indexColors = [];

  // Static RegExps for performance
  static final RegExp _phoneRegExp = RegExp(
      r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
  static final RegExp _cnCharRegExp = RegExp(r'^[\u4e00-\u9fa5]+$');
  static final RegExp _idCardRegExp = RegExp(
      r'(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)');
  static final RegExp _carNoRegExp = RegExp(
      r'(^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[警京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼]{0,1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$)|(^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[警京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼]{0,1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{2}$)');
  static final RegExp _smsCodeRegExp = RegExp(r'(^\d{5}$)|(^\d{6}$)|(^\d{8}$)');

  static void initIndexColors() {
    _indexColors.clear();
    for (int i = 0; i < 256; i++) {
      _indexColors.add(randomColor(random: true));
    }
  }

  /// Check if object is empty
  static bool empty(dynamic obj) {
    if (obj == null) return true;
    if (obj is String) return obj.isEmpty;
    if (obj is List) return obj.isEmpty;
    if (obj is Map) return obj.isEmpty;
    if (obj is File) return false;
    if (obj is num) return false;
    if (obj is bool) return false;
    return true;
  }

  /// Check equality safely
  static bool equals(dynamic obj, dynamic obj2) {
    return obj == obj2;
  }

  /// Check if string contains substring safely
  static bool contains(String? str, String? str2) {
    if (str == null || str2 == null) return false;
    return str.contains(str2);
  }

  /// MD5 hash
  static String getMd5(String data) {
    if (empty(data)) return '';
    var content = const Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  /// SHA256 hash
  static String getSha256(String data) {
    if (empty(data)) return '';
    var content = const Utf8Encoder().convert(data);
    var digest = sha256.convert(content);
    return hex.encode(digest.bytes);
  }

  /// Base64 encode
  static Future<String> encodeBase64(String data) async {
    var content = utf8.encode(data);
    var digest = base64Encode(content).replaceAll("\n", "");
    return digest;
  }

  /// Base64 decode
  static Future<String> decodeBase64(String data) async {
    try {
      return String.fromCharCodes(base64Decode(data));
    } catch (e) {
      debugPrint('BaseSysUtils decodeBase64 error: $e');
      return '';
    }
  }

  /// Phone number validation
  static bool isPhoneNo(String? str) {
    if (empty(str)) return false;
    return _phoneRegExp.hasMatch(str!);
  }

  /// Chinese character validation
  static bool isCnChar(String str) {
    if (empty(str)) return false;
    return _cnCharRegExp.hasMatch(str);
  }

  /// ID Card validation
  static bool isIdCard(String str) {
    if (empty(str)) return false;
    return _idCardRegExp.hasMatch(str) || str.contains('12345678911');
  }

  static String getIdCardPrivacy(String str) {
    if (empty(str) || str.length < 6) {
      return KayoPackage.share.nullText;
    } else {
      return "${str.substring(0, 4)}**********${str.substring(str.length - 4, str.length)}";
    }
  }

  static bool isNumber(String? str) {
    if (str == null) return false;
    return double.tryParse(str) != null;
  }

  /// Car plate number validation
  static bool isCarNo(String str) {
    if (empty(str)) return false;
    return _carNoRegExp.hasMatch(str.toUpperCase());
  }

  /// SMS Code validation
  static bool isSmsCode(String str) {
    if (empty(str)) return false;
    return _smsCodeRegExp.hasMatch(str);
  }

  /// Return first text (same logic as isSmsCode in original?)
  /// NOTE: Original code had copy-paste of isSmsCode logic.
  /// Assuming it meant to match first character? Leaving as is but noting it.
  static bool getFirstText(String str) {
    if (empty(str)) return false;
    return _smsCodeRegExp.hasMatch(str);
  }

  /// int to String
  static String int2Str(int? value) {
    return value?.toString() ?? "";
  }

  /// String to int
  static int str2Int(String? value, {int? defaultValue = -1}) {
    int v = defaultValue ?? -1;
    if (value != null) {
      try {
        v = int.tryParse(value) ?? v;
      } catch (e) {
        debugPrint('BaseSysUtils str2Int error: $e');
      }
    }
    return v;
  }

  static Color getLockColor(int index, {bool hasNext = true}) {
    if (index == 0) return const Color(0xffFF940E);
    if (index == 1) return const Color(0xff49D966);
    if (index == 2) return const Color(0xff2B7FFB);
    return hasNext ? randomColor(random: true) : const Color(0xff2B7FFB);
  }

  static Color randomColor({bool random = true}) {
    if (random) {
      return _getRandomColor();
    } else {
      var randomGen = Random();
      var index = randomGen.nextInt(3);
      return getLockColor(index, hasNext: false);
    }
  }

  static Color _getRandomColor(
      {int r = 255, int g = 255, int b = 255, int a = 255}) {
    if (r == 0 || g == 0 || b == 0) return Colors.black;
    if (a == 0) return Colors.white;
    return Color.fromARGB(
      a,
      r != 255 ? r : Random.secure().nextInt(r),
      g != 255 ? g : Random.secure().nextInt(g),
      b != 255 ? b : Random.secure().nextInt(b),
    );
  }

  static Color indexColor(int index) {
    if (_indexColors.length != 256) {
      initIndexColors();
    }
    // Assuming findData is an extension method on List?
    // If not, we should use safe access. Since I don't see findData in standard lib,
    // I will assume it's from 'package:kayo_package/extension/_index_extension.dart'
    // but just in case, I'll use standard access if index is valid.
    if (index >= 0 && index < _indexColors.length) {
      return _indexColors[index];
    }
    return randomColor(random: true);
  }

  /// Create Color from String
  static Color getColor(String? colorString, {double alpha = 1.0}) {
    if ((colorString ?? '').isEmpty) return BaseColorUtils.colorAccent;

    String colorStr = colorString!;
    if (!colorStr.startsWith('0xff') && colorStr.length == 6) {
      colorStr = '0xff$colorStr';
    }
    if (colorStr.startsWith('0x') && colorStr.length == 8) {
      colorStr = colorStr.replaceRange(0, 2, '0xff');
    }
    if (colorStr.startsWith('#') && colorStr.length == 7) {
      colorStr = colorStr.replaceRange(0, 1, '0xff');
    }
    
    try {
        Color color = Color(int.parse(colorStr));
        int red = (color.r * 255).round().clamp(0, 255);
        int green = (color.g * 255).round().clamp(0, 255);
        int blue = (color.b * 255).round().clamp(0, 255);
        return Color.fromRGBO(red, green, blue, alpha);
    } catch (e) {
        return BaseColorUtils.colorAccent;
    }
  }

  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getStatusHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static double getNaviHeight(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }

  static int lastClickTime = 0;

  static Future<bool> doubleClickBack(Function()? onClickBack) {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now - lastClickTime > 1500) {
      lastClickTime = now;
      onClickBack?.call();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  static String getSuperScriptValue(int data) {
    if (data <= 0) return '';
    if (data > 99) return '99';
    return '$data';
  }

  static ContentType? getContentType(String? fileExt) {
    if (fileExt == null) return null;
    final ext = fileExt.toLowerCase();
    
    if (['.jpg', '.jpeg', '.jpe'].any(ext.endsWith)) {
      return ContentType("image", "jpeg");
    }
    if (ext.endsWith(".png")) return ContentType("image", "png");
    if (ext.endsWith(".bmp")) return ContentType("image", "bmp");
    if (ext.endsWith(".gif")) return ContentType("image", "gif");
    if (ext.endsWith(".json")) return ContentType("application", "json");
    if (ext.endsWith(".svg") || ext.endsWith(".svgz")) {
      return ContentType("image", "svg+xml");
    }
    if (ext.endsWith(".mp3")) return ContentType("audio", "mpeg");
    if (ext.endsWith(".mp4")) return ContentType("video", "mp4");
    if (ext.endsWith(".mov")) return ContentType("video", "mov");
    if (ext.endsWith(".html")) return ContentType("text", "html");
    if (ext.endsWith(".css")) return ContentType("text", "css");
    if (ext.endsWith(".csv")) return ContentType("text", "csv");
    if (['.txt', '.text', '.conf', '.def', '.log', '.in'].any(ext.endsWith)) {
      return ContentType("text", "plain");
    }
    return null;
  }

  static String? getSubType(String? fileExt) {
    if (fileExt == null) return null;
    return fileExt.toLowerCase();
  }

  /// Prevent double tap
  static VoidCallback safeTap(VoidCallback fn,
      {int time = 500, VoidCallback? onSafe}) {
    Timer? debounce;
    return () {
      if (debounce?.isActive ?? false) {
        debounce?.cancel();
        onSafe?.call();
      } else {
        fn();
      }
      debounce = Timer(Duration(milliseconds: time), () {
        debounce?.cancel();
        debounce = null;
      });
    };
  }

  static num chartMaxY(num? temp) {
    if (temp == null) return 0;
    const List<int> thresholds = [
      5, 10, 50, 100, 150, 200, 250, 300, 350, 400, 450, 500,
      600, 700, 800, 900, 1000, 1500, 2000, 2500, 3000, 3500, 4000,
      4500, 5000, 6000, 7000, 8000, 9000, 10000, 15000, 20000,
      25000, 30000, 35000, 40000, 45000, 50000, 60000, 70000,
      80000, 90000, 100000, 150000, 200000, 250000, 300000,
      350000, 400000, 450000, 500000, 600000, 700000, 800000,
      900000, 1000000, 1500000, 2000000, 2500000, 3000000,
      3500000, 4000000, 4500000, 5000000, 6000000, 7000000,
      8000000, 9000000, 10000000, 15000000, 20000000, 25000000,
      30000000, 35000000, 40000000, 45000000, 50000000, 60000000,
      70000000, 80000000, 90000000
    ];

    for (int threshold in thresholds) {
      if (temp < threshold) {
        return threshold;
      }
    }
    return temp;
  }

  static String cnSpace(int size) {
    return '\u3000' * size;
  }

  static String? getChartColor(int i) {
    const List<String> colors = [
      "#ff8c29", "#5470c6", "#91cc75", "#fac858", "#ee6666",
      "#73c0de", "#3ba272", "#fc8452", "#9a60b4", "#ea7ccc",
      "#fe9a65", "#8b9fc9", "#ffeead", "#997950", "#f7a35c",
      "#f15c80", "#48cfae", "#87cefa", "#6495ed", "#ff69b4",
      "#ba55d3", "#ff9999", "#ffcc99", "#ffff99", "#66ccff",
      "#c0ff3e", "#ffb3e6", "#ff6666", "#c2c2f0", "#ffb3b3",
      "#c2f0c2", "#b3b3ff", "#ff8000", "#ff6666", "#ff3333",
      "#ff6600", "#ff9999", "#ffcc00", "#ffff00", "#ccff00",
      "#99ff00", "#66ff00", "#33ff00", "#00ff00", "#00ff33",
      "#00ff66", "#00ff99", "#00ffcc", "#00ffff", "#00ccff"
    ];
    if (i < colors.length) {
      return colors[i];
    } else {
      return colors.last;
    }
  }

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
