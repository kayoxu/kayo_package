import 'package:flutter/material.dart';
import 'package:kayo_package/mvvm/base/base_view_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///
///  kayo_package
///  base_view_model_refresh.dart
///
///  Created by kayoxu on 2020/8/6 at 4:34 PM
///  Copyright © 2020 kayoxu. All rights reserved.
///

abstract class BaseViewModelRefreshList<List<T>> extends BaseViewModel {
  List<T> data;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;

  initData() {
    setBusy();
    refresh();
  }

  // 下拉刷新
  refresh(
      {bool init = false,
      ValueChanged<List<T>> onSuccess,
      ValueChanged<List<T>> onCache,
      ValueChanged<String> onError}) async {
    try {
      loadData(onSuccess: (data) {
        _setData(data);
        if (null != onSuccess) {
          onSuccess(data);
        }
      }, onCache: (data) {
        if (null != onCache) {
          _setData(data);
          onCache(data);
        }
      }, onError: (data) {
        if (null != onError) {
          onError(data);
        }
      });
    } catch (e, s) {
//      if (init) list.clear();
//      setError(e, s);
    }
  }

  void _setData(List<T> data) {
    this.data = data;
    if (data == null) {
      setEmpty();
    } else {
      setIdle();
    }
  }

  // 加载数据
  loadData(
      {ValueChanged<List<T>> onSuccess,
      ValueChanged<List<T>> onCache,
      ValueChanged<String> onError});

  @override
  void dispose() {
    _refreshController.dispose();

    super.dispose();
  }
}
