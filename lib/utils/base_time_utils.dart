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

  static DateTime getDateTime(
      {DateTime dateTime, bool start, int h = 0, int m = 0, int s = 0}) {
    dateTime = dateTime ?? DateTime.now();

    if (null != start) {
      if (start) {
        h = 0;
        m = 0;
        s = 0;
      } else {
        h = 23;
        m = 59;
        s = 59;
      }
    }
    return DateTime(dateTime.year, dateTime.month, dateTime.day, h, m, s);
  }

  static DateTime getToday({bool start = true}) {
    return getDateTime(start: start);
  }

  static DateTime getWeek({DateTime now, bool start = true}) {
    now = now ?? DateTime.now();

    var dateTime =
    DateTime(now.year, now.month,
        !start ? now.day + (DateTime.sunday - now.weekday) : now.day -
            (now.weekday -
                DateTime.monday)
    );

    return getDateTime(start: start, dateTime: dateTime);
  }

  static DateTime getMonth({DateTime now, bool start = true}) {
    now = now ?? DateTime.now();

    var dateTime =
    DateTime(now.year, !start ? now.month + 1 : now.month, !start ? 0 : 1);

    return getDateTime(start: start, dateTime: dateTime);
  }

  static DateTime getYear({DateTime now, bool start = true}) {
    now = now ?? DateTime.now();

    var dateTime =
    DateTime(now.year, !start ? DateTime.december + 1 : DateTime.january,
        !start ? 0 : 1);

    return getDateTime(start: start, dateTime: dateTime);
  }


  static String nowTimeStr({String format}) {
    return timestampToTimeStr(DateTime
        .now()
        .millisecondsSinceEpoch,
        format: format);
  }

  static int nowTimestamp() {
    return DateTime
        .now()
        .millisecondsSinceEpoch;
  }

  static timeFormat(String time, {String format = formatDefault}) {
    if (null == time) return '无';

    var timestamp = timeStrToTimestamp(time);
    return timestampToTimeStr(timestamp, format: format);
  }

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

  static DateFormat getDateFormat(String format) {
    var dateFormat = DateFormat(format);
    return dateFormat;
  }

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

  static String dateToTimeStr(DateTime dateTime,
      {String format = formatDefault}) {
    if (null == dateTime) return '';

    var dateFormat = getDateFormat(format);
    return dateFormat.format(dateTime);
  }
}
