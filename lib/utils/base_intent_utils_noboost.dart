import 'dart:core';
import 'dart:io';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kayo_package/kayo_package.dart';
import 'package:kayo_package/utils/page_route_builder.dart';

///  smart_community
///  common.common.utils
///
///  Created by kayoxu on 201 9/1/24.
///  Copyright © 2019 kayoxu. All rights reserved.

class BaseIntentUtilsNoBoost {
  static final EventBus eventBus = new EventBus();

  static fire(data) {
    eventBus.fire(data);
  }

  final String RESULT_OK = 'result_ok';

  isResultOk(var data) {
    if (data is Map && BaseSysUtils.equals(data['data'], RESULT_OK)) {
      return true;
    } else if (data is Map && BaseSysUtils.equals(data['result'], RESULT_OK)) {
      return true;
    } else if (data is String && BaseSysUtils.equals(data, RESULT_OK)) {
      return true;
    }
    return false;
  }

  popResultOk(BuildContext context, {bool finishAct = false}) {
    pop(context, data: {'data': RESULT_OK}, finishAct: finishAct);
  }

  pop(BuildContext context,
      {Map<String, dynamic>? data, bool finishAct = false}) {
    if (Navigator.canPop(context) && !finishAct) {
      return Navigator.of(context).pop(data);
    } else {
      return SystemNavigator.pop();
    }
  }

  /// 正常跳转
  Future? push(BuildContext? context,
      {String? routeName,
      bool finish = false,
      bool removeAll = false,
      Map<String, dynamic>? data}) {
    if (null != routeName && null != context) {
      return _pushByName(context, routeName,
          finish: finish, removeAll: removeAll, data: data);
    }
  }

  Future _pushByName(BuildContext context, String routeName,
      {bool finish = false,
      bool removeAll = false,
      bool full = false,
      Map<String, dynamic>? data}) {
    if (removeAll) {
      return Navigator.of(context).pushNamedAndRemoveUntil(
          routeName, (route) => removeAll != true,
          arguments: data);
    } else {
      if (finish) {
        return Navigator.of(context)
            .pushReplacementNamed(routeName, arguments: data);
      } else {
        return Navigator.of(context).pushNamed(routeName, arguments: data);
      }
    }
  }
}
