import 'package:event_bus/event_bus.dart';

///  tfblue_flutter_module
///
///
///  Created by kayoxu on 2019-08-05 15:40.
///  Copyright © 2019 kayoxu. All rights reserved.
class PlayerBusEvent<T> {
  T data;

  PlayerBusEvent(this.data);

  static final EventBus eventBus = new EventBus();

  static fire<T>(T data) {
    eventBus.fire(data);
  }

  static setState() {
    eventBus.fire('setState');
  }
}
