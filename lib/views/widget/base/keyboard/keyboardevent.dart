import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:kayo_package/views/widget/base/keyboard/keyboard.dart';

class KeyboardEvent {
    final KayoInputType kayoInputType;

    KeyboardEvent(this.kayoInputType);

    static final EventBus eventBus = new EventBus();

    static keyboardHandleFunction(kayoInputType) {
        eventBus.fire(new KeyboardEvent(kayoInputType));
    }
}