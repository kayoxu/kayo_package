import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kayo_package/kayo_package.dart';
import 'package:kayo_package/l10n/generated/kayo_package_localizations_en.dart';

///
///  flutter_cupertino_datetime_picker
///  date_time_picker.dart
///
///  Created by kayoxu on 3/31/21 at 2:46 PM
///  Copyright © 2021 kayoxu. All rights reserved.
///

typedef OnDateTimePick(DateTime startDateTime, DateTime endDateTime);

///
///
/// DateTimePicker.show(context, dateFormat: 'yyyy-MM-dd HH:mm:ss',
/// onDateTimePick: (startDate, endDate) {
/// print('DateTimePicker $startDate $endDate');
/// });
///
///

class DateTimePicker {
  static show(BuildContext? context,
      {bool? showEnd,
      Locale? locale,
      // bool? showWeek,
      String? title,
      DateTime? maxStartDate,
      DateTime? minStartDate,
      DateTime? nowStartDate,
      DateTime? maxEndDate,
      DateTime? minEndDate,
      DateTime? nowEndDate,
      String? dateFormat,
      // String? dateFormat = 'yyyy年-MM月-dd日 HH时:mm分:ss秒',
      OnDateTimePick? onDateTimePick,
      OnDateTimePick? onDateTimeChange,
      Function()? onCancel,
      String? startTitle,
      String? endTitle}) {
    final resolvedContext = context ?? KayoPackage.share.maybeContext;
    if (resolvedContext == null) {
      debugPrint('DateTimePicker.show called without a valid context.');
      return;
    }
    dateFormat =
        (dateFormat ?? BaseTimeUtils.formatDefault).replaceAll('hh', 'HH');

    double heightTitle = 46;
    double heightTitleTime = 46;
    // double heightTitleWeek = 46;
    double heightTime = 110;
    double wHeight = BaseSysUtils.getHeight(resolvedContext) / 2 - 1;
    var height = heightTitle +
        (heightTitleTime * ((showEnd ?? true) ? 1 : 0) + heightTime) *
            ((showEnd ?? true) ? 2 : 1);

    if (height >= wHeight) {
      var d = height - wHeight;
      heightTime = heightTime - (d / ((showEnd ?? true) ? 2 : 1));
      height = heightTitle +
          (heightTitleTime * ((showEnd ?? true) ? 1 : 0) + heightTime) *
              ((showEnd ?? true) ? 2 : 1);
    }

    nowStartDate = nowStartDate ?? DateTime.now();
    nowEndDate = nowEndDate ?? DateTime.now();
    nowStartDate = DateTime(nowStartDate.year, nowStartDate.month,
        nowStartDate.day, nowStartDate.hour, nowStartDate.minute, 0);
    nowEndDate = DateTime(nowEndDate.year, nowEndDate.month, nowEndDate.day,
        nowEndDate.hour, nowEndDate.minute, 59);

    showModalBottomSheet(
      context: resolvedContext,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        Widget content = Builder(builder: (context) {
          var localizations = KayoPackageLocalizations.of(context) ??
              KayoPackageLocalizationsEn();

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              color: BaseColorUtils.darkWhite(context: context),
            ),
            child: SafeArea(
                child: Container(
              height: height,
              // height: w.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _inkWell(
                          height: heightTitle,
                          color: BaseColorUtils.darkBlackLiteLite(
                              context: context),
                          title: localizations.cancel,
                          onTap: () {
                            Navigator.pop(context);
                            onCancel?.call();
                          }),
                      Container(
                        height: heightTitle,
                        alignment: Alignment.center,
                        child: Text(
                          title ??
                              ((showEnd ?? true)
                                  ? localizations.selectTimeRangeText
                                  : localizations.selectTimeText),
                          style: TextStyle(
                              color: BaseColorUtils.darkBlack(context: context),
                              fontSize: 17,
                              // height: heightTitle,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      _inkWell(
                          height: heightTitle,
                          title: localizations.done,
                          onTap: () {
                            var startDateTime =
                                (nowStartDate ?? DateTime.now());
                            var endDateTime = nowEndDate ?? DateTime.now();

                            if (nowStartDate?.isAfter(endDateTime) == true &&
                                showEnd == true) {
                              // FlutterToast
                              Fluttertoast.showToast(
                                  msg: localizations
                                      .endTimeGreaterStartTimeText);
                              return;
                            }

                            Navigator.pop(context);

                            startDateTime = DateTime(
                                startDateTime.year,
                                startDateTime.month,
                                startDateTime.day,
                                startDateTime.hour,
                                startDateTime.minute,
                                0);

                            // 根据dateFormat判断需要设置的时间单位
                            int hour = endDateTime.hour;
                            int minute = endDateTime.minute;
                            int second = 59;

                            // 如果dateFormat不包含小时格式，则设为23
                            if (!dateFormat!.contains('H') &&
                                !dateFormat.contains('h')) {
                              hour = 23;
                            }

                            // 如果dateFormat不包含分钟格式，则设为59
                            if (!dateFormat.contains('m')) {
                              minute = 59;
                            }

                            endDateTime = DateTime(
                                endDateTime.year,
                                endDateTime.month,
                                endDateTime.day,
                                hour,
                                minute,
                                second);
                            onDateTimePick?.call(startDateTime, endDateTime);
                          }),
                    ],
                  ),
                  showEnd != true
                      ? SizedBox(
                          height: 0,
                          width: 0,
                        )
                      : _titleTime(heightTitleTime,
                          startTitle ?? localizations.startTimeText, context),
                  Container(
                    height: heightTime,
                    child: DateTimePickerWidget(
                      minDateTime: minStartDate ?? DateTime(1970),
                      maxDateTime:
                          maxStartDate ?? DateTime(2049, 12, 31, 23, 59, 59),
                      initDateTime: nowStartDate,
                      dateFormat: dateFormat!,
                      pickerTheme: DateTimePickerTheme(
                          showTitle: false,
                          backgroundColor: BaseColorUtils.transparent,
                          itemTextStyle: TextStyle(
                              color: BaseColorUtils.darkBlack(context: context),
                              fontSize: 16.0)),
                      onChange: (dateTime, selectedIndex) {
                        nowStartDate = dateTime;
                        onDateTimeChange?.call(nowStartDate!, nowEndDate!);
                      },
                    ),
                  ),
                  showEnd != true
                      ? SizedBox(
                          height: 0,
                          width: 0,
                        )
                      : _titleTime(heightTitleTime,
                          endTitle ?? localizations.endTimeText, context),
                  showEnd != true
                      ? SizedBox(
                          height: 0,
                          width: 0,
                        )
                      : Container(
                          height: heightTime,
                          child: DateTimePickerWidget(
                            minDateTime: minEndDate ?? DateTime(1970),
                            maxDateTime: maxEndDate ??
                                DateTime(2049, 12, 31, 23, 59, 59),
                            initDateTime: nowEndDate,
                            dateFormat: dateFormat,
                            pickerTheme: DateTimePickerTheme(
                                showTitle: false,
                                backgroundColor: BaseColorUtils.transparent,
                                itemTextStyle: TextStyle(
                                    color: BaseColorUtils.darkBlack(
                                        context: context),
                                    fontSize: 16.0)),
                            onChange: (dateTime, selectedIndex) {
                              nowEndDate = dateTime;
                              onDateTimeChange?.call(
                                  nowStartDate!, nowEndDate!);
                            },
                          ),
                        ),
                ],
              ),
            )),
          );
        });

        if (locale != null) {
          return Localizations.override(
            context: context,
            locale: locale,
            child: content,
          );
        }
        return content;
      },
    );
  }

  static Container _titleTime(
      double heightTitleTime, String? title, BuildContext context) {
    return Container(
      height: heightTitleTime,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20),
      // width: 120,
      child: Text(
        title ?? '',
        style: TextStyle(
            color: BaseColorUtils.darkBlackLite(context: context),
            fontSize: 14,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  static InkWell _inkWell(
      {double? height, String? title, Function()? onTap, Color? color}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 40,
        alignment: Alignment.center,
        width: 75,
        child: Text(
          title ?? '',
          style: TextStyle(
              color: color ?? BaseColorUtils.colorAccent,
              fontSize: 15,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
