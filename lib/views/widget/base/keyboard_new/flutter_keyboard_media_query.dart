import 'package:flutter/material.dart';
import 'flutter_keyboard_manager.dart';

class FlutterKeyboardMediaQuery extends StatefulWidget {
  final Widget child;

  FlutterKeyboardMediaQuery({this.child}) : assert(child != null);

  @override
  State<StatefulWidget> createState() => FlutterKeyboardMediaQueryState();
}

class FlutterKeyboardMediaQueryState extends State<FlutterKeyboardMediaQuery> {
  double keyboardHeight;
  ValueNotifier<double> keyboardHeightNotifier;

  @override
  void initState() {
    super.initState();
    FlutterKeyboard.keyboardHeightNotifier.addListener(onUpdateHeight);
    keyboardHeightNotifier = FlutterKeyboard.keyboardHeightNotifier;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var data = MediaQuery.of(context, nullOk: true);
    if (data == null) {
      data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    }
    var bottom =
        FlutterKeyboard.keyboardHeightNotifier.value ?? data.viewInsets.bottom;
    // TODO: implement build
    return MediaQuery(
        child: widget.child,
        data: data.copyWith(
            viewInsets: data.viewInsets.copyWith(bottom: bottom)));
  }

  onUpdateHeight() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    FlutterKeyboard.keyboardHeightNotifier.removeListener(onUpdateHeight);
  }
}
