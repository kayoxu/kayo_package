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
  static Timer? _timer;

  static TransitionBuilder? init({TransitionBuilder? builder}) {
    return (BuildContext context, Widget? child) {
      if (builder != null) {
        return builder(context, FlutterEasyLoading(child: child));
      } else {
        return FlutterEasyLoading(child: child);
      }
    };
  }

  static show({String? data, bool dismissOnTap = false, int timeOut = 60}) {
    _timer?.cancel();
    _timer = Timer(Duration(seconds: timeOut), () {
      dismiss();
      _timer = null;
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

  static showToast({String? data}) {
    // EasyLoading.showToast(data ?? '');
    Fluttertoast.showToast(msg: data ?? '', timeInSecForIosWeb: 2);
  }

  static dismiss() {
    EasyLoading.dismiss();
  }
}
