import 'dart:core';
import 'dart:io';

import 'package:event_bus/event_bus.dart';
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
  static final EventBus eventBus = EventBus();

  static void fire(dynamic data) {
    eventBus.fire(data);
  }

  static const String RESULT_OK = 'result_ok';

  bool isResultOk(dynamic data) {
    if (data is Map && BaseSysUtils.equals(data['data'], RESULT_OK)) {
      return true;
    }
    if (data is Map && BaseSysUtils.equals(data['result'], RESULT_OK)) {
      return true;
    }
    return false;
  }

  void finishResultOk(BuildContext context, {bool finishAct = false}) {
    pop(context, data: {'data': RESULT_OK}, finishAct: finishAct);
  }

  /// Pop the current route.
  void pop(BuildContext context,
      {Map<String, dynamic>? data, bool finishAct = false}) {
    if (Navigator.canPop(context) && !finishAct) {
      Navigator.of(context).pop(data);
    } else {
      SystemNavigator.pop();
    }
  }

  ///base
  @Deprecated('Use pop instead')
  void popOld(BuildContext context, {dynamic data, bool finishAct = false}) {
    if (Navigator.canPop(context) && !finishAct) {
      Navigator.of(context).pop(data);
    } else {
      SystemNavigator.pop();
    }
  }

  @Deprecated('Use pop instead')
  void finish(BuildContext context,
      {Map<String, dynamic>? data, bool finishAct = false}) {
    pop(context, data: data, finishAct: finishAct);
  }

  @Deprecated('Use pop instead')
  void finishOld(BuildContext context, {dynamic data, bool finishAct = false}) {
    popOld(context, data: data, finishAct: finishAct);
  }

  /// Push a named route.
  Future<dynamic>? push(BuildContext? context,
      {String? routeName,
      bool finish = false,
      // bool removeAll = false,
      bool withFlutterBoostContainer = false,
      Map<String, dynamic>? data}) {
    if (routeName != null && context != null) {
      return _pushByName(context, routeName,
          finish: finish, /* removeAll: removeAll,*/ data: data);
    }
    return null;
  }

  /// Push a widget or named route.
  @Deprecated('Avoid pushing widgets directly, use named routes')
  Future<dynamic>? pushWidget(BuildContext context,
      {String? routeName,
      Widget? widget,
      bool finish = false,
      bool removeAll = false,
      dynamic data}) {
    if (routeName != null) {
      return _pushByName(context, routeName,
          finish: finish,
          removeAll: removeAll,
          data: data is Map<String, dynamic> ? data : null);
    } else if (widget != null) {
      return _pushByWidget(context, widget,
          finish: finish, removeAll: removeAll);
    }
    return null;
  }

  Future<dynamic> _pushByName(BuildContext context, String routeName,
      {bool finish = false,
      bool removeAll = false,
      Map<String, dynamic>? data}) {
    if (removeAll) {
      return Navigator.of(context).pushNamedAndRemoveUntil(
          routeName, (route) => false,
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

  Future<dynamic> _pushByWidget(BuildContext context, Widget widget,
      {bool finish = false, bool removeAll = false}) {
    if (removeAll) {
      return Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
        return widget;
      }), (route) => false);
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
