import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';
import 'package:kayo_package/views/widget/alert/datetime_picker_new/flutter_cupertino_datetime_picker.dart';

///
///  kayo_package
///  kayo_pakcage_utils.dart
///
///  Created by kayoxu on 2021/5/25 at 4:40 下午
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

  static KayoPackage get share => KayoPackage._init();
  static KayoPackage? _singleton;

  String nullText = '无';

  init(
      {String? nullText,
      String? formatDefault,
      DateTimePickerLocale? dateTimePickerLocale,
      String? dataPickerLocale,
      Locale? locale}) {
    if (null != locale) {
      if (locale.languageCode == 'zh') {
        this.nullText = '无';
        BaseTimeUtils.formatDefault = 'yyyy-MM-dd HH:mm';
        DateTimePicker.defaultDateTimePickerLocale = DateTimePickerLocale.zh_cn;
        DataPicker.defaultDataPickerLocale = DataPickerLocale.zh_cn;
      } else {
        this.nullText = 'null';
        BaseTimeUtils.formatDefault = 'MM-dd-yyyy HH:mm';
        DateTimePicker.defaultDateTimePickerLocale = DateTimePickerLocale.en_us;
        DataPicker.defaultDataPickerLocale = DataPickerLocale.en_us;
      }
    }
    this.nullText = nullText ?? this.nullText;
    BaseTimeUtils.formatDefault = formatDefault ?? BaseTimeUtils.formatDefault;
    DateTimePicker.defaultDateTimePickerLocale =
        dateTimePickerLocale ?? DateTimePicker.defaultDateTimePickerLocale;
    DataPicker.defaultDataPickerLocale =
        dataPickerLocale ?? DataPicker.defaultDataPickerLocale;
  }

  setBuddhist(bool buddhist) {
    BaseTimeUtils.calendarType =
        buddhist == true ? CalendarType.Buddhist : CalendarType.normal;
  }
}
