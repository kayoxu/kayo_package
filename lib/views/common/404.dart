import 'package:flutter/material.dart';

/**
 *  kayo_plugin
 *  views
 *
 *  Created by kayoxu on 2019/1/24.
 *  Copyright © 2019 kayoxu. All rights reserved.
 */

class WidgetNotFound extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("widget not found"),
        ),
        body: Container(child: new Text("widget not found")));
  }
}
