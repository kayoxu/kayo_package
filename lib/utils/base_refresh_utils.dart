import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kayo_package/views/widget/base/image_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'base_color_utils.dart';
import 'base_view_utils.dart';

///
///  kayo_package
///  base_refresh_utils.dart
///
///  Created by kayoxu on 2021/7/22 at 11:18 上午
///  Copyright © 2021 kayoxu. All rights reserved.
///
///

class BaseRefreshUtils {
  static init({required Widget? child,
    required bool showNoDataWidget,
    String noDataMsg = '没有数据',
    String noDataText = '没有更多数据了',
    Widget? noDataWidget,
    bool enableRefresh = true,
    bool enableLoad = true,
    required RefreshController controller,
    Function()? onRefresh,
    Function()? onLoad,
    Color bgColor = BaseColorUtils.white,
    bool lightText = false}) {
    return SmartRefresher(
      child: showNoDataWidget
          ? (null == noDataWidget
          ? BaseViewUtils.noData(msg: noDataMsg, width: 219, height: 120)
          : noDataWidget)
          : child ??
          BaseViewUtils.noData(msg: noDataMsg, width: 219, height: 120),
//      header: WaterDropMaterialHeader(),
      enablePullDown: enableRefresh,
      enablePullUp: enableLoad,
      controller: controller,
      onRefresh: onRefresh,
      onLoading: onLoad,
    );
  }

  static hideRefresh({required RefreshController? controller,
    required bool refresh,
    required int dataSize,
    required int pageSize}) {
    if (refresh) {
      controller?.refreshCompleted();
    } else {
      Fluttertoast.showToast(
          msg: dataSize < 1 ? '没有更多数据了' : '上拉加载了${dataSize}条数据');
    }
    if (dataSize < 1 || dataSize < pageSize) {
      if (refresh == false) {
        controller?.loadNoData();
      }
    } else {
      try {
        controller?.refreshToIdle();
        controller?.loadComplete();
      } catch (e) {
        print(e);
        controller?.refreshToIdle();
      }
    }
  }

  static hideRefreshSimple({
    required RefreshController controller,
  }) {
    controller.refreshCompleted();
    controller.loadComplete();
  }

  static firstLoading(
      {required RefreshController? controller, Function()? loadData}) {
    try {
      if (null != controller) {
        controller.requestRefresh();
      }
    } catch (e) {
      print(e);
      loadData?.call();
    }
  }
}
