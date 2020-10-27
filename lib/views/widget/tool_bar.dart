import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kayo_package/kayo_package.dart';
import 'package:kayo_package/utils/base_color_utils.dart';

import 'base/image_view.dart';

///  kayo_plugin
///  views.widget
///
///  Created by kayoxu on 2019/2/13 10:35 AM.
///  Copyright © 2019 kayoxu. All rights reserved.

class ToolBar extends StatefulWidget {
  final Widget child;
  final String title;
  final Widget titelWidget;
  final Widget floatingActionButton;

  final Widget appBar;

  final bool iosBack;
  final VoidCallback backClick;
  final Color backgroundColor;
  final Color appbarColor;
  final List<Widget> actions;
  final bool resizeToAvoidBottomPadding;
  final double elevation;
  final bool darkStatusText;
  final double toolbarHeight;
  final String toolbarSrc;
  final Color toolbarStartBgColor;
  final Color toolbarEndBgColor;
  final Widget toolbarSubView;
  final double marginToolbarTop;
  final bool centerTitle;
  final Function onWillPop;
  final Widget leadingIcon;
  final bool noAppBar;
  final Widget leading;
  final bool noBack;

  ToolBar({
    @required this.child,
    this.title = '',
    this.titelWidget,
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
    this.toolbarSrc,
    this.toolbarStartBgColor,
    this.toolbarEndBgColor,
    this.toolbarSubView,
    this.marginToolbarTop,
    this.floatingActionButton,
    this.centerTitle = true,
    this.onWillPop,
    this.leadingIcon,
    this.noAppBar,
    this.leading,
    this.noBack,
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
            leading: widget.noBack == true
                ? Container()
                : widget.leading != null
                    ? widget.leading
                    : (widget.iosBack || null != widget.leadingIcon
                        ? IconButton(
                            icon: null != widget.leadingIcon
                                ? widget.leadingIcon
                                : Icon(
                                    Icons.arrow_back_ios,
                                  ),
                            iconSize: 22,
                            color: Color(widget.darkStatusText
                                ? 0xff50525c
                                : 0xffffffff),
                            onPressed: null == widget.backClick
                                ? () async {
                                    if (Navigator.canPop(context)) {
                                      return Navigator.of(context).pop();
                                    } else {
                                      return await SystemNavigator.pop();
                                    }
                                  }
                                : widget.backClick, // null disables the button
                          )
                        : null),
            brightness:
                widget.darkStatusText ? Brightness.light : Brightness.dark,
            centerTitle: widget.centerTitle ?? true,
            backgroundColor: null != widget.appbarColor
                ? widget.appbarColor
                : BaseColorUtils.colorWindowWhite,
            iconTheme: IconThemeData(
                color: widget.darkStatusText
                    ? BaseColorUtils.colorBlack
                    : BaseColorUtils.white),
            title: (null == widget.titelWidget)
                ? Text(
                    widget.title,
                    style: TextStyle(
                        color: widget.darkStatusText
                            ? BaseColorUtils.colorBlack
                            : BaseColorUtils.white),
                    textAlign: TextAlign.center,
                  )
                : widget.titelWidget,
          )
        : widget.appBar;

    var scaffold = Scaffold(
      resizeToAvoidBottomPadding: widget.resizeToAvoidBottomPadding,
      backgroundColor: null != widget.backgroundColor
          ? widget.backgroundColor
          : BaseColorUtils.colorWindow,
      appBar: -1 == widget.toolbarHeight
          ? toolbar
          : PreferredSize(
              child: (null == widget.toolbarSrc &&
                      (null == widget.toolbarStartBgColor &&
                          null == widget.toolbarEndBgColor))
                  ? toolbar
                  : Container(
                      decoration: (null != widget.toolbarStartBgColor ||
                              null != widget.toolbarEndBgColor)
                          ? BoxDecoration(
                              gradient: LinearGradient(colors: [
                                widget.toolbarStartBgColor ??
                                    widget.toolbarEndBgColor,
                                widget.toolbarEndBgColor ??
                                    widget.toolbarStartBgColor
                              ]),
//                              borderRadius: BorderRadius.circular(widget.radius)
                            )
                          : BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(source(widget.toolbarSrc)),
                                  fit: BoxFit.fill)),
                      width: double.infinity,
                      height: double.infinity,
                      child: null == widget.toolbarSubView
                          ? toolbar
                          : Column(
                              children: widget.noAppBar == true
                                  ? <Widget>[
                                      PreferredSize(
                                        child: SizedBox(
                                          height: 25,
                                        ),
                                        preferredSize: Size.fromHeight(0),
                                      ),
                                      Expanded(
                                        child: widget.toolbarSubView,
                                      )
                                    ]
                                  : <Widget>[
                                      toolbar,
                                      Expanded(
                                        child: widget.toolbarSubView,
                                      )
                                    ],
                            ),
                    ),
              preferredSize: Size.fromHeight(widget.toolbarHeight),
            ),
      body: null == widget.marginToolbarTop
          ? widget.child
          : Container(
              margin: EdgeInsets.only(top: widget.marginToolbarTop ?? 0),
              child: widget.child,
            ),
      floatingActionButton: widget.floatingActionButton,
    );
    return null == widget.onWillPop
        ? scaffold
        : WillPopScope(
            child: scaffold,
            onWillPop: widget.noBack == true
                ? () {
                    return;
                  }
                : widget.onWillPop);
  }
}
