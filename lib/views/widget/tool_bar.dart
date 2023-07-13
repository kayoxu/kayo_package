import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kayo_package/kayo_package_utils.dart';
import 'package:kayo_package/utils/base_color_utils.dart';
import 'package:flutter/material.dart';
import 'package:kayo_package/utils/base_sys_utils.dart';
import 'package:kayo_package/views/widget/base/clickable.dart';
import 'package:mpcore/mpkit/mpkit.dart';
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

  // final FloatingActionButtonLocation? floatingActionButtonLocation;

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

  final DragStartBehavior? drawerDragStartBehavior;
  final Widget? drawer;
  final double? drawerEdgeDragWidth;
  final bool? drawerEnableOpenDragGesture;
  final Color? drawerScrimColor;
  final Widget? endDrawer;
  final bool? endDrawerEnableOpenDragGesture;

  // final DrawerCallback? onDrawerChanged;
  // final DrawerCallback? onEndDrawerChanged;

  ToolBar({
    required this.child,
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
    // this.floatingActionButtonLocation,
    this.centerTitle = true,
    this.onWillPop,
    this.leadingIcon,
    this.noAppBar = false,
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
  ToolBarState createState() => ToolBarState();
}

class ToolBarState extends State<ToolBar> {
  @override
  Widget build(BuildContext context) {
    var ll = widget.noBack == true
        ? Container()
        : widget.leading != null
            ? widget.leading
            : (widget.iosBack == true || null != widget.leadingIcon
                ? Clickable(
                    alignment: Alignment.center,
                    width: 40,
                    height: 40,
                    child: null != widget.leadingIcon
                        ? widget.leadingIcon!
                        : MPIcon(
                            MaterialIcons.arrow_back_ios,
                            color: Color(
                              widget.darkStatusText == true
                                  ? 0xff50525c
                                  : 0xffffffff,
                            ),
                          ),

                    onTap: widget.backClick ??
                        (null != KayoPackage.share.onTapToolbarBack
                            ? () {
                                KayoPackage.share.onTapToolbarBack
                                    ?.call(context);
                              }
                            : () async {
                                try {
                                  if (Navigator.canPop(context)) {
                                    return Navigator.of(context).pop();
                                  } else {
                                    return await SystemNavigator.pop();
                                  }
                                } catch (e) {
                                  print(e);
                                  return await SystemNavigator.pop();
                                }
                              }), // null disables the button
                  )
                : null);

    var leadi = ll;
    if (!BaseSysUtils.empty(widget.actions)) {
      var as = widget.actions;
      if (null != ll) {
        as!.insert(0, ll);
      }
      leadi = Row(
        children: as!,
      );
    }

    PreferredSizeWidget toolbar = null == widget.appBar
        ? MPAppBar(
            context: context,
            // trailing: widget.actions?.first,
            leading: leadi,
            backgroundColor: null != widget.appbarColor
                ? widget.appbarColor!
                : BaseColorUtils.colorWindowWhite,
            title: (null == widget.titelWidget && null == widget.titleWidget)
                ? Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Text(
                      widget.title ?? '',
                      maxLines: 1,
                      style: TextStyle(
                          color: widget.darkStatusText == true
                              ? BaseColorUtils.colorBlack
                              : BaseColorUtils.white),
                      textAlign: TextAlign.center,
                    ),
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
    var scaffold = MPScaffold(
      name: widget.title,
      // barrierDismissible: false,
      backgroundColor: null != widget.backgroundColor
          ? widget.backgroundColor
          : BaseColorUtils.colorWindow,
      appBar: widget.noAppBar == true
          ? null
          : (-1 == widget.toolbarHeight
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
                                    begin:
                                        widget.toolbarStartBgColorAlignment ??
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
                )),
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
