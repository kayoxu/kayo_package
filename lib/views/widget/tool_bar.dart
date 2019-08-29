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
  final bool resizeToAvoidBottomPadding;
  final double elevation;
  final bool darkStatusText;
  final double toolbarHeight;

  ToolBar({
    @required this.child,
    this.title = '',
    this.appBar,
    this.iosBack = false,
    this.backClick,
    this.backgroundColor,
    this.appbarColor,
    this.actions,
    this.resizeToAvoidBottomPadding,
    this.elevation = 0.5,
    this.darkStatusText = true,
    this.toolbarHeight = -1,
  });

  @override
  ToolBarState createState() => ToolBarState();
}

class ToolBarState extends State<ToolBar> {
  @override
  Widget build(BuildContext context) {
    var toolbar = null == widget.appBar
        ? AppBar(
            actions: widget.actions,
            elevation: widget.elevation,
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
                          }
                        : widget.backClick, // null disables the button
                  )
                : null,
            brightness:
                widget.darkStatusText ? Brightness.light : Brightness.dark,
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
        : widget.appBar;

    return Scaffold(
      resizeToAvoidBottomPadding: widget.resizeToAvoidBottomPadding,
      backgroundColor: null != widget.backgroundColor
          ? widget.backgroundColor
          : BaseColorUtils.colorWindow,
//      preferredSize: Size.fromHeight(1),
      appBar: -1 == widget.toolbarHeight
          ? toolbar
          : PreferredSize(
              child: toolbar,
              preferredSize: Size.fromHeight(widget.toolbarHeight),
            ),
      body: widget.child,
    );
  }
}
