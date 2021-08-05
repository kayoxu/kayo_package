import 'package:flutter/material.dart';

///  tfblue_flutter_module
///  common.event
///
///  Created by kayoxu on 2019-06-10 17:23.
///  Copyright © 2019 kayoxu. All rights reserved.
class BaseHttpErrorEvent {
  final int code;

  final String message;

  BaseHttpErrorEvent(this.code, this.message);
}
 