import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:ui' as ui;

import 'package:kayo_package/views/widget/base/keyboard/utils/keyboard_controller.dart';
import 'package:kayo_package/views/widget/base/keyboard/utils/keyboard_manager.dart';
import 'package:kayo_package/views/widget/base/keyboard/utils/keyboard_media_query.dart';

class CoolKeyboardCarNum {
  static JSONMethodCodec _codec = const JSONMethodCodec();
  static KeyboardConfig _currentKeyboard;
  static Map<CKTextInputType, KeyboardConfig> _keyboards = {};
  static BuildContext _context;
  static OverlayEntry _keyboardEntry;
  static KeyboardController _keyboardController;
  static GlobalKey<KeyboardPageState> _pageKey;
  static bool isInterceptor = false;

  static double get keyboardHeight => _keyboardHeight;
  static double _keyboardHeight;

  static init2(BuildContext context, ValueChanged<String> onKeyboardOpen) {
    _context = context;
    interceptorInput(onKeyboardOpen);
  }

  static init(BuildContext context) {
    _context = context;
    interceptorInput(null);
  }

  static interceptorInput(ValueChanged<String> onKeyboardOpen) {
    if (isInterceptor) return;
    isInterceptor = true;
    ServicesBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler("flutter/textinput",
//    BinaryMessages.setMockMessageHandler("flutter/textinput",
            (ByteData data) async {
      var methodCall = _codec.decodeMethodCall(data);
      switch (methodCall.method) {
        case 'TextInput.show':
          if (_currentKeyboard != null) {
            openKeyboard();
            if (null != onKeyboardOpen) onKeyboardOpen('');
            return _codec.encodeSuccessEnvelope(null);
          } else {
            return await _sendPlatformMessage("flutter/textinput", data);
          }
          break;
        case 'TextInput.hide':
          try {
            if (_currentKeyboard != null) {
              hideKeyboard();
              return _codec.encodeSuccessEnvelope(null);
            } else {
              return await _sendPlatformMessage("flutter/textinput", data);
            }
          } catch (e) {
            print(e);
          }
          break;
        case 'TextInput.setEditingState':
          var editingState = TextEditingValue.fromJSON(methodCall.arguments);
          if (editingState != null && _keyboardController != null) {
            _keyboardController.value = editingState;
            return _codec.encodeSuccessEnvelope(null);
          }
          break;
        case 'TextInput.clearClient':
          try {
            hideKeyboard(animation: true);
            clearKeyboard();
          } catch (e) {
            print(e);
          }
          break;
        case 'TextInput.setClient':
          var setInputType = methodCall.arguments[1]['inputType'];
          InputClient client;
          _keyboards.forEach((inputType, keyboardConfig) {
            if (inputType.name == setInputType['name']) {
              client = InputClient.fromJSON(methodCall.arguments);
              clearKeyboard();
              _currentKeyboard = keyboardConfig;
              _keyboardController = KeyboardController(client: client)
                ..addListener(() {
                  var callbackMethodCall = MethodCall(
                      "TextInputClient.updateEditingState", [
                    _keyboardController.client.connectionId,
                    _keyboardController.value.toJSON()
                  ]);
                  ServicesBinding.instance.defaultBinaryMessenger
                      .handlePlatformMessage(
                          "flutter/textinput",
//                  BinaryMessages.handlePlatformMessage("flutter/textinput",
                          _codec.encodeMethodCall(callbackMethodCall),
                          (data) {});
                });
            }
          });
          if (client != null) {
            await _sendPlatformMessage("flutter/textinput",
                _codec.encodeMethodCall(MethodCall('TextInput.hide')));
            return _codec.encodeSuccessEnvelope(null);
          } else {
            try {
              hideKeyboard(animation: false);
            } catch (e) {
              print(e);
            } finally {
              clearKeyboard();
            }
          }
          break;
      }
      ByteData response = await _sendPlatformMessage("flutter/textinput", data);
      return response;
    });
  }

  static Future<ByteData> _sendPlatformMessage(
      String channel, ByteData message) {
    final Completer<ByteData> completer = Completer<ByteData>();
    ui.window.sendPlatformMessage(channel, message, (ByteData reply) {
      try {
        completer.complete(reply);
      } catch (exception, stack) {
        FlutterError.reportError(FlutterErrorDetails(
          exception: exception,
          stack: stack,
          library: 'services library',
//          context: 'during a platform message response callback',
        ));
      }
    });
    return completer.future;
  }

  static addKeyboard(CKTextInputType inputType, KeyboardConfig config) {
    _keyboards[inputType] = config;
  }

  static openKeyboard() {
    if (_keyboardEntry != null) return;
    _pageKey = GlobalKey<KeyboardPageState>();
    _keyboardHeight = _currentKeyboard.getHeight(_context);
//    KeyboardMediaQueryState queryState = _context
//            .ancestorStateOfType(const TypeMatcher<KeyboardMediaQueryState>())
//        as KeyboardMediaQueryState;

    KeyboardMediaQueryState queryState =
        _context.findAncestorStateOfType() as KeyboardMediaQueryState;
    queryState.update();

    var tempKey = _pageKey;
    _keyboardEntry = OverlayEntry(builder: (ctx) {
      if (_currentKeyboard != null && _keyboardHeight != null) {
        return KeyboardPage(
            key: tempKey,
            child: Builder(builder: (ctx) {
              return _currentKeyboard.builder(ctx, _keyboardController);
            }),
            height: _keyboardHeight);
      } else {
        return Container();
      }
    });

    Overlay.of(_context).insert(_keyboardEntry);
  }

  static hideKeyboard({bool animation = true}) {
    if (_keyboardEntry != null) {
      _keyboardHeight = null;
      _pageKey?.currentState?.animationController?.addStatusListener((status) {
        if (status == AnimationStatus.dismissed ||
            status == AnimationStatus.completed) {
          if (_keyboardEntry != null) {
            _keyboardEntry?.remove();
            _keyboardEntry = null;
          }
        }
      });
      if (animation && false) {
        _pageKey?.currentState?.exitKeyboard();
      } else {
        _keyboardEntry?.remove();
        _keyboardEntry = null;
      }
    }
    _pageKey = null;

    var findAncestorStateOfType = _context?.findAncestorStateOfType();
    KeyboardMediaQueryState queryState = null == findAncestorStateOfType
        ? null
        : findAncestorStateOfType as KeyboardMediaQueryState;
//    KeyboardMediaQueryState queryState = _context
//            .ancestorStateOfType(const TypeMatcher<KeyboardMediaQueryState>())
//        as KeyboardMediaQueryState;
    queryState?.update();
  }

  static clearKeyboard() {
    _currentKeyboard = null;
    if (_keyboardController != null) {
      _keyboardController.dispose();
      _keyboardController = null;
    }
  }

  static sendPerformAction(TextInputAction action) {
    var callbackMethodCall = MethodCall("TextInputClient.performAction",
        [_keyboardController.client.connectionId, action.toString()]);
    ServicesBinding.instance.defaultBinaryMessenger.handlePlatformMessage(
        "flutter/textinput",
//    BinaryMessages.handlePlatformMessage("flutter/textinput",
        _codec.encodeMethodCall(callbackMethodCall),
        (data) {});
  }
}
