import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'base_view_model.dart';

///
///  kayo_package
///  base_view_model_list.dart
///
///  Created by kayoxu on 2020/8/6 at 6:26 PM
///  Copyright © 2020 kayoxu. All rights reserved.
///

/// Base ViewModel for list-based views with pagination support.
abstract class BaseViewModelList<T> extends BaseViewModel {
  static const int defaultPageStart = 1;
  static const int defaultPageSize = 20;

  int _currentPageNum = defaultPageStart;

  List<T> data = [];

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;

  /// Override to provide custom page size.
  int get pageSize => defaultPageSize;

  int get pageIndex => _currentPageNum;

  /// Loads data for a specific page index.
  Future<void> loadDataWithPageIndex(int pageIndex,
      {ValueChanged<List<T>>? onSuccess,
      ValueChanged<List<T>>? onCache,
      ValueChanged<String>? onError}) async {
    _currentPageNum = pageIndex;
    await loadData(
        pageIndex: pageIndex,
        onSuccess: (list) {
          _setData(list);
          onSuccess?.call(list);
        },
        onCache: (list) {
          _setData(list, loadData: false); // Cache usually doesn't stop loading state
          onCache?.call(list);
        },
        onError: (msg) {
          refreshController.loadFailed();
          onError?.call(msg);
        });
  }

  /// Refreshes the list data (pull-to-refresh).
  Future<void> refresh(
      {ValueChanged<List<T>>? onSuccess,
      ValueChanged<List<T>>? onCache,
      ValueChanged<String>? onError,
      bool init = false}) async {
    
    // Only set busy (full screen loading) if explicitly requested or initial load
    if (init) setBusy();

    try {
      _currentPageNum = defaultPageStart;
      await loadData(
          pageIndex: _currentPageNum,
          onSuccess: (list) {
            _setData(list);
            onSuccess?.call(list);
          },
          onCache: (list) {
            // Cache data handling
            _setData(list, loadData: false);
            onCache?.call(list);
          },
          onError: (msg) {
            refreshController.refreshFailed();
            onError?.call(msg);
            if (init) setIdle(); // Ensure we exit busy state on error
          });
    } catch (e, s) {
      debugPrint('refresh error: $e\n$s');
      refreshController.refreshFailed();
      if (init) setIdle();
      // setError(e, s); // Optional: Set error state
    }
  }

  /// Internal method to handle data updates.
  void _setData(List<T>? newData, {bool loadData = true}) {
    if (newData == null || newData.isEmpty) {
      refreshController.refreshCompleted(resetFooterState: true);
      data.clear();
      if (loadData) {
        setEmpty();
      }
    } else {
      data.clear();
      data.addAll(newData);
      refreshController.refreshCompleted();
      
      // Determine if there's more data based on page size
      if (newData.length < pageSize) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
      
      if (loadData) {
        setIdle();
      }
    }
    notifyListeners();
  }

  /// Loads more data (infinite scroll).
  Future<void> loadMore(
      {ValueChanged<List<T>>? onSuccess,
      ValueChanged<List<T>>? onCache,
      ValueChanged<String>? onError}) async {
    try {
      await loadData(
          pageIndex: ++_currentPageNum,
          onSuccess: (list) {
            _setMoreData(list);
            onSuccess?.call(list);
          },
          onCache: (list) {
            _setMoreData(list);
            onCache?.call(list);
          },
          onError: (msg) {
            _currentPageNum--; // Revert page index on error
            refreshController.loadFailed();
            onError?.call(msg);
          });
    } catch (e, s) {
      _currentPageNum--;
      refreshController.loadFailed();
      debugPrint('loadMore error: $e\n$s');
    }
  }

  /// Internal method to append more data.
  void _setMoreData(List<T> moreData) {
    if (moreData.isEmpty) {
      _currentPageNum--;
      refreshController.loadNoData();
    } else {
      data.addAll(moreData);
      if (moreData.length < pageSize) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
      notifyListeners();
    }
  }

  /// Abstract method to implement actual data fetching.
  /// [pageIndex] is nullable but practically required for lists.
  Future<void> loadData(
      {int? pageIndex,
      ValueChanged<List<T>>? onSuccess,
      ValueChanged<List<T>>? onCache,
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
