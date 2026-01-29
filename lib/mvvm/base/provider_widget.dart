import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';
import 'package:provider/provider.dart';

/// Provider封装类
///
/// 方便数据初始化
class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  final ValueWidgetBuilder<T> builder;
  final T model;
  final Widget? child;
  final Function(T model)? onModelReady;
  final bool autoDispose;
  final bool autoInitState;
  final bool? autoLoadData;
  final Function? initState;
  final Function? dispose;

  ProviderWidget({
    Key? key,
    required this.builder,
    required this.model,
    this.child,
    this.onModelReady,
    this.autoDispose = true,
    this.autoInitState = true,
    this.autoLoadData,
    this.initState,
    this.dispose,
  }) : super(key: key);

  @override
  _ProviderWidgetState<T> createState() => _ProviderWidgetState<T>();
}

class _ProviderWidgetState<T extends ChangeNotifier>
    extends State<ProviderWidget<T>> with SingleTickerProviderStateMixin {
  late T model;
  StreamSubscription? _stream;
  Map<String, dynamic>? resultArgs;
  dynamic resultData;

  @override
  void initState() {
    super.initState();
    model = widget.model;
    widget.onModelReady?.call(model);

    _initBaseViewModel(model, widget.autoInitState, widget.autoLoadData,
        vsync: this);
    widget.initState?.call();

    _stream = BaseIntentUtils.eventBus.on<String>().listen((page) {
      KayoPackage.share.onNotifyPop
          ?.call(context, page, resultArgs, resultData);
    });
  }

  void _initBaseViewModel(dynamic model, bool autoInitState, bool? autoLoadData,
      {TickerProvider? vsync}) {
    if (model != null && model is BaseViewModel) {
      model.setBuildContext(context);
      model.autoLoadData = autoLoadData ?? false;
      if (autoInitState) {
        model.initState();
      }
      model.onTickerProvider(vsync);
    }
  }

  @override
  void dispose() {
    if (widget.autoDispose) {
      model.dispose();
    }
    widget.dispose?.call();
    _stream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}

class ProviderWidget2<A extends ChangeNotifier, B extends ChangeNotifier>
    extends StatefulWidget {
  final Widget Function(BuildContext context, A model1, B model2, Widget? child)
      builder;
  final A model1;
  final B model2;
  final Widget? child;
  final Function(A model1, B model2)? onModelReady;
  final bool autoDispose;
  final bool autoInitState;
  final bool? autoLoadData;
  final Function? initState;
  final Function? dispose;

  ProviderWidget2({
    Key? key,
    required this.builder,
    required this.model1,
    required this.model2,
    this.child,
    this.onModelReady,
    this.autoDispose = true,
    this.autoInitState = true,
    this.autoLoadData,
    this.initState,
    this.dispose,
  }) : super(key: key);

  @override
  _ProviderWidgetState2<A, B> createState() => _ProviderWidgetState2<A, B>();
}

class _ProviderWidgetState2<A extends ChangeNotifier, B extends ChangeNotifier>
    extends State<ProviderWidget2<A, B>> with SingleTickerProviderStateMixin {
  late A model1;
  late B model2;
  StreamSubscription? _stream;
  Map<String, dynamic>? resultArgs;
  dynamic resultData;

  @override
  void initState() {
    super.initState();
    model1 = widget.model1;
    model2 = widget.model2;
    widget.onModelReady?.call(model1, model2);

    _initBaseViewModel(model1, widget.autoInitState, widget.autoLoadData,
        vsync: this);
    _initBaseViewModel(model2, widget.autoInitState, widget.autoLoadData,
        vsync: this);
    widget.initState?.call();

    _stream = BaseIntentUtils.eventBus.on<String>().listen((page) {
      KayoPackage.share.onNotifyPop
          ?.call(context, page, resultArgs, resultData);
    });
  }

  void _initBaseViewModel(dynamic model, bool autoInitState, bool? autoLoadData,
      {TickerProvider? vsync}) {
    if (model != null && model is BaseViewModel) {
      model.setBuildContext(context);
      model.autoLoadData = autoLoadData ?? false;
      if (autoInitState) {
        model.initState();
      }
      model.onTickerProvider(vsync);
    }
  }

  @override
  void dispose() {
    if (widget.autoDispose) {
      model1.dispose();
      model2.dispose();
    }
    widget.dispose?.call();
    _stream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<A>.value(value: model1),
        ChangeNotifierProvider<B>.value(value: model2),
      ],
      child: Consumer2<A, B>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
