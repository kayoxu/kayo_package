import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/**
 *  kayo_package
 *
 *
 *  Created by kayoxu on 2019-07-20 19:35.
 *  Copyright © 2019 kayoxu. All rights reserved.
 */
class BaseTimeUtils {
  static const formatDefault = 'yyyy-MM-dd HH:mm:ss';
  static const formatYMD = 'yyyy-MM-dd';
  static const formatMD = 'MM.dd';
  static const formatShort = 'yy-MM-dd HH:mm';

  ///获取时间
  static DateTime getTime({@required int after, @required bool start}) {
    DateTime dateTime = getToday(start: start);
    return dateTime.add(Duration(days: after));
  }

  /*
  * 获取现在
  * */
  static DateTime getNow() {
    return DateTime.now();
  }

  /*
  * 获取今天
  * */
  static DateTime getToday({bool start = true}) {
    return getDateTime(start: start);
  }

  /*
  * 获取周
  * */
  static DateTime getWeek({DateTime now, bool start = true}) {
    now = now ?? DateTime.now();
    var dateTime = DateTime(
        now.year,
        now.month,
        !start
            ? now.day + (DateTime.sunday - now.weekday)
            : now.day - (now.weekday - DateTime.monday));
    return getDateTime(start: start, dateTime: dateTime, plus: start ? 1 : 0);
  }

  /*
  * 获取月
  * */
  static DateTime getMonth({DateTime now, bool start = true}) {
    now = now ?? DateTime.now();

    var dateTime =
        DateTime(now.year, !start ? now.month + 1 : now.month, !start ? 0 : 1);

    return getDateTime(start: start, dateTime: dateTime, plus: start ? 2 : 0);
  }

  /*
  * 获取季度
  * */
  static DateTime getSeason(
      {DateTime now, bool start = true, bool lastSeason = false}) {
    now = now ?? DateTime.now();
    var season = _getSeason(now: now);

    var dateTime = now;
    if (lastSeason) {
      if (start) {
        int y = now.year;
        season--;
        if (season == 0) {
          season = 4;
          y--;
        }
        dateTime = DateTime(y, (season - 1) * 3, 1, 0, 0, 0);
      } else {
        int y = now.year;
        season--;
        if (season == 0) {
          season = 4;
          y--;
        }
        dateTime = DateTime(y, season * 3 - 1, 1, 23, 59, 59);
      }
    } else {
      if (start) {
        season--;
        dateTime = DateTime(now.year, season * 3, 1, 0, 0, 0);
      } else {
        dateTime = getToday(start: false);
      }
    }
    return getDateTime(start: start, dateTime: dateTime);
  }

  /*
  * 获取年 
  * 
  * */
  static DateTime getYear({DateTime now, bool start = true}) {
    now = now ?? DateTime.now();

    var dateTime = DateTime(now.year,
        !start ? DateTime.december + 1 : DateTime.january, !start ? 0 : 1);

    return getDateTime(start: start, dateTime: dateTime, plus: start ? 3 : 0);
  }

  /*
  * now的时间戳
  * */
  static String nowTimeStr({String format}) {
    return timestampToTimeStr(DateTime.now().millisecondsSinceEpoch,
        format: format);
  }

  /*
  * now的Timestamp
  * */
  static int nowTimestamp() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  /*
  * 格式化时间戳
  * 
  * */
  static String timeFormat(String time, {String format = formatDefault}) {
    if (null == time) return '无';
    var timestamp = timeStrToTimestamp(time);
    return timestampToTimeStr(timestamp, format: format);
  }

  /*
  * Timestamp转时间戳
  * 
  * */
  static String timestampToTimeStr(int timestamp, {String format}) {
    format = format ?? formatDefault;

    DateFormat dateFormat = getDateFormat(format);
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var time = '';
    try {
      time = dateFormat.format(date);
    } catch (e) {
      print(e);
    } finally {
      return time;
    }
  }

  /*
  * 时间戳转DateTime
  * 
  * */
  static DateTime timeStrToDateTime(String time,
      {String format = formatDefault}) {
    DateFormat dateFormat = getDateFormat(format);

    var dateTime = DateTime.now();
    try {
      dateTime = dateFormat.parse(time);
      return dateTime;
    } catch (e) {
      print(e);
    } finally {
//      print('flutter 🌶️，${dateTime.toString()}');
      return dateTime;
    }
  }

  /*
  * 时间戳转Timestamp
  * 
  * */
  static int timeStrToTimestamp(String string, {String format}) {
    format = format ?? formatDefault;

    DateFormat dateFormat = getDateFormat(format);
    var millisecondsSinceEpoch = 0;
    try {
      var dateTime = dateFormat.parse(string);
      millisecondsSinceEpoch = dateTime.millisecondsSinceEpoch;
    } catch (e) {
      print(e);
    } finally {
      return millisecondsSinceEpoch;
    }
  }

  /*
  * DateTime转时间戳
  * 
  * */
  static String dateToTimeStr(DateTime dateTime,
      {String format = formatDefault}) {
    if (null == dateTime) return '';

    var dateFormat = getDateFormat(format);
    return dateFormat.format(dateTime);
  }

  /*
  * 获取 DateFormat
  * */
  static DateFormat getDateFormat(String format) {
    var dateFormat = DateFormat(format);
    return dateFormat;
  }

  /*
  * 获取时间
  * start 是否是开始时间
  * 
  * */
  static DateTime getDateTime(
      {DateTime dateTime,
      bool start,
      int h = 0,
      int m = 0,
      int s = 0,
      int plus = 0}) {
    dateTime = dateTime ?? DateTime.now();

    if (null != start) {
      if (start) {
        h = 0;
        m = 0;
        s = 0 + plus;
      } else {
        h = 23;
        m = 59;
        s = 59 + plus;
      }
    }
    return DateTime(dateTime.year, dateTime.month, dateTime.day, h, m, s);
  }

  /*
  * 获取季度
  * */
  static int _getSeason({DateTime now}) {
    now = now ?? DateTime.now();
    int season = 0;
    int month = now.month;

    switch (month) {
      case DateTime.january:
      case DateTime.february:
      case DateTime.march:
        season = 1;
        break;
      case DateTime.april:
      case DateTime.may:
      case DateTime.june:
        season = 2;
        break;
      case DateTime.july:
      case DateTime.august:
      case DateTime.september:
        season = 3;
        break;
      case DateTime.october:
      case DateTime.november:
      case DateTime.december:
        season = 4;
        break;
      default:
        break;
    }
    return season;
  }
}
