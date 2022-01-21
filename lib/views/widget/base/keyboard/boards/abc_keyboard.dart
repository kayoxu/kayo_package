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
    return 5 * 3 +
        4 * 35 +
        48 +
        10 +
        mediaQuery.padding.bottom; //mediaQuery.size.width / 3 / 2 * 5 + 20;
  }

  final KeyboardController? controller;

  const KeyboardAbc({this.controller});

  @override
  KeyboardAbcState createState() => KeyboardAbcState();

  static register() {
    CoolKeyboard.addKeyboard(
        FlutterKeyboard.carNum,
        KeyboardConfig(
            builder: (context, controller, params) {
              return KeyboardAbc(controller: controller);
            },
            getHeight: KeyboardAbc.getHeight));
  }
}

class KeyboardAbcState extends State<KeyboardAbc> {
  @override
  void initState() {
    super.initState();
  }

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
        child: Material(
          color: BaseColorUtils.colorWindow,
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
                          EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
//            height: KayoKeyboard.getHeight(context),
                      width: mediaQuery.size.width,
                      // color: BaseColorUtils.colorWindow,
                      // decoration: BoxDecoration(
                      //     color: BaseColorUtils.white,
                      //     boxShadow: <BoxShadow>[
                      //       BoxShadow(
                      //           color: BaseColorUtils.cardShadow,
                      //           blurRadius: 2.0,
                      //           spreadRadius: 2.0,
                      //           offset: Offset(0, 0)),
                      //     ]),
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
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 5, bottom: 5),
                          child: Row(
                            children: [
                              Spacer(),
                              TextView('完成',
                                  color: BaseColorUtils.colorAccent,
                                  fontWeight: FontWeight.bold,
                                  padding: EdgeInsets.only(left: 12, right: 12),
                                  onTap: () {
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
          SizedBox(
            width: 5,
          ),
          buildButton('2'),
          SizedBox(
            width: 5,
          ),
          buildButton('3'),
          SizedBox(
            width: 5,
          ),
          buildButton('4'),
          SizedBox(
            width: 5,
          ),
          buildButton('5'),
          SizedBox(
            width: 5,
          ),
          buildButton('6'),
          SizedBox(
            width: 5,
          ),
          buildButton('7'),
          SizedBox(
            width: 5,
          ),
          buildButton('8'),
          SizedBox(
            width: 5,
          ),
          buildButton('9'),
          SizedBox(
            width: 5,
          ),
          buildButton('0'),
        ],
      ),
      SizedBox(
        height: 5,
      ),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          buildButton('Q'),
          SizedBox(
            width: 5,
          ),
          buildButton('W'),
          SizedBox(
            width: 5,
          ),
          buildButton('E'),
          SizedBox(
            width: 5,
          ),
          buildButton('R'),
          SizedBox(
            width: 5,
          ),
          buildButton('T'),
          SizedBox(
            width: 5,
          ),
          buildButton('Y'),
          SizedBox(
            width: 5,
          ),
          buildButton('U'),
          SizedBox(
            width: 5,
          ),
          buildButton('I', noValue: true),
          SizedBox(
            width: 5,
          ),
          buildButton('O', noValue: true),
          SizedBox(
            width: 5,
          ),
          buildButton('P'),
        ],
      ),
      SizedBox(
        height: 5,
      ),
      Container(
        margin: EdgeInsets.only(left: 18, right: 18),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            buildButton('A'),
            SizedBox(
              width: 5,
            ),
            buildButton('S'),
            SizedBox(
              width: 5,
            ),
            buildButton('D'),
            SizedBox(
              width: 5,
            ),
            buildButton('F'),
            SizedBox(
              width: 5,
            ),
            buildButton('G'),
            SizedBox(
              width: 5,
            ),
            buildButton('H'),
            SizedBox(
              width: 5,
            ),
            buildButton('J'),
            SizedBox(
              width: 5,
            ),
            buildButton('K'),
            SizedBox(
              width: 5,
            ),
            buildButton('L'),
          ],
        ),
      ),
      SizedBox(
        height: 5,
      ),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(
            width: 5,
          ),
          buildButton('Z', flex: 2),
          SizedBox(
            width: 5,
          ),
          buildButton('X', flex: 2),
          SizedBox(
            width: 5,
          ),
          buildButton('C', flex: 2),
          SizedBox(
            width: 5,
          ),
          buildButton('V', flex: 2),
          SizedBox(
            width: 5,
          ),
          buildButton('B', flex: 2),
          SizedBox(
            width: 5,
          ),
          buildButton('N', flex: 2),
          SizedBox(
            width: 5,
          ),
          buildButton('M', flex: 2),
          SizedBox(
            width: 5,
          ),
          Expanded(
              flex: 3,
              child: Clickable(
                bgColor: BaseColorUtils.colorAccent,
                radius: 2,
                elevation: 0,
                highlightColor: BaseColorUtils.colorGrey.withOpacity(.1),
                shadowColor: BaseColorUtils.colorGrey.withOpacity(.3),
                // margin: EdgeInsets.only(left: 2, top: 4, right: 2, bottom: 4),
//            padding: EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 8),
                child: Container(
                  alignment: Alignment.center,
                  height: 35,
                  child: Icon(
                    Icons.backspace_outlined,
                    color: Colors.white,
                  ),
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

  Widget buildButton(String title,
      {String? value, int flex = 1, bool noValue = false}) {
    if (value == null) {
      value = title;
    }

    return Expanded(
        flex: flex,
        child: Clickable(
          bgColor: BaseColorUtils.white,
          radius: 2,
          elevation: 0,
          // margin: EdgeInsets.only(left: 2, top: 4, right: 2, bottom: 4),
          child: Container(
            alignment: Alignment.center,
            height: 35,
            child: TextView(
              title,
              size: 18,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),
          ),
          onTap: noValue == true
              ? null
              : () {
                  badKeyboard = false;
                  setState(() {
                    widget.controller?.addText(value!);
                  });
                },
        ));
  }
}
