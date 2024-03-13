import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';
import 'package:kayo_package/utils/base_time_utils.dart';
import 'package:kayo_package/views/widget/alert/datetime_picker_new/flutter_cupertino_datetime_picker.dart';
import 'package:kayo_package/views/widget/base/button_view.dart';
import 'package:kayo_package/views/widget/base/text_view.dart';

import 'date_format.dart';
import 'date_model.dart';
import 'datetime_picker_theme.dart';

import 'datetime_picker_theme.dart' as dpt;
import 'i18n_model.dart';

typedef DateChangedCallback(DateTime time, {DateTime? time2});
typedef ErrorCallback(String error);
typedef String? StringAtIndexCallBack(int index);

//String formatType;

@Deprecated('使用DateTimePicker.show'
    ' DateTimePicker.show('
    'context, dateFormat: \'yyyy-MM-dd HH:mm:ss\','
    'onDateTimePick: (startDate, endDate) {})')
class DatePicker {
  ///
  /// Display date picker bottom sheet.
  ///
  ///

  @Deprecated('使用DateTimePicker.show'
      ' DateTimePicker.show('
      'context, dateFormat: \'yyyy-MM-dd HH:mm:ss\','
      'onDateTimePick: (startDate, endDate) {})')
  static Future showDatePicker(BuildContext context,
      {bool showTitleActions = true,
      DateTime? minTime,
      DateTime? maxTime,
      DateTime? minTime2,
      DateTime? maxTime2,
      DateChangedCallback? onChanged,
      DateChangedCallback? onChanged2,
      DateChangedCallback? onConfirm,
      Function()? onCancel,
      ErrorCallback? onError,
      locale = LocaleType.zh,
      DateTime? currentTime,
      DateTime? currentTime2,
      dpt.DatePickerTheme? theme,
      String formatType = ymdw,
      bool onlyStart = false,
      bool showWeek = false}) {
    if (true) {
      _showNewTimePicker(
          formatType,
          context,
          minTime,
          maxTime,
          currentTime,
          minTime2,
          maxTime2,
          currentTime2,
          onConfirm,
          onChanged,
          onChanged2,
          onCancel,
          onlyStart,
          locale,
          null,
          null);

      return Future.value(1);
    }

    // return Navigator.push(
    //         context,
    //         new _DatePickerRoute(
    //           showTitleActions: showTitleActions,
    //           onChanged: onChanged,
    //           onChanged2: onChanged2,
    //           onConfirm: onConfirm,
    //           onCancel: onCancel,
    //           locale: locale,
    //           onError: onError,
    //           formatType: formatType,
    //           onlyStart: onlyStart,
    //           showWeek: showWeek,
    //           theme: theme,
    //           barrierLabel:
    //               MaterialLocalizations.of(context).modalBarrierDismissLabel,
    //           pickerModel: DatePickerModel(
    //               currentTime: currentTime,
    //               maxTime: maxTime,
    //               minTime: minTime,
    //               formatType: formatType,
    //               locale: locale),
    //           pickerModel2: DatePickerModel(
    //               currentTime: currentTime2,
    //               maxTime: maxTime2,
    //               minTime: minTime2,
    //               formatType: formatType,
    //               locale: locale),
    //         ))
//        .then((data) {if (null != onCancel) onCancel();})
  }

  static void _showNewTimePicker(
      String? formatType,
      BuildContext context,
      DateTime? minTime,
      DateTime? maxTime,
      DateTime? currentTime,
      DateTime? minTime2,
      DateTime? maxTime2,
      DateTime? currentTime2,
      DateChangedCallback? onConfirm,
      DateChangedCallback? onChanged,
      DateChangedCallback? onChanged2,
      Function()? onCancel,
      bool? onlyStart,
      LocaleType? localeType,
      String? startTitle,
      String? endTitle) {
    String format = formatType ?? 'ymdw';

    // dateFormat = 'yyyy年-MM月-dd日 HH时:mm分:ss秒',

    var isCn = (localeType ?? LocaleType.zh) == LocaleType.zh;

    var f = '';

    if (format.contains('y')) {
      f += (isCn ? 'yyyy年' : 'yyyy');
    }
    if (format.contains('y') && format.contains('m')) {
      f += '-';
    }
    if ((format.contains('y') && format.contains('m')) ||
        (format.contains('m') && format.contains('d'))) {
      f += (isCn ? 'MM月' : 'MM');
    }
    if (format.contains('m') && format.contains('d')) {
      f += '-';
    }
    if (format.contains('d')) {
      f += (isCn ? 'dd日' : 'dd');
    }
    if (format.contains('d') && format.contains('h')) {
      f += ' ';
    }
    if (format.contains('h')) {
      f += (isCn ? 'HH时' : 'HH');
    }
    if (format.contains('h') && format.contains('m')) {
      f += ':';
    }
    if ((format.contains('h') && format.contains('m')) ||
        (format.contains('m') && format.contains('s'))) {
      f += (isCn ? 'mm分' : 'mm');
    }
    // if (format.contains('m') && format.contains('s')) {
    //   f += ':';
    // }
    // if (format.contains('s')) {
    //   f += (isCn ? 'ss秒' : 'ss');
    // }

    DateTimePicker.show(context,
        minStartDate: minTime,
        maxStartDate: maxTime,
        nowStartDate: currentTime,
        minEndDate: minTime2,
        maxEndDate: maxTime2,
        locale: isCn ? DateTimePickerLocale.zh_cn : DateTimePickerLocale.en_us,
        dateFormat: f,
        nowEndDate: currentTime2, onDateTimePick: (s, e) {
      onConfirm?.call(s, time2: e);
    }, onDateTimeChange: (s, e) {
      onChanged?.call(s, time2: e);
      onChanged2?.call(s, time2: e);
    }, onCancel: onCancel, showEnd: onlyStart != true);
  }

  ///
  /// Display time picker bottom sheet.
  ///
  ///
  @Deprecated('使用DateTimePicker.show'
      ' DateTimePicker.show('
      'context, dateFormat: \'yyyy-MM-dd HH:mm:ss\','
      'onDateTimePick: (startDate, endDate) {})')
  static Future showTimePicker(
    BuildContext context, {
    bool showTitleActions = true,
    DateChangedCallback? onChanged,
    DateChangedCallback? onChanged2,
    DateChangedCallback? onConfirm,
    locale = LocaleType.zh,
    DateTime? currentTime,
    ErrorCallback? onError,
    DateTime? currentTime2,
    dpt.DatePickerTheme? theme,
    String formatType = hms,
    bool onlyStart = false,
    bool showWeek = false,
    String? title,
    String? startTitle,
    String? endTitle,
  }) {
    if (true) {
      _showNewTimePicker(
          formatType,
          context,
          null,
          null,
          currentTime,
          null,
          null,
          currentTime2,
          onConfirm,
          onChanged,
          onChanged2,
          null,
          onlyStart,
          locale,
          startTitle,
          endTitle);

      return Future.value(1);
    }
  }

  ///
  /// Display date&time picker bottom sheet.

  @Deprecated('使用DateTimePicker.show'
      ' DateTimePicker.show('
      'context, dateFormat: \'yyyy-MM-dd HH:mm:ss\','
      'onDateTimePick: (startDate, endDate) {})')
  static Future showDateTimePicker(
    BuildContext context, {
    bool showTitleActions = true,
    DateChangedCallback? onChanged,
    DateChangedCallback? onChanged2,
    DateChangedCallback? onConfirm,
    ErrorCallback? onError,
    String formatType = ymdhmsw,
    DateTime? minTime,
    DateTime? maxTime,
    DateTime? minTime2,
    DateTime? maxTime2,
    locale = LocaleType.zh,
    DateTime? currentTime,
    DateTime? currentTime2,
    dpt.DatePickerTheme? theme,
    bool onlyStart = false,
    bool showWeek = false,
    String? title,
    String? startTitle,
    String? endTitle,
  }) {
    if (true) {
      _showNewTimePicker(
          formatType,
          context,
          minTime,
          maxTime,
          currentTime,
          minTime2,
          maxTime2,
          currentTime2,
          onConfirm,
          onChanged,
          onChanged2,
          null,
          onlyStart,
          locale,
          startTitle,
          endTitle);

      return Future.value(1);
    }
  }
}
