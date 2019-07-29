import 'package:flutter/material.dart';
import 'package:kayo_package/utils/base_color_utils.dart';
import 'package:kayo_package/views/widget/base/clickable.dart';
import 'package:kayo_package/views/widget/base/text_view.dart';
import 'package:kayo_package/views/widget/base/keyboard/utils/keyboard_controller.dart';

enum KayoInputType { carNo, carNoAbc, cardId }

class Keyboard extends StatefulWidget {
  final KeyboardController controller;
  static KayoInputType kayoInputType = KayoInputType.carNo;

  Keyboard({this.controller});

  @override
  KeyboardState createState() => KeyboardState();
}

class KeyboardState extends State<Keyboard> {
  change(tyep) {
    setState(() {
      Keyboard.kayoInputType = tyep;
    });
  }

  @override
  void dispose() {
    Keyboard.kayoInputType = KayoInputType.carNo;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getView() {
      if (Keyboard.kayoInputType == KayoInputType.carNo) {
        return carno();
      } else if (Keyboard.kayoInputType == KayoInputType.carNoAbc) {
        return abc();
      } else if (Keyboard.kayoInputType == KayoInputType.cardId) {
        return abc1();
      }
    }

    MediaQueryData mediaQuery = MediaQuery.of(context);
    return SafeArea(
        child: Material(
      color: BaseColorUtils.transparent,
      child: DefaultTextStyle(
          style: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black, fontSize: 23.0),
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 48),
                padding: EdgeInsets.only(left: 4, top: 4, right: 4, bottom: 4),
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
                  children: getView(),
                ),
              ),
              Positioned(
                  top: 0,
                  right: 8,
                  child: FloatingActionButton(
                      mini: true,
                      backgroundColor: BaseColorUtils.white,
                      child: Icon(
                        Icons.keyboard_hide,
                        color: BaseColorUtils.colorGrey,
                      ),
                      onPressed: () {
                        widget.controller.doneAction();
                      }))
            ],
          )),
    ));
  }

  List<Widget> carno() {
    return <Widget>[
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          buildButton('京'),
          buildButton('津'),
          buildButton('渝'),
          buildButton('沪'),
          buildButton('冀'),
          buildButton('晋'),
          buildButton('辽'),
          buildButton('吉'),
          buildButton('黑'),
          buildButton('苏'),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          buildButton('浙'),
          buildButton('皖'),
          buildButton('闽'),
          buildButton('赣'),
          buildButton('鲁'),
          buildButton('豫'),
          buildButton('鄂'),
          buildButton('湘'),
          buildButton('粤'),
          buildButton('琼'),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          buildButton('川'),
          buildButton('贵'),
          buildButton('云'),
          buildButton('陕'),
          buildButton('甘'),
          buildButton('青'),
          buildButton('蒙'),
          buildButton('桂'),
          buildButton('宁'),
          buildButton('新'),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
              flex: 3,
              child: Clickable(
                  bgColor: BaseColorUtils.colorGreyLiteLite,
                  radius: 6,
                  elevation: 5,
                  highlightColor: BaseColorUtils.colorGrey.withOpacity(.1),
                  shadowColor: BaseColorUtils.colorGrey.withOpacity(.3),
                  margin: EdgeInsets.only(left: 2, top: 4, right: 2, bottom: 4),
//              padding: EdgeInsets.only(left: 4, top: 4, right: 4, bottom: 4),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: TextView(
                      'ABC',
                      size: 23,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: () {
                    change(KayoInputType.carNoAbc);
                  })),
          buildButton('藏', flex: 2),
          buildButton('使', flex: 2),
          buildButton('领', flex: 2),
          buildButton('警', flex: 2),
          buildButton('学', flex: 2),
          buildButton('港', flex: 2),
          buildButton('澳', flex: 2),
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
                  height: 50,
                  child: Icon(Icons.backspace),
                ),
                onTap: () {
                  widget.controller.deleteOne();
                },
              ))
        ],
      ),
    ];
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
          Expanded(
              flex: 3,
              child: Clickable(
                  bgColor: BaseColorUtils.colorGreyLiteLite,
                  radius: 6,
                  elevation: 5,
                  highlightColor: BaseColorUtils.colorGrey.withOpacity(.1),
                  shadowColor: BaseColorUtils.colorGrey.withOpacity(.3),
                  margin: EdgeInsets.only(left: 2, top: 4, right: 2, bottom: 4),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: TextView(
                      '返回',
                      size: 23,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: () {
                    change(KayoInputType.carNo);
                  })),
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
                  height: 50,
                  child: Icon(Icons.backspace),
                ),
                onTap: () {
                  widget.controller.deleteOne();
                },
              ))
        ],
      ),
    ];
  }

  List<Widget> abc1() {
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
        margin: EdgeInsets.only(left: 8, right: 8),
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
          buildButton('X'),
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
              height: 50,
              child: Icon(Icons.backspace),
            ),
            onTap: () {
              widget.controller.deleteOne();
            },
          ))
        ],
      ),
    ];
  }

  Widget buildButton(String title, {String value, int flex = 1}) {
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
            height: 50,
            child: TextView(
              title,
              size: 23,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),
          ),
          onTap: () {
            widget.controller.addText(value);
          },
        ));
  }
}
