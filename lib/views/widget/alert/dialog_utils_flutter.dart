import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter/services.dart';
import 'package:kayo_package/kayo_package.dart';

///
///  waste
///  dialog_utils_flutter.dart
///
///  Created by kayoxu on 2020/9/28 at 6:34 PM
///  Copyright © 2020 kayoxu. All rights reserved.
///

class DialogUtilsFlutter {
  static void showDialog(
    BuildContext context, {
    String title,
    double titleSize,
    bool barrierDismissible,
    FontWeight titleFontWeight,
    Color titleColor,
    String subTitle,
    double subTitleSize,
    FontWeight subTitleFontWeight,
    Color subTitleColor,
    bool showCancel = true,
    String cancelText,
    Color cancelColor,
    Function onCancel,
    bool showOk = true,
    bool useDefaultPop = true,
    String okText,
    Color okColor,
    Function onOk,
  }) {
    m.showDialog<int>(
        context: context,
        barrierDismissible: barrierDismissible ?? false,
        builder: (cxt) {
          var titleView = TextView(
            title ?? '',
            maxLine: 3,
            size: titleSize ?? 17,
            fontWeight: titleFontWeight ?? FontWeight.w600,
            color: titleColor ?? BaseColorUtils.colorBlack,
            alignment: Alignment.center,
          );
          var subTitleView = TextView(
            subTitle ?? '',
            maxLine: 10,
            size: subTitleSize ?? 14,
            fontWeight: subTitleFontWeight ?? FontWeight.w600,
            color: subTitleColor ?? BaseColorUtils.colorBlackLiteLite,
            alignment: Alignment.center,
          );

          var actions = <Widget>[
            CupertinoActionSheetAction(
                onPressed: () {
                  if (useDefaultPop == true) _finish(context);
                  onCancel?.call();
                },
                child: TextView(
                  cancelText ?? '取消',
                  size: 15,
                  fontWeight: FontWeight.w600,
                  color: cancelColor ?? BaseColorUtils.colorRedLite,
                )),
            CupertinoActionSheetAction(
                onPressed: () {
                  if (useDefaultPop == true) _finish(context);
                  onOk?.call();
                },
                child: TextView(
                  okText ?? '确定',
                  size: 15,
                  fontWeight: FontWeight.w600,
                  color: okColor ?? BaseColorUtils.colorAccent,
                )),
          ];

          if (showOk != true) {
            actions.removeAt(1);
          }
          if (showCancel != true) {
            actions.removeAt(0);
          }

          var dialog = CupertinoAlertDialog(
            title: null == subTitle
                ? titleView
                : Column(
                    children: <Widget>[
                      titleView,
                      SizedBox(
                        height: 10,
                      ),
                      subTitleView
                    ],
                  ),
            actions: actions,
          );

          return dialog;
        });
  }

  static Future _finish(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
      return Future.value();
    } else {
      return SystemNavigator.pop();
    }
  }
}
