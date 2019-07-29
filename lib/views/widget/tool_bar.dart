import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kayo_package/utils/base_color_utils.dart';

/**
 *  kayo_plugin
 *  views.widget
 *
 *  Created by kayoxu on 2019/2/13 10:35 AM.
 *  Copyright © 2019 kayoxu. All rights reserved.
 */

class ToolBar extends StatefulWidget {
  final Widget child;
  final String title;
  final AppBar appBar;

  final bool iosBack;
  final VoidCallback backClick;
  final Color backgroundColor;
  final Color appbarColor;
  final List<Widget> actions;

  ToolBar({
    @required this.child,
    this.title = '',
    this.appBar,
    this.iosBack = false,
    this.backClick,
    this.backgroundColor,
    this.appbarColor,
    this.actions,
  });

  @override
  ToolBarState createState() => ToolBarState();
}

class ToolBarState extends State<ToolBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: null != widget.backgroundColor
          ? widget.backgroundColor : BaseColorUtils.colorWindow,
      appBar: null == widget.appBar
          ? AppBar(
        actions: widget.actions,
        elevation: 0.5,
        leading: widget.iosBack
            ? IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 22,
          color: Color(0xff50525c),
          onPressed: null == widget.backClick
              ? () {
            if (Navigator.canPop(context)) {
              return Navigator.of(context).pop();
            } else {
              return SystemNavigator.pop();
            }
          } : widget.backClick, // null disables the button
        )
            : null,
        brightness: Brightness.light,
        centerTitle: true,
        backgroundColor: null != widget.appbarColor
            ? widget.appbarColor
            : BaseColorUtils.colorWindowWhite,
        iconTheme: IconThemeData(color: BaseColorUtils.colorBlack),
        title: Text(
          widget.title,
          style: TextStyle(color: BaseColorUtils.colorBlack),
          textAlign: TextAlign.center,
        ),

      )
          : widget.appBar,
      body: widget.child,
    );
  }
}
