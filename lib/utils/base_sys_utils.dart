import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kayo_package/kayo_package.dart';

///  smart_community
///  common.utils
///
///  Created by kayoxu on 2019/1/28.
///  Copyright © 2019 kayoxu. All rights reserved.

class BaseSysUtils {
  /*
  * 判断是否为空
  * */
  static bool empty(obj) {
    if (null != obj) {
      if ((obj is String && 0 != obj.length)) {
        return false;
      } else if (obj is List && 0 != obj.length) {
        return false;
      } else if (obj is File) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  /*
  * 判断是否为空
  * */
  static bool equals(obj, obj2) {
    if (null == obj || null == obj2) {
      return false;
    } else {
      return obj == obj2;
    }
  }

  /*
  * 包含
  * */
  static bool contains(String str, String str2) {
    if (null == str || null == str2) {
      return false;
    } else {
      return str.contains(str2);
    }
  }

  /*
   *  md5 加密
   * */
  static String getMd5(String data) {
    if (BaseSysUtils.empty(data)) return '';
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return hex.encode(digest.bytes);
  }

  /*
   *  sha256 加密
   * */
  static String getSha256(String data) {
    if (BaseSysUtils.empty(data)) return '';
    var content = new Utf8Encoder().convert(data);
    var digest = sha256.convert(content);
    // 这里其实就是 digest.toString()
    return hex.encode(digest.bytes);
  }

  /*
  * Base64加密
  */
  static Future<String> encodeBase64(String data) async {
    var content = utf8.encode(data);
    var digest = base64Encode(content).replaceAll("\n", "");
    return digest;
  }

  /*
  * Base64解密
  */
  static Future<String> decodeBase64(String data) async {
    String d = '';
    try {
      d = String.fromCharCodes(base64Decode(data));
    } catch (e) {
      print(e);
    } finally {
      return d ?? data;
    }
  }

  /*
  * 电话号码校验
  * */
  static bool isPhoneNo(String str) {
    if (BaseSysUtils.empty(str)) return false;

    return new RegExp(
            '^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\\d{8}\$')
        .hasMatch(str);
  }

  ///是否是中文
  static bool isCnChar(String str) {
    if (BaseSysUtils.empty(str)) return false;

    return new RegExp('^[\u4e00-\u9fa5]+\$').hasMatch(str);
  }

  /*
  * 身份证校验
  * */
  static bool isIdCard(String str) {
    if (BaseSysUtils.empty(str)) return false;

//    return new RegExp('(^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]\$)|(^[1-9]\\d{5}\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{2}\$)').hasMatch(str);
    return new RegExp('(^\\d{15}\$)|(^\\d{18}\$)|(^\\d{17}(\\d|X|x)\$)')
            .hasMatch(str) ||
        str.contains('12345678911');
  }

  static String getIdCardPrivacy(String str) {
    if (BaseSysUtils.empty(str) || str.length < 6) {
      return '无';
    } else {
      return str.substring(0, 4) +
          "**********" +
          str.substring(str.length - 4, str.length);
    }
  }

  static bool isNumber(String str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;

//    return new RegExp('(^[0-9])').hasMatch(str);
  }

  /*
  * 车牌验证
  * */
  static bool isCarNo(String str) {
    if (BaseSysUtils.empty(str)) return false;

    return new RegExp(
            '(^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[警京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼]{0,1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}\$)|(^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[警京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼]{0,1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{2}\$)')
        .hasMatch(str.toUpperCase());
  }

  /*
  * 验证码校验
  * */
  static bool isSmsCode(String str) {
    if (BaseSysUtils.empty(str)) return false;

    return new RegExp('(^\\d{5}\$)|(^\\d{6}\$)|(^\\d{8}\$)').hasMatch(str);
  }

  /*
  * 返回第一个汉字或者数字字母
  * */
  static bool getFirstText(String str) {
    if (BaseSysUtils.empty(str)) return false;

    return new RegExp('(^\\d{5}\$)|(^\\d{6}\$)|(^\\d{8}\$)').hasMatch(str);
  }

  /*
  * int 转 string
  * */
  static String int2Str(int value) {
    if (null != value) {
      return value.toString();
    } else {
      return "";
    }
  }

  /*
  * string 转 int
  * */
  static int str2Int(String value, {int defaultValue = -1}) {
    int v = defaultValue;
    if (null != value) {
      try {
        v = int.parse(value);
      } catch (e) {
        print(e);
      } finally {
        return v;
      }
    }
    return v;
  }

  static Color getLockColor(int index, {bool hasNext = true}) {
    Color color;
    if (0 == index) {
      color = Color(0xffFF940E);
    } else if (1 == index) {
      color = Color(0xff49D966);
    } else if (2 == index) {
      color = Color(0xff2B7FFB);
    } else {
      color = hasNext ? randomColor() : Color(0xff2B7FFB);
    }
    return color;
  }

  static Color randomColor() {
    var random = Random();
    var index = random.nextInt(3);
    return getLockColor(index, hasNext: false);
  }

  /// 颜色创建方法
  ///
  /// - [colorString] 颜色值
  /// - [alpha] 透明度(默认1，0-1)
  /// 可以输入多种格式的颜色代码，如: 0x000000,0xff000000,#000000
  static Color getColor(String colorString, {double alpha = 1.0}) {
    if ((colorString ?? '').isEmpty) return BaseColorUtils.colorAccent;

    String colorStr = colorString;
    // colorString未带0xff前缀并且长度为6
    if (!colorStr.startsWith('0xff') && colorStr.length == 6) {
      colorStr = '0xff' + colorStr;
    }
    // colorString为8位，如0x000000
    if (colorStr.startsWith('0x') && colorStr.length == 8) {
      colorStr = colorStr.replaceRange(0, 2, '0xff');
    }
    // colorString为7位，如#000000
    if (colorStr.startsWith('#') && colorStr.length == 7) {
      colorStr = colorStr.replaceRange(0, 1, '0xff');
    }
    // 先分别获取色值的RGB通道
    Color color = Color(int.parse(colorStr));
    int red = color.red;
    int green = color.green;
    int blue = color.blue;
    // 通过fromRGBO返回带透明度和RGB值的颜色
    return Color.fromRGBO(red, green, blue, alpha);
  }

  static double getWidth(context) {
    return MediaQuery.of(context).size.width;
  }

  static double getHeight(context) {
    return MediaQuery.of(context).size.height;
  }

  static double getStatusHeight(context) {
    return MediaQueryData.fromWindow(window).padding.top;
  }

  static double getNaviHeight(context) {
    return MediaQueryData.fromWindow(window).padding.bottom;
  }

  static int last = 0;

  static Future<bool> doubleClickBack(Function onClickBack) {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now - last > 1500) {
      last = DateTime.now().millisecondsSinceEpoch;
      if (null != onClickBack) onClickBack();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  static String getSuperScriptValue(int data) {
    if (data <= 0) {
      return '';
    } else if (data > 99) {
      return '99';
    } else {
      return '${data}';
    }
  }

//  static SystemNavigatorPop() async {
//    return await SystemNavigator.pop();
//  }
}
