import 'package:flutter/material.dart';
import 'package:kayo_package/utils/base_color_utils.dart';
import 'package:kayo_package/views/widget/base/image_view.dart';
import 'package:kayo_package/views/widget/visible_view.dart';

///  kayo_plugin
///  views.widget
///
///  Created by kayoxu on 2019/1/30 4:43 PM.
///  Copyright © 2019 kayoxu. All rights reserved.

class ErrorTextView extends StatefulWidget {
  final String? text;
  final bool? center;
  final double? height;
  final Color? textColor;
  final Color? bgColor;
  final bool? visible;
  final double? radius;

  final EdgeInsets? margin;

  ErrorTextView(this.text,
      {Key? key,
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
  bool? showIcon = false;

  sss() {
    setState(() {
      showIcon = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return VisibleView(
        // maintainState: true,
        visible: (widget.visible ?? false) ? Visible.visible : Visible.gone,
        child: Container(
          margin: widget.margin,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.radius ?? 0),
              color: widget.bgColor),
          height: widget.height,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: (widget.center ?? false)
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: <Widget>[
              VisibleView(
                visible: (showIcon ?? false) ? Visible.visible : Visible.gone,
                child: Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: ImageView(
                    src: source('ic_error_warning', suffix: 'svg'),
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
                  widget.text ?? '',
                  style: TextStyle(color: widget.textColor, fontSize: 16),
                ),
              )
            ],
          ),
        ));
  }
}
