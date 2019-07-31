import 'package:flutter/material.dart';
import 'package:kayo_package/views/widget/base/text_view.dart';
import 'package:kayo_package/views/widget/tool_bar.dart';

/**
 *  kayo_plugin
 *  views
 *
 *  Created by kayoxu on 2019/1/24.
 *  Copyright © 2019 kayoxu. All rights reserved.
 */

class WidgetNotFound extends StatelessWidget {
  Widget build(BuildContext context) {
    return ToolBar(
      title: '页面错误',
      iosBack: true,
      child: Center(
        child: TextView('没有找到相关页面'),
      ),
    );
  }
}
