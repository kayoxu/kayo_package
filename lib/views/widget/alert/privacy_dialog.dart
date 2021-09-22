import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kayo_package/views/widget/base/text_view.dart';

///
///  kayo_package
///  privacy_dialog.dart
///
///  Created by kayoxu on 2021/9/22 at 11:00 上午
///  Copyright © 2021 kayoxu. All rights reserved.
///

typedef OnTapCallback = void Function(String key);

class PrivacyView extends StatefulWidget {
  final String data;
  final List<String> keys;
  final TextStyle? style;
  final TextStyle? keyStyle;
  final OnTapCallback? onTapCallback;

  const PrivacyView({
    Key? key,
    required this.data,
    required this.keys,
    this.style,
    this.keyStyle,
    this.onTapCallback,
  }) : super(key: key);

  @override
  _PrivacyViewState createState() => _PrivacyViewState();
}

class _PrivacyViewState extends State<PrivacyView> {
  List<String> _list = [];

  @override
  void initState() {
    _split();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <InlineSpan>[
            ..._list.map((e) {
              if (widget.keys.contains(e)) {
                return TextSpan(
                  text: '$e',
                  style: widget.keyStyle ??
                      TextStyle(color: Theme.of(context).primaryColor),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      widget.onTapCallback?.call(e);
                    },
                );
              } else {
                return TextSpan(text: '$e', style: widget.style);
              }
            }).toList()
          ]),
    );
  }

  void _split() {
    int startIndex = 0;
    Map<String, dynamic>? _index;
    while ((_index = _nextIndex(startIndex)) != null) {
      int i = _index?['index'];
      String sub = widget.data.substring(startIndex, i);
      if (sub.isNotEmpty) {
        _list.add(sub);
      }
      _list.add(_index?['key']);

      startIndex = i + (_index?['key'] as String).length;
    }
  }

  Map<String, dynamic>? _nextIndex(int startIndex) {
    int currentIndex = widget.data.length;
    String? key;
    widget.keys.forEach((element) {
      int index = widget.data.indexOf(element, startIndex);
      if (index != -1 && index < currentIndex) {
        currentIndex = index;
        key = element;
      }
    });
    if (key == null) {
      return null;
    }
    return {'key': '$key', 'index': currentIndex};
  }
}

bool _dialogPrivateShow = false;

showPrivacyDialog(BuildContext context,
    {String? data,
    String userTitle = '《用户协议》',
    String privacyTitle = '《隐私政策》',
    Function()? onUser,
    Function()? onPrivacy,
    Function()? onCancel,
    Function()? onDone}) {
  String _data = "感谢您对本公司的支持!本公司非常重视您的个人信息和隐私保护。" +
      "为了更好地保障您的个人权益，在您使用我们的产品前，" +
      "请务必审慎阅读$userTitle和$privacyTitle内的所有条款，尤其是:\n" +
      " 1.我们对您的个人信息的收集/保存/使用/对外提供/保护等规则条款，以及您的用户权利等条款;\n" +
      " 2. 约定我们的限制责任、免责条款;\n" +
      " 3.其他以颜色或加粗进行标识的重要条款。\n" +
      "如您对以上协议有任何疑问，" +
      "可通过人工客服或发邮件至40286206@qq.com与我们联系。您点击“同意并继续”的行为即表示您已阅读完毕并同意以上协议的全部内容。" +
      "请您仔细阅读并充分理解相关条款，其中重点条款已为您黑体加粗标识，方便您了解自己的权利。如您点击“同意”，即表示您已仔细阅读并同意本$userTitle和$privacyTitle，将尽全力保障您的合法权益并继续为您提供优质的产品和服务。如您点击“不同意”，将可能导致您无法继续使用我们的产品和服务。";

  data = data ?? _data;

  if (_dialogPrivateShow == false) {
    _dialogPrivateShow = true;

    showDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel: '',
        // transitionDuration: Duration(milliseconds: 200),
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: TextView(
              '软件服务协议与隐私政策概述',
              alignment: Alignment.center,
            ),
            content: SingleChildScrollView(
              child: PrivacyView(
                data: data ?? '',
                keys: [userTitle, privacyTitle],
                keyStyle: TextStyle(color: Colors.red),
                onTapCallback: (String key) {
                  if (key == userTitle) {
                    onUser?.call();
                  } else if (key == privacyTitle) {
                    onPrivacy?.call();
                  }
                },
              ),
            ),
            actions: [
              CupertinoActionSheetAction(
                  isDestructiveAction: true,
                  onPressed: () async {
                    onCancel?.call();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    '不同意',
                    style: TextStyle(fontSize: 18),
                  )),
              CupertinoActionSheetAction(
                  onPressed: () async {
                    onDone?.call();
                    Navigator.of(context).pop();
                  },
                  child: Text('确定', style: TextStyle(fontSize: 18)))
            ],
          );
        }).then((value) {
      _dialogPrivateShow = false;
    });
  }
}
