import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';

///  kayo_plugin
///  views.widget.alert
///
///  Created by kayoxu on 2019/2/14 2:18 PM.
///  Copyright © 2019 kayoxu. All rights reserved.

class AlertSheet {
  static const String _defaultTitle = '___default_title___';

  /*
  * base
  * 
  * */
  static sheet(context,
      {String? title = _defaultTitle,
      required List<Widget> children,
      bool? showCancel = false,
      bool? textBold = true,
      double? textSize = 14,
      String? cancelText,
      Color? cancelColor = BaseColorUtils.colorRed,
      VoidCallback? cancelCallback}) {
    if (title == _defaultTitle) {
      title = KayoPackageLocalizations.of(context)?.info ?? 'Info';
    }
    cancelCallback = cancelCallback ?? () => hide(context);
    cancelText =
        cancelText ?? KayoPackageLocalizations.of(context)?.cancel ?? 'Cancel';

    var theme = Theme.of(context);

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return SafeArea(
              child: Container(
            // color: BaseColorUtils.white,
            decoration: BoxDecoration(
                color: BaseColorUtils.white.darkColor(theme.cardColor),
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
                if (null != title)
                  TextView(
                    title,
                    size: textSize ?? 14,
                    color: BaseColorUtils.colorGreyLite
                        .darkColor(theme.textTheme.labelMedium?.color),
                    maxLine: 2,
                    margin: EdgeInsets.only(
                        left: 16,
                        top: (textSize ?? 0) > 20 ? 20 : 12,
                        right: 16,
                        bottom: (textSize ?? 0) > 20 ? 20 : 12),
                  ),
                if (null != title)
                  Container(
                    width: double.infinity,
                    height: 0.5,
                    color: BaseColorUtils.colorWindow
                        .darkColor(theme.colorScheme.surface),
                  ),
                Column(
                  children: children,
                ),
                if (showCancel == true)
                  Column(
                    children: <Widget>[
                      Container(
                        height: 6,
                        color: BaseColorUtils.colorWindow
                            .darkColor(theme.colorScheme.surface),
                      ),
                      sheetAction(
                          text: cancelText ?? '',
                          color: cancelColor ??
                              BaseColorUtils.colorBlack.darkColor(
                                  theme.textTheme.labelMedium?.color),
                          showLine: false,
                          padding: (textSize ?? 0) > 20
                              ? EdgeInsets.only(top: 20, bottom: 20)
                              : null,
                          textSize: textSize ?? 14,
                          textBold: textBold ?? true,
                          callback: cancelCallback),
                    ],
                  )
              ],
            ),
          ));
        });
  }

  static hide(context) => Navigator.of(context).pop();

  static Widget sheetAction(
      {required String text,
      required VoidCallback? callback,
      Color? color = BaseColorUtils.colorBlackLite,
      bool? textBold = true,
      double? textSize,
      EdgeInsets? padding,
      bool? showLine = true}) {
    var action = ButtonView(
      text: text,
      showShadow: false,
      textSize: textSize ?? 14,
      fontWeight: textBold == true ? FontWeight.w600 : FontWeight.normal,
      color:
          color.darkColor(KayoPackage.share.theme.textTheme.labelMedium?.color),
      bgColor:
          BaseColorUtils.white.darkColor(KayoPackage.share.theme.cardColor),
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
              Container(
                color: BaseColorUtils.colorWindow.darkOpacity(opacity: 0.15),
                height: 1,
//                margin: EdgeInsets.only(left: 16, right: 16),
              ),
            ],
          );
  }
}
