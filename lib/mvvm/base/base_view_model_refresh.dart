import 'package:flutter/material.dart';
import 'package:kayo_package/libs/pull_to_refresh/src/smart_refresher.dart';
import 'package:kayo_package/mvvm/base/base_view_model.dart';

///
///  kayo_package
///  base_view_model_refresh.dart
///
///  Created by kayoxu on 2020/8/6 at 4:34 PM
///  Copyright © 2020 kayoxu. All rights reserved.
///

abstract class BaseViewModelRefresh<T> extends BaseViewModel {
  T? data;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;

  // 下拉刷新
  refresh(
      {ValueChanged<T>? onSuccess,
      ValueChanged<T>? onCache,
      ValueChanged<String>? onError}) async {
    setBusy();
    try {
      loadData(onSuccess: (data) {
        _setData(data);
        if (null != onSuccess) {
          onSuccess(data);
        }
        _refreshController.refreshCompleted();
      }, onCache: (data) {
        if (null != onCache) {
          _setData(data, loadData: false);
          onCache(data);
        }
      }, onError: (data) {
        if (null != onError) {
          onError(data);
        }
        _refreshController.refreshCompleted();
      });
    } catch (e, s) {
//      if (init) list.clear();
//      setError(e, s);
    }
  }

  void _setData(T data, {bool loadData = true}) {
    this.data = data;
    if (data == null) {
      if (loadData == true) {
        setEmpty();
      }
    } else {
      if (loadData == true) {
        setIdle();
      }
    }
  }

  // 加载数据
  loadData(
      {ValueChanged<T>? onSuccess,
      ValueChanged<T>? onCache,
      ValueChanged<String>? onError});

  @override
  void initState() {
    super.initState();
    if (autoLoadData == true) {
      setBusy();
      refresh();
    }
  }

  @override
  void dispose() {
    _refreshController.dispose();

    super.dispose();
  }
}
