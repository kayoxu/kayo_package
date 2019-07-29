import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
/**
 *  smart_community
 *  common.utils
 *
 *  Created by kayoxu on 2019/1/28.
 *  Copyright © 2019 kayoxu. All rights reserved.
 */

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
      } else {
        return true;
      }
    } else {
      return true;
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
  * 电话号码校验
  * */
  static bool isPhoneNo(String str) {
    if (BaseSysUtils.empty(str)) return false;

    return new RegExp(
            '^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\\d{8}\$')
        .hasMatch(str);
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
  * int 转 string
  * */
  static int str2Int(String value) {
    int v = -1;
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
}
