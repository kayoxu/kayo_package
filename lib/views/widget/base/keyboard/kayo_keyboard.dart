import 'package:flutter/material.dart';
import 'package:kayo_package/views/widget/base/keyboard/utils/keyboard_manager_car_num.dart';
import 'package:kayo_package/views/widget/base/keyboard/utils/keyboard_manager_number.dart';

import 'keyboard.dart';
import 'keyboard_common.dart';
import 'utils/keyboard_manager.dart';

class KayoKeyboard {
  static const CKTextInputType input =
      const CKTextInputType(name: 'KayoKeyboard');
  static const CKTextInputType number =
      const CKTextInputType(name: 'KayoKeyboard_number');
  static const CKTextInputType carNum =
      const CKTextInputType(name: 'KayoKeyboard_car_num');

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
    CoolKeyboardNumber.addKeyboard(
        KayoKeyboard.number,
        KeyboardConfig(
            builder: (context, controller) {
              return KeyboardCommon(
                controller: controller,
                kayoInputTypeCommon: KayoInputTypeCommon.number,
              );
            },
            getHeight: KayoKeyboard.getHeight));
    CoolKeyboardCarNum.addKeyboard(
        KayoKeyboard.carNum,
        KeyboardConfig(
            builder: (context, controller) {
              return KeyboardCommon(
                  controller: controller,
                  kayoInputTypeCommon: KayoInputTypeCommon.carNo);
            },
            getHeight: KayoKeyboard.getHeight));
  }
}
