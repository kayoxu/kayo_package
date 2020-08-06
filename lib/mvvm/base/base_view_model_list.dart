import 'package:flutter/material.dart';
import 'package:kayo_package/mvvm/base/base_view_model_refresh.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///
///  kayo_package
///  base_view_model_list.dart
///
///  Created by kayoxu on 2020/8/6 at 6:26 PM
///  Copyright © 2020 kayoxu. All rights reserved.
///

abstract class BaseViewModelList<T> extends BaseViewModelRefresh<T> {
  static const int pageNumFirst = 0;
  static const int pageSize = 20;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;

  int _currentPageNum = pageNumFirst;



  @override
  loadData(
      {ValueChanged<T> onSuccess,
      ValueChanged<T> onCache,
      ValueChanged<String> onError});



  @override
  void dispose() {
    _refreshController.dispose();

    super.dispose();
  }

}
