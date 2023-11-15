import 'package:flutter/material.dart';
import 'package:kayo_package/utils/base_color_utils.dart';
import 'package:kayo_package/views/widget/visible_view.dart';
import 'package:kayo_package/views/widget/base/button_view.dart';
import 'package:kayo_package/views/widget/base/line_view.dart';
import 'package:kayo_package/views/widget/base/text_view.dart';

///  kayo_plugin
///  views.widget.alert
///
///  Created by kayoxu on 2019/2/14 2:18 PM.
///  Copyright © 2019 kayoxu. All rights reserved.

class AlertSheet {
  /*
  * base
  * 
  * */
  static sheet(context,
      {String? title = '提示',
        required List<Widget> children,
        bool? showCancel = false,
        bool? textBold = true,
        double? textSize = 14,
        String? cancelText = '取消',
        Color? cancelColor = BaseColorUtils.colorRed,
        VoidCallback? cancelCallback}) {
    cancelCallback = cancelCallback ?? () => hide(context);

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return SafeArea(
              child: Container(
                // color: BaseColorUtils.white,
                decoration: BoxDecoration(
                    color: BaseColorUtils.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12))),
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
                        size: textSize ?? 14,
                        color: BaseColorUtils.colorGreyLite,
                        maxLine: 2,
                        margin: EdgeInsets.only(
                            left: 16,
                            top: (textSize ?? 0) > 20 ? 20 : 12,
                            right: 16,
                            bottom: (textSize ?? 0) > 20 ? 20 : 12),
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
                        visible:
                        showCancel == true ? Visible.visible : Visible.gone,
                        child: Column(
                          children: <Widget>[
                            LineView(
                              height: 6,
                              color: BaseColorUtils.colorWindow,
                            ),
                            sheetAction(
                                text: cancelText ?? '',
                                color: cancelColor ?? BaseColorUtils.colorBlack,
                                showLine: false,
                                padding: (textSize ?? 0) > 20 ? EdgeInsets.only(
                                    top: 20, bottom: 20) : null,
                                textSize: textSize ?? 14,
                                textBold: textBold ?? true,
                                callback: cancelCallback),
                          ],
                        ))
                  ],
                ),
              ));
        });
  }

  static hide(context) => Navigator.of(context).pop();

  static Widget sheetAction({required String text,
    required VoidCallback? callback,
    Color? color = BaseColorUtils.colorBlackLite,
    bool? textBold = true,
    double? textSize,
    EdgeInsets? padding,
    bool? showLine = true}) {
    var action = ButtonView(
      text: text,
      showShadow: false,
      textSize: textSize,
      fontWeight: textBold == true ? FontWeight.w600 : FontWeight.normal,
      color: color,
      bgColor: BaseColorUtils.white,
      radius: 0,
      margin: EdgeInsets.all(0),
      padding: padding ?? EdgeInsets.only(top: 12, bottom: 12),
      width: double.infinity,
      onPressed: callback!,
    );

    return showLine != true
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
