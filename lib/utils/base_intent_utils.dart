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

class BaseIntentUtils {
  static final EventBus eventBus = new EventBus();

  static fire(data) {
    eventBus.fire(data);
  }

  final String RESULT_OK = 'result_ok';

  isResultOk(var data) {
    if (data is Map && BaseSysUtils.equals(data['data'], RESULT_OK)) {
      return true;
    }
    if (data is Map && BaseSysUtils.equals(data['result'], RESULT_OK)) {
      return true;
    }
    return false;
  }

  finishResultOk(BuildContext context, {bool finishAct = false}) {
    finish(context, data: {'data': RESULT_OK}, finishAct: finishAct);
  }

  ///base
  pop(BuildContext context,
      {Map<String, dynamic>? data, bool finishAct = false}) {
    if (Navigator.canPop(context) && !finishAct) {
      return Navigator.of(context).pop(data);
    } else {
      return SystemNavigator.pop();
    }
  }

  ///base
  @Deprecated('用pop')
  popOld(BuildContext context, {dynamic data, bool finishAct = false}) {
    if (Navigator.canPop(context) && !finishAct) {
      return Navigator.of(context).pop(data);
    } else {
      return SystemNavigator.pop();
    }
  }

  @Deprecated('用pop')
  finish(BuildContext context,
      {Map<String, dynamic>? data, bool finishAct = false}) {
    return pop(context, data: data, finishAct: finishAct);
  }

  @Deprecated('用pop')
  finishOld(BuildContext context, {dynamic data, bool finishAct = false}) {
    return pop(context, data: data, finishAct: finishAct);
  }

  /// 正常跳转
  Future? push(BuildContext? context,
      {String? routeName,
      bool finish = false,
      // bool removeAll = false,
      bool withFlutterBoostContainer = false,
      Map<String, dynamic>? data}) {
    if (null != routeName && null != context) {
      return _pushByName(context, routeName,
          finish: finish, /* removeAll: removeAll,*/ data: data);
    }
  }

  /// 正常跳转
  @Deprecated('不要用直接push widget')
  Future? pushWidget(BuildContext context,
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

  Future _pushByName(BuildContext context, String routeName,
      {bool finish = false,
      bool removeAll = false,
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

  Future _pushByWidget(BuildContext context, Widget widget,
      {bool finish = false,
      bool removeAll = false,
      Map<String, dynamic>? data}) {
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
