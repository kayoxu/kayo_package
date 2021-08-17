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

  ///播放视频
  static fire<T>(T data) {
    eventBus.fire(data);
  }

  ///刷新
  static setState() {
    eventBus.fire('setState');
  }
}