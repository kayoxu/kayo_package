import 'package:flutter/material.dart';
import 'package:kayo_package/utils/base_color_utils.dart';
import 'package:kayo_package/views/widget/base/clickable.dart';
import 'package:kayo_package/views/widget/base/keyboard/cool_ui.dart';
import 'package:kayo_package/views/widget/base/text_view.dart';
import 'package:mpcore/mpkit/mpkit.dart';

import 'keyboard_tools.dart';

class KeyboardNumber extends StatefulWidget {
  static double getHeight(BuildContext ctx) {
    MediaQueryData mediaQuery = MediaQuery.of(ctx);
    return 50 * 4.0 +
        5 * 3 +
        mediaQuery.padding.bottom; //mediaQuery.size.width / 3 / 2 * 5 + 20;
  }

  final KeyboardController? controller;

  const KeyboardNumber({this.controller});

  @override
  KeyboardNumberState createState() => KeyboardNumberState();

  static register() {
    CoolKeyboard.addKeyboard(
        FlutterKeyboard.number,
        KeyboardConfig(
            builder: (context, controller, params) {
              return KeyboardNumber(controller: controller);
            },
            getHeight: KeyboardNumber.getHeight));
  }
}

class KeyboardNumberState extends State<KeyboardNumber> {
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
                      margin: EdgeInsets.only(top: 0),
                      // padding: EdgeInsets.only(left: 4, top: 4, right: 4, bottom: 4),
//            height: KayoKeyboard.getHeight(context),
                      width: mediaQuery.size.width,
                      // decoration: BoxDecoration(
                      //     // color: BaseColorUtils.colorWindow,
                      //     boxShadow: <BoxShadow>[
                      //       BoxShadow(
                      //           color: BaseColorUtils.cardShadow,
                      //           blurRadius: 2.0,
                      //           spreadRadius: 2.0,
                      //           offset: Offset(0, 0)),
                      //     ]),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: abc(),
                              )),
                          SizedBox(width: 5,),
                          Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Clickable(
                                    bgColor: BaseColorUtils.white,
                                    radius: 2,
                                    elevation: 0,
                                    highlightColor: BaseColorUtils.colorGrey
                                        .withOpacity(.1),
                                    shadowColor: BaseColorUtils.colorGrey
                                        .withOpacity(.3),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 105,
                                      child: MPIcon(
                                        MaterialIcons.backspace_outlined,
                                        color: BaseColorUtils.colorBlack,),
                                    ),
                                    onTap: () {
                                      widget.controller?.deleteOne();
                                    },
                                  ),
                                  SizedBox(height: 5,),
                                  Clickable(
                                    bgColor: BaseColorUtils.colorAccent,
                                    radius: 2,
                                    elevation: 0,
                                    highlightColor: BaseColorUtils.colorGrey
                                        .withOpacity(.1),
                                    shadowColor: BaseColorUtils.colorGrey
                                        .withOpacity(.3),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 105,
                                      child: TextView(
                                        '完成', color: BaseColorUtils.colorWhite,
                                        size: 17,
                                        fontWeight: FontWeight.bold,),
                                    ),
                                    onTap: () {
                                      widget.controller?.doneAction();
                                    },
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                    // Positioned(
                    //     top: 0,
                    //     right: 8,
                    //     child: FloatingActionButton(
                    //         mini: true,
                    //         backgroundColor: BaseColorUtils.white,
                    //         child: Icon(
                    //           Icons.keyboard_hide,
                    //           color: BaseColorUtils.colorGrey,
                    //         ),
                    //         onPressed: () {
                    //           widget.controller?.doneAction();
                    //         }))
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
        ],
      ),
      SizedBox(
        height: 5,
      ),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          buildButton('4'),
          SizedBox(
            width: 5,
          ),
          buildButton('5'),
          SizedBox(
            width: 5,
          ),
          buildButton('6'),
        ],
      ),
      SizedBox(
        height: 5,
      ),
      Container(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            buildButton('7'),
            SizedBox(
              width: 5,
            ),
            buildButton('8'),
            SizedBox(
              width: 5,
            ),
            buildButton('9'),
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
          buildButton('0', flex: 2),
          SizedBox(
            width: 5,
          ),
          buildButton('.'),

        ],
      ),
    ];
  }

  Widget buildButton(String title,
      {String? value, int flex = 1, double height = 50}) {
    if (value == null) {
      value = title;
    }

    return Expanded(
        flex: flex,
        child: Clickable(
          bgColor: BaseColorUtils.colorWhite,
          radius: 2,
          elevation: 0,
          margin: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
          child: Container(
            alignment: Alignment.center,
            height: height,
            child: TextView(
              title,
              size: 24,
              fontWeight: FontWeight.w500,
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
