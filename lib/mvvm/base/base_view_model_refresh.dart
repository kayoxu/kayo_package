import 'package:flutter/material.dart';
import 'package:kayo_package/mvvm/base/base_view_model.dart';

///
///  kayo_package
///  base_view_model_refresh.dart
///
///  Created by kayoxu on 2020/8/6 at 4:34 PM
///  Copyright © 2020 kayoxu. All rights reserved.
///

abstract class BaseViewModelRefresh<T> extends BaseViewModel {
  T data;

  initData() {
    setBusy();
    refresh();
  }

  // 下拉刷新
  refresh(
      {bool init = false,
      ValueChanged<T> onSuccess,
      ValueChanged<T> onCache,
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

  void _setData(T data) {
    this.data = data;
    if (data == null) {
      setEmpty();
    } else {
      setIdle();
    }
  }

  // 加载数据
  loadData(
      {ValueChanged<T> onSuccess,
      ValueChanged<T> onCache,
      ValueChanged<String> onError});
}
