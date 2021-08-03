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
  final Widget? child;
  final String? title;
  @Deprecated('用titleWidget代替')
  final Widget? titelWidget;
  final Widget? titleWidget;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  final PreferredSizeWidget? appBar;

  final bool? iosBack;
  final VoidCallback? backClick;
  final Color? backgroundColor;
  final Color? appbarColor;
  final List<Widget>? actions;
  final bool? resizeToAvoidBottomPadding;
  final double? elevation;
  final bool? darkStatusText;
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

  ToolBar({
    @required this.child,
    this.key,
    this.title = '',
    this.titelWidget,
    this.titleWidget,
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
    this.toolbarEndBgColorAlignment,
    this.toolbarStartBgColorAlignment,
    this.toolbarSubView,
    this.marginToolbarTop,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.centerTitle = true,
    this.onWillPop,
    this.leadingIcon,
    this.noAppBar,
    this.leading,
    this.noBack,
    this.titleSpacing,
    this.dragView,
  }) : super(key: key);

  @override
  ToolBarState createState() => ToolBarState();
}

class ToolBarState extends State<ToolBar> {
  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget toolbar = null == widget.appBar
        ? AppBar(
            actions: widget.actions,
            elevation: widget.elevation,
            titleSpacing:
                widget.titleSpacing ?? NavigationToolbar.kMiddleSpacing,
            leading: widget.noBack == true
                ? Container()
                : widget.leading != null
                    ? widget.leading
                    : (widget.iosBack == true || null != widget.leadingIcon
                        ? IconButton(
                            icon: null != widget.leadingIcon
                                ? widget.leadingIcon!
                                : Icon(
                                    Icons.arrow_back_ios,
                                  ),
                            iconSize: 22,
                            color: Color(widget.darkStatusText == true
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
            brightness: widget.darkStatusText == true
                ? Brightness.light
                : Brightness.dark,
            centerTitle: widget.centerTitle ?? true,
            backgroundColor: null != widget.appbarColor
                ? widget.appbarColor
                : BaseColorUtils.colorWindowWhite,
            iconTheme: IconThemeData(
                color: widget.darkStatusText == true
                    ? BaseColorUtils.colorBlack
                    : BaseColorUtils.white),
            title: (null == widget.titelWidget && null == widget.titleWidget)
                ? Text(
                    widget.title ?? '',
                    style: TextStyle(
                        color: widget.darkStatusText == true
                            ? BaseColorUtils.colorBlack
                            : BaseColorUtils.white),
                    textAlign: TextAlign.center,
                  )
                : (widget.titelWidget ?? widget.titleWidget),
          )
        : widget.appBar!;

    var body2 = null == widget.marginToolbarTop
        ? widget.child
        : Container(
            margin: EdgeInsets.only(top: widget.marginToolbarTop ?? 0),
            child: widget.child,
          );
    var scaffold = Scaffold(
      key: widget.key,
      // resizeToAvoidBottomPadding: widget.resizeToAvoidBottomPadding,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomPadding,
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
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
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
