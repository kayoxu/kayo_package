import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';

import 'base_view_theme_bus_event.dart';

///
///  kayo_package
///  base_view_model.dart
///
///  Created by kayoxu on 2020/8/6 at 2:39 PM
///  Copyright © 2020 kayoxu. All rights reserved.
///

enum ViewState {
  idle,
  busy, // 加载中
  empty, // 无数据
  error, // 加载失败
}

class BaseViewModel with ChangeNotifier {
  bool _disposed = false;
  ViewState _viewState;
  BuildContext? context;
  
  /// Whether to auto load data. Defaults to false.
  bool autoLoadData = false;
  
  bool isMobileResolution = false;
  StreamSubscription? _themeChangeNotifier;

  final bool themeNotifier;

  BaseViewModel({
    ViewState viewState = ViewState.idle,
    this.context,
    this.themeNotifier = false,
  }) : _viewState = viewState {
    debugPrint('BaseViewModel---constructor--->$runtimeType');
  }

  /// ViewState
  ViewState get viewState => _viewState;

  set viewState(ViewState viewState) {
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

  void setError() {
    viewState = ViewState.error;
  }

  void setIsMobileResolution(BuildContext? context) {
    final targetContext = context ?? this.context;
    if (targetContext != null) {
      isMobileResolution = MediaQuery.of(targetContext).size.width < 768;
    }
  }

  void setBuildContext(BuildContext context) {
    this.context = context;
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

    if (themeNotifier) {
      _themeChangeNotifier?.cancel();
      _themeChangeNotifier = null;
    }
    super.dispose();
  }

  @mustCallSuper
  void initState() {
    debugPrint('BaseViewModel initState -->$runtimeType');
    if (themeNotifier) {
      _themeChangeNotifier = BaseViewModelThemeBusEvent.eventBus
          .on<BaseViewModelThemeBusEvent>()
          .listen((event) {
        onThemeChange(event.data);
      });
    }
  }

  void onThemeChange(dynamic data) {
    if (themeNotifier) {
      notifyListeners();
    }
  }

  void onTickerProvider(TickerProvider? vsync) {}
}
