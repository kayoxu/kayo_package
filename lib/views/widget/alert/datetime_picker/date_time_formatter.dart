import 'dart:math';

import 'package:kayo_package/utils/base_time_utils.dart';
import 'package:kayo_package/l10n/generated/kayo_package_localizations.dart';
import 'l10n_extension.dart';

import 'date_picker.dart';
import 'date_picker_constants.dart';

const String DATE_FORMAT_SEPARATOR = r'[|,-/\._: ]+';

class DateTimeFormatter {
  /// Get default value of date format.
  static String generateDateFormat(DateTimePickerMode pickerMode) {
    switch (pickerMode) {
      case DateTimePickerMode.date:
        return DATETIME_PICKER_DATE_FORMAT;
      case DateTimePickerMode.time:
        return DATETIME_PICKER_TIME_FORMAT;
      case DateTimePickerMode.datetime:
        return DATETIME_PICKER_DATETIME_FORMAT;
    }
  }

  /// Check if the date format is for day(contain y、M、d、E) or not.
  static bool isDayFormat(String format) {
    return format.contains(RegExp(r'[yMdE]'));
  }

  /// Check if the date format is for time(contain H、m、s) or not.
  static bool isTimeFormat(String format) {
    return format.contains(RegExp(r'[Hms]'));
  }

  /// Split date format to array.
  static List<String> splitDateFormat(String? dateFormat,
      {DateTimePickerMode? mode}) {
    if (dateFormat == null || dateFormat.isEmpty) {
      return [];
    }
    List<String> result = dateFormat.split(RegExp(DATE_FORMAT_SEPARATOR));
    if (mode == DateTimePickerMode.datetime) {
      // datetime mode need join day format
      List<String> temp = [];
      StringBuffer dayFormat = StringBuffer();
      for (int i = 0; i < result.length; i++) {
        String format = result[i];
        if (isDayFormat(format)) {
          // find format pre-separator
          int end = dateFormat.indexOf(format);
          if (end > 0) {
            int start = 0;
            if (i > 0) {
              start = dateFormat.indexOf(result[i - 1]) + result[i - 1].length;
            }
            dayFormat.write(dateFormat.substring(start, end));
          }
          dayFormat.write(format);
        } else if (isTimeFormat(format)) {
          temp.add(format);
        }
      }
      if (dayFormat.length > 0) {
        temp.insert(0, dayFormat.toString());
      } else {
        // add default date format
        temp.insert(0, DATETIME_PICKER_DATE_FORMAT);
      }
      result = temp;
    }
    return result;
  }

  /// Format datetime string
  static String formatDateTime(
      int value, String format, KayoPackageLocalizations localizations) {
    if (format.isEmpty) {
      return value.toString();
    }

    String result = format;
    // format year text
    if (format.contains('y')) {
      if (BaseTimeUtils.calendarType == CalendarType.Buddhist) {
        value = value + 543;
      }
      result = _formatYear(value, result, localizations);
    }
    // format month text
    if (format.contains('M')) {
      result = _formatMonth(value, result, localizations);
    }
    // format day text
    if (format.contains('d')) {
      result = _formatDay(value, result, localizations);
    }
    if (format.contains('E')) {
      result = _formatWeek(value, result, localizations);
    }
    // format hour text
    if (format.contains('H')) {
      result = _formatHour(value, result, localizations);
    }
    // format minute text
    if (format.contains('m')) {
      result = _formatMinute(value, result, localizations);
    }
    // format second text
    if (format.contains('s')) {
      result = _formatSecond(value, result, localizations);
    }
    if (result == format) {
      return value.toString();
    }
    return result;
  }

  /// Format day display
  static String formatDate(DateTime dateTime, String format,
      KayoPackageLocalizations localizations) {
    if (format.isEmpty) {
      return dateTime.toString();
    }

    String result = format;
    // format year text
    if (format.contains('y')) {
      int year = dateTime.year;
      if (BaseTimeUtils.calendarType == CalendarType.Buddhist) {
        year = dateTime.year + 543;
      }
      result = _formatYear(year, result, localizations);
    }
    // format month text
    if (format.contains('M')) {
      result = _formatMonth(dateTime.month, result, localizations);
    }
    // format day text
    if (format.contains('d')) {
      result = _formatDay(dateTime.day, result, localizations);
    }
    if (format.contains('E')) {
      result = _formatWeek(dateTime.weekday, result, localizations);
    }
    if (result == format) {
      return dateTime.toString();
    }
    return result;
  }

  /// format year text
  static String _formatYear(
      int value, String format, KayoPackageLocalizations localizations) {
    if (format.contains('yyyy')) {
      // yyyy: the digit count of year is 4, e.g. 2019
      return format.replaceAll('yyyy', value.toString());
    } else if (format.contains('yy')) {
      // yy: the digit count of year is 2, e.g. 19
      return format.replaceAll('yy',
          value.toString().substring(max(0, value.toString().length - 2)));
    }
    return value.toString();
  }

  /// format month text
  static String _formatMonth(
      int value, String format, KayoPackageLocalizations localizations) {
    List<String>? months;
    if (format.contains('MMMM')) {
      // MMMM: the full name of month, e.g. January
      months = localizations.months;
      return format.replaceAll('MMMM', months[value - 1]);
    } else if (format.contains('MMM')) {
      // MMM: the short name of month, e.g. Jan
      months = localizations.monthsShort;
      String month = months[value - 1];
      return format.replaceAll('MMM', month);
    }

    return _formatNumber(value, format, 'M');
  }

  /// format day text
  static String _formatDay(
      int value, String format, KayoPackageLocalizations localizations) {
    return _formatNumber(value, format, 'd');
  }

  /// format week text
  static String _formatWeek(
      int value, String format, KayoPackageLocalizations localizations) {
    if (format.contains('EEEE')) {
      // EEEE: the full name of week, e.g. Monday
      List<String>? weeks = localizations.weeks;
      return format.replaceAll('EEEE', weeks[value - 1]);
    }
    // EEE: the short name of week, e.g. Mon
    List<String>? weeks = localizations.weeksShort;
    return format.replaceAll(RegExp(r'E+'), weeks[value - 1]);
  }

  /// format hour text
  static String _formatHour(
      int value, String format, KayoPackageLocalizations localizations) {
    return _formatNumber(value, format, 'H');
  }

  /// format minute text
  static String _formatMinute(
      int value, String format, KayoPackageLocalizations localizations) {
    return _formatNumber(value, format, 'm');
  }

  /// format second text
  static String _formatSecond(
      int value, String format, KayoPackageLocalizations localizations) {
    return _formatNumber(value, format, 's');
  }

  /// format number, if the digit count is 2, will pad zero on the left
  static String _formatNumber(int value, String format, String unit) {
    if (format.contains('$unit$unit')) {
      return format.replaceAll('$unit$unit', value.toString().padLeft(2, '0'));
    } else if (format.contains('$unit')) {
      return format.replaceAll('$unit', value.toString());
    }
    return value.toString();
  }
}
