import 'package:flutter/material.dart';

import '../cool_ui.dart';
import 'car_num_keyboard.dart';
import 'car_num_keyboard_bad.dart';

///
///  kayo_package
///  keyboard_tools.dart
///
///  Created by kayoxu on 2020/7/7 at 4:16 PM
///  Copyright © 2020 kayoxu. All rights reserved.
///

class FlutterKeyboard {
  static const CKTextInputType carNum =
      const CKTextInputType(name: 'CarNumKeyboard');
  static const CKTextInputType carNumBad =
      const CKTextInputType(name: 'CarNumKeyboardBad');
  static const CKTextInputType number =
      const CKTextInputType(name: 'NumberKeyboardBad');
  static const CKTextInputType phone =
      const CKTextInputType(name: 'PhoneKeyboardBad');

  static register() {
    KeyboardCarNum.register();
    KeyboardCarNumBad.register();
//    NumberKeyboard.register();
  }
}
