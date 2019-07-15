import 'package:flutter/material.dart';

import 'Keyboard.dart';
import 'utils/KeyboardManager.dart';

class KayoKeyboard {
  static const CKTextInputType input =
      const CKTextInputType(name: 'KayoKeyboard');

  static double getHeight(BuildContext ctx) {
    MediaQueryData mediaQuery = MediaQuery.of(ctx);
    return mediaQuery.size.width / 3 / 2 * 4;
  }

  static register() {
    _register();
  }

  static _register() {
    CoolKeyboard.addKeyboard(
        KayoKeyboard.input,
        KeyboardConfig(
            builder: (context, controller) {
              return Keyboard(controller: controller);
            },
            getHeight: KayoKeyboard.getHeight));
  }
}
