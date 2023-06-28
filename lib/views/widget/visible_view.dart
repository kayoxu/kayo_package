import 'package:flutter/material.dart';
import 'package:kayo_package/extension/base_widget_extension.dart';
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
  final Visible? visible;
  final Widget? child;
  final Key? key;

  VisibleView({
    required this.child,
    this.visible = Visible.visible,
    this.key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: visible == Visible.visible ? 1.0 : 0.0,
        child: child).addIgnorePointer(ignoring: visible != Visible.visible);

    // return Visibility(
    //         key: key,
    //         visible: (visible ?? Visible.visible) != Visible.gone,
    //         child:  Opacity(
    //                 opacity: visible == Visible.visible ? 1.0 : 0.0,
    //                 child: child))
    //     .addIgnorePointer(ignoring: visible == Visible.invisible);
  }
}
