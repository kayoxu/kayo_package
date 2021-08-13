import 'package:flutter/material.dart';
import 'package:kayo_package/mvvm/base/base_view_model.dart';
import 'package:provider/provider.dart';

/// Provider封装类
///
/// 方便数据初始化

StatefulWidget ProviderWidget<T extends ChangeNotifier>(
    {required ValueWidgetBuilder<T> builder,
    required T model,
    Widget? child,
    Function(T model)? onModelReady,
    bool autoDispose = true,
    bool autoInitState = true,
    bool? autoLoadData,
    Function? initState,
    Function? dispose}) {
  return ProviderWidget6(
    builder: (context, T model, model2, model3, model4, model5, model6, child) {
      return builder.call(context, model, child);
    },
    model: model,
    child: child,
    onModelReady: onModelReady,
    autoDispose: autoDispose,
    autoInitState: autoInitState,
    autoLoadData: autoLoadData,
    initState: initState,
    dispose: dispose,
  );
}

StatefulWidget
    ProviderWidget2<T extends ChangeNotifier, T2 extends ChangeNotifier>(
        {required Widget Function(BuildContext context, T, T2?, Widget? child)
            builder,
        required T model,
        T2? model2,
        Widget? child,
        Function(T model)? onModelReady,
        bool autoDispose = true,
        bool autoInitState = true,
        bool? autoLoadData,
        Function? initState,
        Function? dispose}) {
  return ProviderWidget6(
    builder:
        (context, T model, T2? model2, model3, model4, model5, model6, child) {
      return builder.call(context, model, model2, child);
    },
    model: model,
    model2: model2,
    child: child,
    onModelReady: onModelReady,
    autoDispose: autoDispose,
    autoInitState: autoInitState,
    initState: initState,
    dispose: dispose,
  );
}

StatefulWidget ProviderWidget3<T extends ChangeNotifier,
        T2 extends ChangeNotifier, T3 extends ChangeNotifier>(
    {required Widget Function(BuildContext context, T, T2?, T3?, Widget? child)
        builder,
    required T model,
    T2? model2,
    T3? model3,
    Widget? child,
    Function(T model)? onModelReady,
    bool autoDispose = true,
    bool autoInitState = true,
    bool? autoLoadData,
    Function? initState,
    Function? dispose}) {
  return ProviderWidget6(
    builder: (context, T model, T2? model2, T3? model3, model4, model5, model6,
        child) {
      return builder.call(context, model, model2, model3, child);
    },
    model: model,
    model2: model2,
    model3: model3,
    child: child,
    onModelReady: onModelReady,
    autoDispose: autoDispose,
    autoInitState: autoInitState,
    initState: initState,
    dispose: dispose,
  );
}

StatefulWidget ProviderWidget4<
        T extends ChangeNotifier,
        T2 extends ChangeNotifier,
        T3 extends ChangeNotifier,
        T4 extends ChangeNotifier>(
    {required Widget Function(
            BuildContext context, T, T2?, T3?, T4?, Widget? child)
        builder,
    required T model,
    T2? model2,
    T3? model3,
    T4? model4,
    Widget? child,
    Function(T model)? onModelReady,
    bool autoDispose = true,
    bool autoInitState = true,
    bool? autoLoadData,
    Function? initState,
    Function? dispose}) {
  return ProviderWidget6(
    builder: (context, T model, T2? model2, T3? model3, T4? model4, model5,
        model6, child) {
      return builder.call(context, model, model2, model3, model4, child);
    },
    model: model,
    model2: model2,
    model3: model3,
    model4: model4,
    child: child,
    onModelReady: onModelReady,
    autoDispose: autoDispose,
    autoInitState: autoInitState,
    initState: initState,
    dispose: dispose,
  );
}

StatefulWidget ProviderWidget5<
        T extends ChangeNotifier,
        T2 extends ChangeNotifier,
        T3 extends ChangeNotifier,
        T4 extends ChangeNotifier,
        T5 extends ChangeNotifier>(
    {required Widget Function(
            BuildContext context, T, T2?, T3?, T4?, T5?, Widget? child)
        builder,
    required T model,
    T2? model2,
    T3? model3,
    T4? model4,
    T5? model5,
    Widget? child,
    Function(T model)? onModelReady,
    bool autoDispose = true,
    bool autoInitState = true,
    bool? autoLoadData,
    Function? initState,
    Function? dispose}) {
  return ProviderWidget6(
    builder: (context, T model, T2? model2, T3? model3, T4? model4, T5? model5,
        model6, child) {
      return builder.call(
          context, model, model2, model3, model4, model5, child);
    },
    model: model,
    model2: model2,
    model3: model3,
    model4: model4,
    child: child,
    onModelReady: onModelReady,
    autoDispose: autoDispose,
    autoInitState: autoInitState,
    initState: initState,
    dispose: dispose,
  );
}

class ProviderWidget6<
    T extends ChangeNotifier,
    T2 extends ChangeNotifier,
    T3 extends ChangeNotifier,
    T4 extends ChangeNotifier,
    T5 extends ChangeNotifier,
    T6 extends ChangeNotifier> extends StatefulWidget {
  // final ValueWidgetBuilder<T, T2?, T3?, T4?, T5?> builder;
  final Widget Function(
      BuildContext context, T, T2?, T3?, T4?, T5?, T6?, Widget? child) builder;
  final T model;
  final T2? model2;
  final T3? model3;
  final T4? model4;
  final T5? model5;
  final T6? model6;
  final Widget? child;
  final Function(T model)? onModelReady;
  final bool autoDispose;
  final bool autoInitState;
  final bool? autoLoadData;
  final Function? initState;
  final Function? dispose;

  ProviderWidget6(
      {Key? key,
      required this.builder,
      required this.model,
      this.model2,
      this.model3,
      this.model4,
      this.model5,
      this.model6,
      this.child,
      this.onModelReady,
      this.autoDispose: true,
      this.autoInitState: true,
      this.autoLoadData: true,
      this.initState,
      this.dispose})
      : super(key: key);

  _ProviderWidget6State<T, T2, T3, T4, T5, T6> createState() =>
      _ProviderWidget6State<T, T2, T3, T4, T5, T6>();
}

class _ProviderWidget6State<
        T extends ChangeNotifier,
        T2 extends ChangeNotifier,
        T3 extends ChangeNotifier,
        T4 extends ChangeNotifier,
        T5 extends ChangeNotifier,
        T6 extends ChangeNotifier>
    extends State<ProviderWidget6<T, T2, T3, T4, T5, T6>> {
  late T model;
  T2? model2;
  T3? model3;
  T4? model4;
  T5? model5;
  T6? model6;

  @override
  void initState() {
    model = widget.model;
    widget.onModelReady?.call(model);
    super.initState();

    if (model is BaseViewModel) {
      (model as BaseViewModel).setBuildContext(context);
      (model as BaseViewModel).autoLoadData = widget.autoLoadData ?? false;
      if (widget.autoInitState == true) {
        (model as BaseViewModel).initState();
      }
    }
    if (model2 is BaseViewModel) {
      (model2 as BaseViewModel).setBuildContext(context);
      (model2 as BaseViewModel).autoLoadData = widget.autoLoadData ?? false;
      if (widget.autoInitState == true) {
        (model2 as BaseViewModel).initState();
      }
    }
    if (model3 is BaseViewModel) {
      (model3 as BaseViewModel).setBuildContext(context);
      (model3 as BaseViewModel).autoLoadData = widget.autoLoadData ?? false;
      if (widget.autoInitState == true) {
        (model3 as BaseViewModel).initState();
      }
    }
    if (model4 is BaseViewModel) {
      (model4 as BaseViewModel).setBuildContext(context);
      (model4 as BaseViewModel).autoLoadData = widget.autoLoadData ?? false;
      if (widget.autoInitState == true) {
        (model4 as BaseViewModel).initState();
      }
    }
    if (model5 is BaseViewModel) {
      (model5 as BaseViewModel).setBuildContext(context);
      (model5 as BaseViewModel).autoLoadData = widget.autoLoadData ?? false;
      if (widget.autoInitState == true) {
        (model5 as BaseViewModel).initState();
      }
    }
    if (model6 is BaseViewModel) {
      (model6 as BaseViewModel).setBuildContext(context);
      (model6 as BaseViewModel).autoLoadData = widget.autoLoadData ?? false;
      if (widget.autoInitState == true) {
        (model6 as BaseViewModel).initState();
      }
    }
    if (null != widget.initState) {
      widget.initState?.call();
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.autoDispose) {
      model.dispose();
      model2?.dispose();
      model3?.dispose();
      model4?.dispose();
      model5?.dispose();
      model6?.dispose();
    }
    if (null != widget.dispose) {
      widget.dispose?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider<T>.value(
    //   value: model,
    //   child: Consumer<T>(
    //     builder: widget.builder,
    //     child: widget.child,
    //   ),
    // );

    return MultiProvider(
        providers: [
          ChangeNotifierProvider<T>.value(value: model),
          ChangeNotifierProvider<T2?>.value(value: model2),
          ChangeNotifierProvider<T3?>.value(value: model3),
          ChangeNotifierProvider<T4?>.value(value: model4),
          ChangeNotifierProvider<T5?>.value(value: model5),
          ChangeNotifierProvider<T6?>.value(value: model6),
        ],
        child: Consumer6<T, T2?, T3?, T4?, T5?, T6?>(
          builder: widget.builder,
          child: widget.child,
        ));
  }
}

// class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
//   final ValueWidgetBuilder<T> builder;
//   final T model;
//   final Widget? child;
//   final Function(T model)? onModelReady;
//   final bool autoDispose;
//   final bool autoInitState;
//   final bool? autoLoadData;
//   final Function? initState;
//   final Function? dispose;
//
//   ProviderWidget(
//       {Key? key,
//       required this.builder,
//       required this.model,
//       this.child,
//       this.onModelReady,
//       this.autoDispose: true,
//       this.autoInitState: true,
//       this.autoLoadData: true,
//       this.initState,
//       this.dispose})
//       : super(key: key);
//
//   _ProviderWidgetState<T> createState() => _ProviderWidgetState<T>();
// }
//
// class _ProviderWidgetState<T extends ChangeNotifier>
//     extends State<ProviderWidget<T>> {
//   late T model;
//
//   @override
//   void initState() {
//     model = widget.model;
//     widget.onModelReady?.call(model);
//     super.initState();
//
//     if (model is BaseViewModel) {
//       (model as BaseViewModel).setBuildContext(context);
//       (model as BaseViewModel).autoLoadData = widget.autoLoadData ?? false;
//       if (widget.autoInitState == true) {
//         (model as BaseViewModel).initState();
//       }
//     }
//     if (null != widget.initState) {
//       widget.initState?.call();
//     }
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     if (widget.autoDispose) model.dispose();
//     if (null != widget.dispose) {
//       widget.dispose?.call();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<T>.value(
//       value: model,
//       child: Consumer<T>(
//         builder: widget.builder,
//         child: widget.child,
//       ),
//     );
//   }
// }

// class ProviderWidget2<A extends ChangeNotifier, B extends ChangeNotifier>
//     extends StatefulWidget {
//   final Widget Function(BuildContext context, A model1, B model2, Widget? child)
//       builder;
//   final A model1;
//   final B model2;
//   final Widget? child;
//   final Function(A model1, B model2)? onModelReady;
//   final bool? autoDispose;
//
//   ProviderWidget2({
//     Key? key,
//     required this.builder,
//     required this.model1,
//     required this.model2,
//     this.child,
//     this.onModelReady,
//     this.autoDispose,
//   }) : super(key: key);
//
//   _ProviderWidgetState2<A, B> createState() => _ProviderWidgetState2<A, B>();
// }
//
// class _ProviderWidgetState2<A extends ChangeNotifier, B extends ChangeNotifier>
//     extends State<ProviderWidget2<A, B>> {
//   late A model1;
//   late B model2;
//
//   @override
//   void initState() {
//     model1 = widget.model1;
//     model2 = widget.model2;
//     widget.onModelReady?.call(model1, model2);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     if (widget.autoDispose == true) {
//       model1.dispose();
//       model2.dispose();
//     }
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//         providers: [
//           ChangeNotifierProvider<A>.value(value: model1),
//           ChangeNotifierProvider<B>.value(value: model2),
//         ],
//         child: Consumer2<A, B>(
//           builder: widget.builder,
//           child: widget.child,
//         ));
//   }
// }
