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

/// Base ViewModel for non-list views that support pull-to-refresh.
abstract class BaseViewModelRefresh<T> extends BaseViewModel {
  T? data;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;

  /// Refreshes the data.
  Future<void> refresh(
      {ValueChanged<T>? onSuccess,
      ValueChanged<T>? onCache,
      ValueChanged<String>? onError,
      bool init = false}) async {
    
    if (init) setBusy();

    try {
      await loadData(
        onSuccess: (data) {
          _setData(data);
          onSuccess?.call(data);
          _refreshController.refreshCompleted();
        },
        onCache: (data) {
          _setData(data, loadData: false);
          onCache?.call(data);
        },
        onError: (msg) {
          _refreshController.refreshFailed();
          onError?.call(msg);
          if (init) setIdle();
        },
      );
    } catch (e, s) {
      debugPrint('refresh error: $e\n$s');
      _refreshController.refreshFailed();
      if (init) setIdle();
    }
  }

  void _setData(T? data, {bool loadData = true}) {
    this.data = data;
    if (data == null) {
      if (loadData) {
        setEmpty();
      }
    } else {
      if (loadData) {
        setIdle();
      }
    }
    notifyListeners();
  }

  /// Abstract method to implement actual data fetching.
  Future<void> loadData(
      {ValueChanged<T>? onSuccess,
      ValueChanged<T>? onCache,
      ValueChanged<String>? onError});

  @override
  void initState() {
    super.initState();
    if (autoLoadData) {
      refresh(init: true);
    }
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
