import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';

///  kayo_plugin
///  views.widget.alert
///
///  Created by kayoxu on 2019/2/21 9:47 AM.
///  Copyright © 2019 kayoxu. All rights reserved.

class AlertCenter {
  static showMsgDialog(BuildContext context,
      {required String title,
      String? message,
      bool? showCancel,
      String? okTitle,
      Widget? content,
      String? cancelTitle,
      bool cancelable = false,
      EdgeInsets? margin,
      Color? cancelColor,
      Color? okColor,
      Function()? onOk,
      Function()? onCancel}) {
    showDialog(
        context: context,
        barrierDismissible: cancelable,
        builder: (context) => AlertDefaultView(
              context,
              title: title,
              message: message,
              content: content,
              showCancel: showCancel,
              okTitle: okTitle,
              okColor: okColor,
              cancelColor: cancelColor,
              cancelTitle: cancelTitle,
              onOK: onOk,
              onCancel: onCancel,
              margin: margin,
            ));
  }
}

Widget AlertDefaultView(
  BuildContext? context, {
  var title,
  var message,
  Widget? content,
  Function()? onOK,
  Function()? onCancel,
  bool? showCancel,
  String? okTitle,
  Color? cancelColor,
  Color? okColor,
  String? cancelTitle,
  EdgeInsets? margin,
}) {
  return new Container(
      margin: margin,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(12.0),
      child: new Material(
          borderOnForeground: false,
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
//          type: MaterialType.transparency,
          child: new Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                    decoration: ShapeDecoration(
                        color: context!.dialogBackgroundColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ))),
                    margin: const EdgeInsets.all(0),
                    child: Container(
                      child: new Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new TextView(
                              title,
                              size: 20,
                              margin:
                                  EdgeInsets.only(left: 20, top: 20, right: 20),
                            ),
                            if (null != message)
                              TextView(
                                message,
                                size: 14,
                                maxLine: 20,
                                margin: EdgeInsets.only(left: 16, right: 16),
                              ),
                            if (null != content) content,
                            Container(
                              height: 60,
                              child: new Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: buildButtonAction(context,
                                      okColor: okColor,
                                      cancelColor: cancelColor,
                                      showCancel: showCancel,
                                      okTitle: okTitle,
                                      cancelTitle: cancelTitle,
                                      onOk: onOK,
                                      onCancel: onCancel)),
                            )
                          ]),
                    ))
              ])));
}

class AlertDefault extends Dialog {
  final String? title;
  final String? message;
  final Widget? content;
  final Function()? onOK;
  final Function()? onCancel;
  final bool? showCancel;
  final String? okTitle;
  final String? cancelTitle;
  final EdgeInsets? margin;

  const AlertDefault({
    Key? key,
    required this.title,
    this.message,
    this.content,
    this.showCancel = true,
    this.okTitle,
    this.cancelTitle,
    this.onOK,
    this.onCancel,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: margin,
        padding: const EdgeInsets.all(12.0),
        child: new Material(
            borderOnForeground: false,
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
//            type: MaterialType.transparency,
            child: new Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                      decoration: ShapeDecoration(
                          color: context.dialogBackgroundColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ))),
                      margin: const EdgeInsets.all(0),
                      child: Container(
                        child: new Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new TextView(
                                this.title,
                                size: 20,
                                margin: EdgeInsets.only(
                                    left: 20, top: 20, right: 20),
                              ),
                              if (null != message)
                                TextView(
                                  this.message,
                                  size: 14,
                                  maxLine: 20,
                                  margin: EdgeInsets.only(left: 16, right: 16),
                                ),
                              if (null != content) content!,
                              Container(
                                height: 60,
                                child: new Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: buildButtonAction(context,
                                        showCancel: this.showCancel,
                                        okTitle: this.okTitle,
                                        cancelTitle: this.cancelTitle,
                                        onOk: this.onOK,
                                        onCancel: this.onCancel)),
                              )
                            ]),
                      ))
                ])));
  }
}

List<Widget> buildButtonAction(context,
    {bool? showCancel,
    String? okTitle,
    String? cancelTitle,
    Function()? onOk,
    Color? cancelColor,
    Color? okColor,
    Function()? onCancel}) {
  if (null == onOk) onOk = () {};
  if (null == onCancel) onCancel = () {};

  if (null == okTitle)
    okTitle = KayoPackageLocalizations.of(context)?.confirm ?? '确定';
  if (null == cancelTitle)
    cancelTitle = KayoPackageLocalizations.of(context)?.cancel ?? '取消';

  List<Widget> widgets = [];

  var ok = _buttonAction(
      context: context,
      title: okTitle,
      left: false,
      onClick: onOk,
      color: okColor);

  var cancel = _buttonAction(
      context: context,
      title: cancelTitle,
      left: true,
      onClick: onCancel,
      color: cancelColor);
  if (false != showCancel) widgets.add(cancel);
  widgets.add(ok);

  return widgets;
}

Widget _buttonAction(
    {BuildContext? context,
    String? title,
    Color? color,
    Color? bgColor,
    Function()? onClick,
    bool? left}) {
  final isDark = context?.isDark ?? false;
  final defaultColor = isDark ? Colors.white : BaseColorUtils.colorBlack;

  return Expanded(
      child: ButtonView(
    text: title ?? '',
    height: double.infinity,
    borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(true == left ? 8 : 0),
        bottomRight: Radius.circular(false == left ? 8 : 0)),
    margin: EdgeInsets.only(top: 16),
    bgColor: bgColor ?? context?.dialogBackgroundColor,
    showShadow: true,
    color: color ?? defaultColor,
    onPressed: onClick ?? () {},
  ));
}
