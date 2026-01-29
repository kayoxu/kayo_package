import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';

///  kayo_plugin
///  views
///
///  Created by kayoxu on 2019/1/24.
///  Copyright © 2019 kayoxu. All rights reserved.

class WidgetNotFound extends StatelessWidget {
  final VoidCallback? backClick;

  WidgetNotFound({this.backClick});

  Widget build(BuildContext context) {
    return ToolBar(
      title: KayoPackageLocalizations.of(context)?.pageError ?? 'Page Error',
      backClick: backClick,
      iosBack: true,
      child: Center(
        child: TextView(KayoPackageLocalizations.of(context)?.pageNotFound ??
            'Page not found'),
      ),
    );
  }
}
