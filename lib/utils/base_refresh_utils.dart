import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package_utils.dart';

import 'package:kayo_package/libs/pull_to_refresh/src/indicator/custom_indicator.dart';
import 'package:kayo_package/libs/pull_to_refresh/src/internals/refresh_localizations.dart';
import 'package:kayo_package/libs/pull_to_refresh/src/smart_refresher.dart';
import 'package:kayo_package/utils/base_color_utils.dart';
import 'package:kayo_package/utils/base_view_utils.dart';
import 'package:kayo_package/utils/loading_utils.dart';
import 'package:mpcore/mpkit/mpkit.dart';

///
///  kayo_package
///  base_refresh_utils.dart
///
///  Created by kayoxu on 2021/7/22 at 11:18 上午
///  Copyright © 2021 kayoxu. All rights reserved.
///
///

class BaseRefreshUtils {
  static init(
      {required Widget? child,
      required bool showNoDataWidget,
      String? noDataMsg,
      String? noDataText,
      Widget? noDataWidget,
      bool enableRefresh = true,
      bool enableLoad = true,
      required RefreshController controller,
      Function()? onRefresh,
      Function()? onLoad,
      Color bgColor = BaseColorUtils.white,
      bool lightText = false}) {
    var msg2 = noDataMsg ??
        (KayoPackage.share.locale?.languageCode == 'zh' ? '暂无数据' : 'No data');
    var msg3 = noDataText ??
        (KayoPackage.share.locale?.languageCode == 'zh'
            ? '没有更多数据了'
            : 'No more data');

    RefreshString strings = KayoPackage.share.locale?.languageCode == 'zh'
        ? ChRefreshString()
        : EnRefreshString();

    return SmartRefresher(
      child: showNoDataWidget
          ? (null == noDataWidget
              ? BaseViewUtils.noData(msg: msg2, width: 219, height: 120)
              : noDataWidget)
          : child ?? BaseViewUtils.noData(msg: msg2, width: 219, height: 120),
//      header: WaterDropMaterialHeader(),
      enablePullDown: enableRefresh,
      enablePullUp: enableLoad,
      controller: controller,
      onRefresh: onRefresh,
      onLoading: onLoad,
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text(strings.idleLoadingText ?? '');
          } else if (mode == LoadStatus.loading) {
            // body = CupertinoActivityIndicator();
            body = MPCircularProgressIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text(strings.loadFailedText ?? '');
          } else if (mode == LoadStatus.canLoading) {
            body = Text(strings.canLoadingText ?? '');
          } else {
            body = Text(msg3);
          }
          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
    );
  }

  static hideRefresh(
      {required RefreshController? controller,
      required bool refresh,
      required int dataSize,
      required int pageSize}) {
    if (refresh) {
      controller?.refreshCompleted();
    } else {
      LoadingUtils.showToast(
          data: dataSize < 1 ? '没有更多数据了' : '上拉加载了${dataSize}条数据');
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
