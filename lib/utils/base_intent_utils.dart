import 'dart:core';
import 'dart:io';

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

class BaseIntentUtils {
  static const String RESULT_OK = 'result_ok';

  static isResultOk(var data) {
    if (data is String && BaseSysUtils.equals(data, RESULT_OK)) {
      return true;
    }
    return false;
  }

  static finishResultOk(BuildContext context, {bool finishAct = false}) {
    finish(context, data: RESULT_OK, finishAct: finishAct);
  }

  ///base
  static finish(BuildContext context, {Object? data, bool finishAct = false}) {
    if (Navigator.canPop(context) && !finishAct) {
      return Navigator.of(context).pop(data);
    } else {
      return SystemNavigator.pop();
    }
  }

  /// 正常跳转
  static Future? push(BuildContext context,
      {String? routeName,
      Widget? widget,
      bool finish = false,
      bool removeAll = false,
      dynamic data}) {
    if (null != routeName) {
      return _pushByName(context, routeName,
          finish: finish, removeAll: removeAll);
    } else if (null != widget) {
      return _pushByWidget(context, widget,
          finish: finish, removeAll: removeAll);
    }
  }

  static Future _pushByName(BuildContext context, String routeName,
      {bool finish = false, bool removeAll = false}) {
    if (removeAll) {
      return Navigator.of(context)
          .pushNamedAndRemoveUntil(routeName, (route) => removeAll != true);
    } else {
      if (finish) {
        return Navigator.of(context).pushReplacementNamed(routeName);
      } else {
        return Navigator.of(context).pushNamed(routeName);
      }
    }
  }

  static Future _pushByWidget(BuildContext context, Widget widget,
      {bool finish = false, bool removeAll = false}) {
    if (removeAll) {
      return Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
        return widget;
      }), (route) => removeAll != true /*route == null*/);
    } else {
      if (finish) {
        return Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return widget;
        }));
      } else {
        if (!PlatformUtils.isWeb && Platform.isIOS) {
          return Navigator.of(context, rootNavigator: true)
              .push(MaterialPageRoute(builder: (context) {
            return widget;
          }));
        } else {
          return Navigator.of(context, rootNavigator: true)
              .push(IPageRouteBuilder(widget));
        }
      }
    }
  }
}
