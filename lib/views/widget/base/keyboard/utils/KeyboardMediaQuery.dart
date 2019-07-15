import 'package:flutter/material.dart';
import 'package:kayo_package/views/widget/base/keyboard/utils/KeyboardManager.dart';

import '../KayoKeyboard.dart';

class KeyboardMediaQuery extends StatefulWidget {
  final Widget child;

  KeyboardMediaQuery({this.child}) : assert(child != null);

  @override
  State<StatefulWidget> createState() => KeyboardMediaQueryState();
}

class KeyboardMediaQueryState extends State<KeyboardMediaQuery> {
  @override
  Widget build(BuildContext context) {
    var data = MediaQuery.of(context);
    print('KeyboardMediaQuery${CoolKeyboard.keyboardHeight}');
    return MediaQuery(
        child: widget.child,
        data: data.copyWith(
            viewInsets:
                data.viewInsets.copyWith(bottom: CoolKeyboard.keyboardHeight)));
  }

  update() {
    setState(() => {});
  }
}
