import 'package:flutter/material.dart';
import 'package:kayo_package/utils/base_color_utils.dart';
import 'package:kayo_package/views/widget/visible_view.dart';
import 'package:kayo_package/views/widget/base/button_view.dart';
import 'package:kayo_package/views/widget/base/line_view.dart';
import 'package:kayo_package/views/widget/base/text_view.dart';

/**
 *  kayo_plugin
 *  views.widget.alert
 *
 *  Created by kayoxu on 2019/2/14 2:18 PM.
 *  Copyright © 2019 kayoxu. All rights reserved.
 */

class AlertSheet {
  /*
  * base
  * 
  * */
  static sheet(context,
      {String title = '提示',
      @required List<Widget> children,
      bool showCancel = false,
      bool textBold = true,
      double textSize = 14,
      String cancelText = '取消',
      Color cancelColor = BaseColorUtils.colorRed,
      VoidCallback cancelCallback}) {
    cancelCallback = cancelCallback ?? () => hide(context);

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: BaseColorUtils.white,
            child: /*SafeArea(
              child: ,
            )*/
                Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                VisibleView(
                  visible: null == title ? Visible.gone : Visible.visible,
                  child: TextView(
                    title ?? '',
                    size: 14,
                    color: BaseColorUtils.colorGreyLite,
                    maxLine: 2,
                    margin: EdgeInsets.only(
                        left: 16, top: 12, right: 16, bottom: 12),
                  ),
                ),
                VisibleView(
                  visible: null == title ? Visible.gone : Visible.visible,
                  child: LineView(
                    color: BaseColorUtils.colorWindow,
                    height: 1,
                  ),
                ),
                Column(
                  children: children,
                ),
                VisibleView(
                    visible: showCancel ? Visible.visible : Visible.gone,
                    child: Column(
                      children: <Widget>[
                        LineView(
                          height: 6,
                          color: BaseColorUtils.colorWindow,
                        ),
                        sheetAction(
                            text: cancelText,
                            color: cancelColor,
                            showLine: false,
                            textBold: textBold,
                            callback: cancelCallback),
                      ],
                    ))
              ],
            ),
          );
        });
  }

  static hide(context) => Navigator.of(context).pop();

  static sheetAction(
      {@required String text,
      @required VoidCallback callback,
      Color color = BaseColorUtils.colorBlackLite,
      bool textBold = true,
      double textSize,
      bool showLine = true}) {
    var action = ButtonView(
      text: text,
      showShadow: false,
      textSize: textSize,
      fontWeight: textBold ? FontWeight.bold : FontWeight.normal,
      color: color,
      bgColor: BaseColorUtils.white,
      radius: 0,
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.only(top: 12, bottom: 12),
      width: double.infinity,
      onPressed: callback,
    );

    return !showLine
        ? action
        : Column(
            children: <Widget>[
              action,
              LineView(
                color: BaseColorUtils.colorWindow,
                height: 1,
//                margin: EdgeInsets.only(left: 16, right: 16),
              ),
            ],
          );
  }
}
