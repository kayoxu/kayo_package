import 'package:event_bus/event_bus.dart';

///  tfblue_flutter_module
///
///
///  Created by kayoxu on 2019-08-05 15:40.
///  Copyright © 2019 kayoxu. All rights reserved.
class BaseViewModelThemeBusEvent {


  final dynamic data;

  BaseViewModelThemeBusEvent(this.data);

  static final EventBus eventBus = new EventBus();

  static handleFunction({dynamic data}) {
    eventBus.fire(new BaseViewModelThemeBusEvent(data));
  }
}
