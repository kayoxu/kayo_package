import 'dart:isolate';
import 'dart:math';

import 'package:flutter/material.dart';

///
///  isolate_example
///  isolate_utils.dart
///
///  Created by kayoxu on 2021/10/14 at 9:36 上午
///  Copyright © 2021 kayoxu. All rights reserved.
///

class IsolateUtils {
  static IsolateUtils? _singleton;

  IsolateUtils._() {
    print('init');
  }

  factory IsolateUtils.shared() {
    _singleton ??= IsolateUtils._();
    return _singleton!;
  }

  Isolate? newIsolate;
  late ReceivePort receivePort;

  // late SendPort newIceSP;
  // Capability? capability;

  bool _created = false;

  Future<T?> start<T>(
      {required Function(SendPort sendPort) entryPoint,
      required ValueChanged<T>? callback,
      bool autoTerminate = false}) async {
    if (_created == false) {
      await createIsolate(entryPoint);
      receivePort.listen((dynamic message) {
        if (message is SendPort) {
          // newIceSP = message;
        } else if (message is T) {
          callback?.call(message);
          if (autoTerminate == true) {
            terminate();
          }
        }
      });
      _created = true;
    }
  }

  Future<void> createIsolate(
    Function(SendPort callerSP) entryPoint,
  ) async {
    receivePort = ReceivePort();
    newIsolate = await Isolate.spawn(entryPoint, receivePort.sendPort);
  }

  void terminate() {
    // newIsolate?.kill();
    newIsolate?.kill(priority: Isolate.immediate);
    newIsolate = null;
    _created = false;
  }
}
