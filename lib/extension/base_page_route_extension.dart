import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpcore/mpkit/mpkit.dart';
import 'package:kayo_package/views/common/404.dart';

extension BasePageRoute on Widget? {
  ///
  Route<dynamic> addPageRouteCupertino() {
    var widget = this;
    if (null == widget) {
      return MPPageRoute(
          builder: (context) => MPScaffold(
                body: WidgetNotFound(
                  backClick: () async {
                    if (Navigator.canPop(context)) {
                      return Navigator.of(context).pop();
                    } else {
                      return SystemNavigator.pop();
                    }
                  },
                ),
              ));
    } else {
      return MPPageRoute(builder: (context) => this ?? Container());
    }
  }
}
