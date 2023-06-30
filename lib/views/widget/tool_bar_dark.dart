import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kayo_package/utils/base_color_utils.dart';
import 'package:mpcore/mpkit/mpkit.dart';

import 'base/image_view.dart';

///  kayo_plugin
///  views.widget
///
///  Created by kayoxu on 2019/2/13 10:35 AM.
///  Copyright © 2019 kayoxu. All rights reserved.

class ToolBarDark extends StatefulWidget {
  final Widget? child;
  final String? title;
  final Widget? titleWidget;
  final Widget? floatingActionButton;
  // final FloatingActionButtonLocation? floatingActionButtonLocation;

  final PreferredSizeWidget? appBar;
  final Brightness? brightness;

  final bool? iosBack;
  final VoidCallback? backClick;
  final Color? backgroundColor;
  final Color? appbarColor;
  final List<Widget>? actions;
  final bool? resizeToAvoidBottomPadding;
  final double? elevation;
  final double? toolbarHeight;
  final String? toolbarSrc;
  final Color? toolbarStartBgColor;
  final Color? toolbarEndBgColor;
  final Alignment? toolbarStartBgColorAlignment;
  final Alignment? toolbarEndBgColorAlignment;
  final Widget? toolbarSubView;
  final double? marginToolbarTop;
  final bool? centerTitle;
  final WillPopCallback? onWillPop;
  final Widget? leadingIcon;
  final bool? noAppBar;
  final Widget? leading;
  final bool? noBack;
  final Key? key;
  final double? titleSpacing;
  final Widget? dragView;

  final DragStartBehavior? drawerDragStartBehavior;
  final Widget? drawer;
  final double? drawerEdgeDragWidth;
  final bool? drawerEnableOpenDragGesture;
  final Color? drawerScrimColor;
  final Widget? endDrawer;
  final bool? endDrawerEnableOpenDragGesture;
  // final DrawerCallback? onDrawerChanged;
  // final DrawerCallback? onEndDrawerChanged;

  ToolBarDark({
    required this.child,
    this.key,
    this.title = '',
    this.titleWidget,
    this.brightness,
    this.appBar,
    this.iosBack = false,
    this.backClick,
    this.backgroundColor,
    this.appbarColor,
    this.actions,
    this.resizeToAvoidBottomPadding,
    this.elevation = 0,
    this.toolbarHeight = -1,
    this.toolbarSrc,
    this.toolbarStartBgColor,
    this.toolbarEndBgColor,
    this.toolbarEndBgColorAlignment,
    this.toolbarStartBgColorAlignment,
    this.toolbarSubView,
    this.marginToolbarTop,
    this.floatingActionButton,
    // this.floatingActionButtonLocation,
    this.centerTitle = true,
    this.onWillPop,
    this.leadingIcon,
    this.noAppBar,
    this.leading,
    this.noBack,
    this.titleSpacing,
    this.dragView,
    this.drawerDragStartBehavior,
    this.drawer,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture,
    this.drawerScrimColor,
    this.endDrawer,
    this.endDrawerEnableOpenDragGesture,
    // this.onDrawerChanged,
    // this.onEndDrawerChanged,
  }) : super(key: key);

  @override
  ToolBarDarkState createState() => ToolBarDarkState();
}

class ToolBarDarkState extends State<ToolBarDark> {
  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget toolbar = null == widget.appBar
        ? MPAppBar(
      context: context,
      title: (null == widget.titleWidget)
          ? Text(
        widget.title ?? '',
        style: TextStyle(
            color: widget.brightness == Brightness.light
                ? BaseColorUtils.colorBlack
                : BaseColorUtils.white),
        textAlign: TextAlign.center,
      )
          : widget.titleWidget,
    )
        : widget.appBar!;

    var body2 = null == widget.marginToolbarTop
        ? widget.child
        : Container(
      margin: EdgeInsets.only(top: widget.marginToolbarTop ?? 0),
      child: widget.child,
    );
    var scaffold = MPScaffold(
      backgroundColor: widget.backgroundColor ??
          BaseColorUtils.darkWindow(context: context),
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
            gradient: LinearGradient(
              colors: [
                widget.toolbarStartBgColor ??
                    widget.toolbarEndBgColor!,
                widget.toolbarEndBgColor ??
                    widget.toolbarStartBgColor!
              ],
              begin: widget.toolbarStartBgColorAlignment ??
                  Alignment.centerLeft,
              end: widget.toolbarEndBgColorAlignment ??
                  Alignment.centerRight,
            ),
//                              borderRadius: BorderRadius.circular(widget.radius)
          )
              : BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      source(widget.toolbarSrc ?? '')),
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
                child: widget.toolbarSubView!,
              )
            ]
                : <Widget>[
              toolbar,
              Expanded(
                child: widget.toolbarSubView!,
              )
            ],
          ),
        ),
        preferredSize: Size.fromHeight(widget.toolbarHeight ?? 0),
      ),
      body: null == widget.dragView
          ? body2
          : Stack(
        children: [body2!, widget.dragView!],
      ),
      // floatingActionButton: widget.floatingActionButton,
      // floatingActionButtonLocation: widget.floatingActionButtonLocation,
    );
    return widget.noBack != true && null == widget.onWillPop
        ? scaffold
        : WillPopScope(
        child: scaffold,
        onWillPop: widget.noBack == true && widget.onWillPop == null
            ? () async {
          return false;
        }
            : widget.onWillPop);
  }
}
