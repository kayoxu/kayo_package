import 'package:flutter/material.dart';

///
///  kayo_package
///  base_view_model.dart
///
///  Created by kayoxu on 2020/8/6 at 2:39 PM
///  Copyright © 2020 kayoxu. All rights reserved.
///

enum ViewState {
  idle,
  busy, //加载中
  empty, //无数据
  error, //加载失败
}

class BaseViewModel with ChangeNotifier {
  bool _disposed = false;
  ViewState _viewState;

  BaseViewModel({ViewState viewState})
      : _viewState = viewState ?? ViewState.idle {
    debugPrint('BaseViewModel---constructor--->$runtimeType');
  }

  /// ViewState
  ViewState get viewState => _viewState;

  set viewState(ViewState viewState) {
//    _viewStateError = null;
    _viewState = viewState;
    notifyListeners();
  }

  bool get isBusy => viewState == ViewState.busy;

  bool get isIdle => viewState == ViewState.idle;

  bool get isEmpty => viewState == ViewState.empty;

  bool get isError => viewState == ViewState.error;

  void setIdle() {
    viewState = ViewState.idle;
  }

  void setBusy() {
    viewState = ViewState.busy;
  }

  void setEmpty() {
    viewState = ViewState.empty;
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    debugPrint('BaseViewModel dispose -->$runtimeType');
    super.dispose();
  }

  void initState() {}
}
