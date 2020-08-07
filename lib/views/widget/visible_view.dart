import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

///
///  kayo_plugin
/// views.widget
///
///  Created by kayoxu on 2019/1/30 5:43 PM.
///  Copyright © 2019 kayoxu. All rights reserved.
///
///

enum Visible {
  visible,
  invisible,
  gone,
}

class VisibleView extends StatelessWidget {
  Visible visible;
  final Widget child;

  VisibleView({
    @required this.child,
    this.visible = Visible.visible,
  });

  @override
  Widget build(BuildContext context) {
    visible = visible ?? Visible.visible;

    return Visibility(
        visible: visible != Visible.gone,
        child: Container(
            child: new Opacity(
                opacity: visible == Visible.visible ? 1.0 : 0.0,
                child: child)));
  }
}
