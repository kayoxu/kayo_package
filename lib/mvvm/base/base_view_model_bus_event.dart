import 'package:event_bus/event_bus.dart';

///  tfblue_flutter_module
///
///
///  Created by kayoxu on 2019-08-05 15:40.
///  Copyright © 2019 kayoxu. All rights reserved.
class BaseViewModelBusEvent {
  static int BASE_VIEW_MODEL_PUSH = 1;
  static int BASE_VIEW_MODEL_POP = 2;

  final int type;
  final String viewModel;

  BaseViewModelBusEvent(this.type, this.viewModel);

  static final EventBus eventBus = new EventBus();

  static handleFunction({required int type, required String viewModel}) {
    eventBus.fire(new BaseViewModelBusEvent(type, viewModel));
  }
}
