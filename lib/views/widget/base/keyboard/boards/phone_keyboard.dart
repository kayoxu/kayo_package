import 'package:flutter/material.dart';
import 'package:kayo_package/utils/base_color_utils.dart';
import 'package:kayo_package/views/widget/base/clickable.dart';
import 'package:kayo_package/views/widget/base/keyboard/cool_ui.dart';
import 'package:kayo_package/views/widget/base/text_view.dart';
import 'package:mpcore/mpkit/mpkit.dart';
import 'keyboard_tools.dart';

class KeyboardPhone extends StatefulWidget {
  static double getHeight(BuildContext ctx) {
    MediaQueryData mediaQuery = MediaQuery.of(ctx);
    return 48.0 + 8 + 8 + 4 * 48;
    /* mediaQuery.size.width / 3 / 2 * 4*/
    ;
  }

  final KeyboardController? controller;

  const KeyboardPhone({this.controller});

  @override
  KeyboardPhoneState createState() => KeyboardPhoneState();

  static register() {
    CoolKeyboard.addKeyboard(
        FlutterKeyboard.phone,
        KeyboardConfig(
            builder: (context, controller, params) {
              return KeyboardPhone(controller: controller);
            },
            getHeight: KeyboardPhone.getHeight));
  }
}

class KeyboardPhoneState extends State<KeyboardPhone> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return SafeArea(
        top: false,
        bottom: true,
        child: Container(
          color: BaseColorUtils.transparent,
          child: DefaultTextStyle(
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 23.0),
              child: SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 48),
                      padding:
                          EdgeInsets.only(left: 4, top: 4, right: 4, bottom: 4),
//            height: KayoKeyboard.getHeight(context),
                      width: mediaQuery.size.width,
                      decoration: BoxDecoration(
                          color: BaseColorUtils.white,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: BaseColorUtils.cardShadow,
                                blurRadius: 2.0,
                                spreadRadius: 2.0,
                                offset: Offset(0, 0)),
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: abc(),
                      ),
                    ),
                    Positioned(
                        top: 0,
                        right: 8,
                        child: GestureDetector(
                            // mini: true,
                            // backgroundColor: BaseColorUtils.white,
                            child: MPIcon(
                              MaterialIcons.keyboard_hide,
                              color: BaseColorUtils.colorGrey,
                            ),
                            onTap: () {
                              widget.controller?.doneAction();
                            }))
                  ],
                ),
              )),
        ));
  }

  List<Widget> abc() {
    return <Widget>[
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          buildButton('1'),
          buildButton('2'),
          buildButton('3'),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          buildButton('4'),
          buildButton('5'),
          buildButton('6'),
        ],
      ),
      Container(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            buildButton('7'),
            buildButton('8'),
            buildButton('9'),
          ],
        ),
      ),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          buildButton('+'),
          buildButton('0'),
          Expanded(
              child: Clickable(
            bgColor: BaseColorUtils.colorGreyLiteLite,
            radius: 6,
            elevation: 5,
            highlightColor: BaseColorUtils.colorGrey.withOpacity(.1),
            shadowColor: BaseColorUtils.colorGrey.withOpacity(.3),
            margin: EdgeInsets.only(left: 2, top: 4, right: 2, bottom: 4),
//            padding: EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 8),
            child: Container(
              alignment: Alignment.center,
              height: 40,
              child: MPIcon(
                  MaterialIcons.backspace),
            ),
            onTap: () {
              widget.controller?.deleteOne();
            },
          ))
        ],
      ),
    ];
  }

  Widget buildButton(String title, {String? value, int flex = 1}) {
    if (value == null) {
      value = title;
    }

    return Expanded(
        flex: flex,
        child: Clickable(
          bgColor: BaseColorUtils.white,
          radius: 6,
          elevation: 5,
          margin: EdgeInsets.only(left: 2, top: 5, right: 2, bottom: 5),
          child: Container(
            alignment: Alignment.center,
            height: 40,
            child: TextView(
              title,
              size: 23,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),
          ),
          onTap: () {
            badKeyboard = false;
            widget.controller?.addText(value!);
          },
        ));
  }
}
