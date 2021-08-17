import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kayo_package/kayo_package.dart';

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
      if (builder != null) {
        return builder(context, FlutterEasyLoading(child: child));
      } else {
        return FlutterEasyLoading(child: child);
      }
    };
  }

  static show({String? data, bool dismissOnTap = false, int timeOut = 60}) {
    share._timer?.cancel();
    share._timer = Timer(Duration(seconds: timeOut), () {
      dismiss();
      share._timer = null;
    });

    EasyLoading.show(
        status: data ?? KayoPackage.share.loadingText,
        dismissOnTap: dismissOnTap);
  }

  static showProgress({required double progress, String? data}) {
    if (progress > 1) {
      progress = progress / 100;
    }
    EasyLoading.showProgress(progress, status: data ?? '');
  }

  static showSuccess({String? data}) {
    EasyLoading.showSuccess(data ?? '');
  }

  static showError({String? data}) {
    EasyLoading.showError(data ?? '');
  }

  static showInfo({String? data}) {
    EasyLoading.showInfo(data ?? '');
  }

  static showToast(
      {String? data,
      int timeInSecForIosWeb = 2,
      ToastGravity gravity = ToastGravity.BOTTOM}) {
    // EasyLoading.showToast(data ?? '');
    Fluttertoast.showToast(
      msg: data ?? '',
      backgroundColor: share.toastBgColor,
      textColor: share.toastTextColor,
      timeInSecForIosWeb: timeInSecForIosWeb,
    );
  }

  static dismiss() {
    EasyLoading.dismiss();
  }
}
