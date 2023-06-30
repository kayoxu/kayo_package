import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mpcore/mpcore.dart';
import 'package:kayo_package/kayo_package_utils.dart';

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
      return SizedBox();
    };
  }

  static show({String? data, bool dismissOnTap = false, int timeOut = 60}) {
    share._timer?.cancel();
    share._timer = Timer(Duration(seconds: timeOut), () {
      dismiss();
      share._timer = null;
    });

    MPWebDialogs.showLoading(title: data ?? KayoPackage.share.loadingText);
  }

  static showProgress({required double progress, String? data}) {
    if (progress > 1) {
      progress = progress / 100;
    }
    show(data: data ?? '');
    // EasyLoading.showProgress(progress, status: data ?? '');
  }

  static showSuccess({String? data, int seconds = 2}) {
    MPWebDialogs.hideToast();
    MPWebDialogs.showToast(
        title: data ?? '',
        duration: Duration(milliseconds: seconds * 1000),
        icon: ToastIcon.success);
  }

  static showError({String? data, int seconds = 2}) {
    // EasyLoading.showError(data ?? '',duration: Duration(seconds: seconds ?? 2));
    MPWebDialogs.hideToast();
    MPWebDialogs.showToast(
        title: data ?? '',
        duration: Duration(milliseconds: seconds * 1000),
        icon: ToastIcon.error);
  }

  static showInfo({String? data, int seconds = 2}) {
    // EasyLoading.showInfo(data ?? '', duration: Duration(seconds: seconds ?? 2));
    MPWebDialogs.hideToast();
    MPWebDialogs.showToast(
        title: data ?? '',
        duration: Duration(milliseconds: seconds * 1000),
        icon: ToastIcon.none);
  }

  static showToast({String? data, int timeInSecForIosWeb = 2}) {
    MPWebDialogs.hideToast();
    MPWebDialogs.showToast(
        title: data ?? '',
        duration: Duration(milliseconds: timeInSecForIosWeb * 1000),
        icon: ToastIcon.none);
  }

  static dismiss() {
    MPWebDialogs.hideLoading();
  }
}
