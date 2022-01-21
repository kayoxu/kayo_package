import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';
import 'package:kayo_package/utils/base_color_utils.dart';
import 'package:kayo_package/views/widget/base/clickable.dart';
import 'package:kayo_package/views/widget/base/keyboard/boards/keyboard_tools.dart';
import 'package:kayo_package/views/widget/base/text_view.dart';

import '../cool_ui.dart';

class KeyboardAbc extends StatefulWidget {
  static double getHeight(BuildContext ctx) {
    MediaQueryData mediaQuery = MediaQuery.of(ctx);
    return 48.0 + 8 + 8 + 4 * 48; //mediaQuery.size.width / 3 / 2 * 5 + 20;
  }

  final KeyboardController? controller;

  const KeyboardAbc({this.controller});

  @override
  KeyboardAbcState createState() => KeyboardAbcState();

  static register() {
    CoolKeyboard.addKeyboard(
        FlutterKeyboard.abc,
        KeyboardConfig(
            builder: (context, controller, params) {
              return KeyboardAbc(controller: controller);
            },
            getHeight: KeyboardAbc.getHeight));
  }
}


class KeyboardAbcState extends State<KeyboardAbc> {

  @override
  void dispose() {
     super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return SafeArea(
        top: false,
        bottom: false,
        child: Material(
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
                        left: 0,
                        right: 0,
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            children: [
                              Spacer(),
                              FloatingActionButton(
                                  mini: true,
                                  backgroundColor: BaseColorUtils.white,
                                  child: Icon(
                                    Icons.keyboard_hide,
                                    color: BaseColorUtils.colorGrey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      widget.controller?.doneAction();
                                    });
                                  })
                            ],
                          ),
                        )),
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
          buildButton('4'),
          buildButton('5'),
          buildButton('6'),
          buildButton('7'),
          buildButton('8'),
          buildButton('9'),
          buildButton('0'),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          buildButton('Q'),
          buildButton('W'),
          buildButton('E'),
          buildButton('R'),
          buildButton('T'),
          buildButton('Y'),
          buildButton('U'),
          buildButton('I'),
          buildButton('O'),
          buildButton('P'),
        ],
      ),
      Container(
        margin: EdgeInsets.only(left: 8, right: 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            buildButton('A'),
            buildButton('S'),
            buildButton('D'),
            buildButton('F'),
            buildButton('G'),
            buildButton('H'),
            buildButton('J'),
            buildButton('K'),
            buildButton('L'),
          ],
        ),
      ),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          buildButton('Z', flex: 2),
          buildButton('X', flex: 2),
          buildButton('C', flex: 2),
          buildButton('V', flex: 2),
          buildButton('B', flex: 2),
          buildButton('N', flex: 2),
          buildButton('M', flex: 2),
          Expanded(
              flex: 3,
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
                  child: Icon(Icons.backspace),
                ),
                onTap: () {
                  setState(() {
                    widget.controller?.deleteOne();
                  });
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
          margin: EdgeInsets.only(left: 2, top: 4, right: 2, bottom: 4),
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
            setState(() {
              widget.controller?.addText(value!);
            });
          },
        ));
  }
}
