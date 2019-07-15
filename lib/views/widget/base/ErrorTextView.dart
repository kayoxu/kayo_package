import 'package:flutter/material.dart';
import 'package:kayo_package/utils/BaseColorUtils.dart';
 import 'package:kayo_package/views/widget/base/ImageView.dart';

/**
 *  kayo_plugin
 *  views.widget
 *
 *  Created by kayoxu on 2019/1/30 4:43 PM.
 *  Copyright © 2019 kayoxu. All rights reserved.
 */

class ErrorTextView extends StatefulWidget {
  String text;
  bool showIcon;
  bool center;
  double height;
  Color textColor;
  Color bgColor;
  bool visible;
  double radius;

  EdgeInsets margin;

  ErrorTextView(@required this.text,
      {Key key,
      this.showIcon = false,
      this.center = true,
      this.height = 40,
      this.bgColor = BaseColorUtils.colorRedLite,
      this.textColor = BaseColorUtils.colorWhite,
      this.visible = true,
      this.radius = 0,
      this.margin = const EdgeInsets.all(0)})
      : super(key: key);

  @override
  ErrorTextViewState createState() => ErrorTextViewState();
}

class ErrorTextViewState extends State<ErrorTextView> {
  sss() {
    setState(() {
      widget.showIcon = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        maintainState: true,
        visible: widget.visible,
        child: Container(
          margin: widget.margin,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.radius),
              color: widget.bgColor),
          height: widget.height,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: widget.center
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: <Widget>[
              Visibility(
                visible: widget.showIcon ? true : false,
                child: Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: ImageView(
                    src: 'assets/ic_error_warning.svg',
                    width: 25,
                    height: 25,
                    radius: 6,
                    color: BaseColorUtils.colorYellowLite,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Text(
                  widget.text,
                  style: TextStyle(color: widget.textColor, fontSize: 16),
                ),
              )
            ],
          ),
        ));
  }
}
