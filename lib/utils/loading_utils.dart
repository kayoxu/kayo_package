import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kayo_package/kayo_package.dart';
import 'package:kayo_package/libs/fluttertoast/fluttertoast.dart';

///
///  kayo_package
///  loading_utils.dart
///
///  Created by kayoxu on 2021/8/4 at 10:58 上午
///  Copyright © 2021 kayoxu. All rights reserved.
///

class LoadingUtils {
  static LoadingUtils get share => LoadingUtils._share();

  static LoadingUtils? _instance;

  LoadingUtils._();

  factory LoadingUtils._share() {
    if (_instance == null) {
      _instance = LoadingUtils._();
    }
    return _instance!;
  }

  Timer? _timer;
  Color? toastBgColor;
  Color? toastTextColor;

  static TransitionBuilder? init(
      {TransitionBuilder? builder,
      Color? toastBgColor,
      Color? toastTextColor}) {
    share.toastBgColor = toastBgColor;
    share.toastTextColor = toastTextColor;

    return (BuildContext context, Widget? child) {
      // if (builder != null) {
      //   return builder(context, FlutterEasyLoading(child: child));
      // } else {
      //   return FlutterEasyLoading(child: child);
      // }
      return SizedBox();
    };
  }

  static show({String? data, bool dismissOnTap = false, int timeOut = 60}) {
    share._timer?.cancel();
    share._timer = Timer(Duration(seconds: timeOut), () {
      dismiss();
      share._timer = null;
    });

    // EasyLoading.show(
    //     status: data ?? KayoPackage.share.loadingText,
    //     dismissOnTap: dismissOnTap);
  }

  static showProgress({required double progress, String? data}) {
    if (progress > 1) {
      progress = progress / 100;
    }
    // EasyLoading.showProgress(progress, status: data ?? '');
  }

  static showSuccess({String? data, int? seconds = 2}) {
    // EasyLoading.showSuccess(data ?? '',
    //     duration: Duration(seconds: seconds ?? 2));
  }

  static showError({String? data, int? seconds = 2}) {
    // EasyLoading.showError(data ?? '',duration: Duration(seconds: seconds ?? 2));
  }

  static showInfo({String? data, int? seconds = 2}) {
    // EasyLoading.showInfo(data ?? '', duration: Duration(seconds: seconds ?? 2));
  }

  static showToast(
      {String? data,
      int timeInSecForIosWeb = 2,
      ToastGravity gravity = ToastGravity.BOTTOM}) {
    // EasyLoading.showToast(data ?? '');
    Fluttertoast.showToast(
      msg: data ?? '',
      gravity: gravity,
      backgroundColor: share.toastBgColor,
      textColor: share.toastTextColor,
      toastLength:
          timeInSecForIosWeb > 1 ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
      timeInSecForIosWeb: timeInSecForIosWeb,
    );
  }

  static dismiss() {
    // EasyLoading.dismiss();
  }
}
