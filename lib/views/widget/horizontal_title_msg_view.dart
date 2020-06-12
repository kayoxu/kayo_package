import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';
import 'package:kayo_package/utils/base_color_utils.dart';
import 'package:kayo_package/views/widget/visible_view.dart';
import 'package:kayo_package/views/widget/base/clickable.dart';
import 'package:kayo_package/views/widget/base/image_view.dart';
import 'package:kayo_package/views/widget/base/text_view.dart';

import 'base/edit_view.dart';

/**
 *  kayo_plugin
 *  views.widget
 *
 *  Created by kayoxu on 2019/2/12 4:31 PM.
 *  Copyright © 2019 kayoxu. All rights reserved.
 */

//enum Visible { visible, invisible, gone }

class HorizontalTitleMsgView extends StatefulWidget {
  EdgeInsets padding;
  EdgeInsets margin;

  String title;
  String msg;
  bool rightIcon;
  Color rightIconColor;
  Visible leftIcon;
  String leftIconSrc;
  double leftIconHeight;
  double leftIconWidth;
  double legtIconRadius;
  String subTitle;

  Color titleColor;
  double titleSize;
  FontWeight titleFontWeight;

  Color msgColor;
  double msgSize;
  FontWeight msgFontWeight;

  String subMsg;
  Color subMsgColor;
  double subMsgSize;
  FontWeight subMsgFontWeight;
  Function subMsgClick;
  double subMsgWidth;

  Color bgColor;
  Color msgBgColor = Colors.transparent;
  bool topLine;
  bool bottomLine;

  EdgeInsets topLineMargin;
  EdgeInsets bottomLineMargin;
  VoidCallback onClick;
  double height;
  double width;
  bool msgEditable;
  String msgHintText;
  TextEditingController msgController;

  Function onMsgClick;
  Function onMsgFocus;
  ValueChanged<String> onMsgChanged;
  FocusNode focusNode;
  VoidCallback onEditingComplete;
  ValueChanged<String> onSubmitted;

  HorizontalTitleMsgView({
    Key key,
    @required this.title,
    this.msg = '',
    this.rightIcon = false,
    this.rightIconColor = BaseColorUtils.colorBlackLite,
    this.padding,
    this.margin,
    this.leftIcon = Visible.gone,
    this.leftIconSrc = 'assets/ic_moren.png',
    this.leftIconHeight = 18,
    this.leftIconWidth = 18,
    this.legtIconRadius = 6,
    this.subTitle,
    this.titleColor = BaseColorUtils.colorGrey,
    this.titleSize = 14,
    this.titleFontWeight,
    this.msgColor = BaseColorUtils.colorGrey,
    this.msgSize = 14,
    this.msgFontWeight,
    this.subMsgColor = BaseColorUtils.colorGrey,
    this.subMsgSize = 14,
    this.subMsgFontWeight,
    this.subMsgClick,
    this.subMsg,
    this.subMsgWidth,
    this.bgColor,
    this.msgBgColor,
    this.topLine = false,
    this.bottomLine = false,
    this.topLineMargin = const EdgeInsets.only(left: 16, right: 16),
    this.bottomLineMargin = const EdgeInsets.only(left: 16, right: 16),
    this.onClick,
    this.height,
    this.width,
    this.msgEditable = false,
    this.msgHintText,
    this.msgController,
    this.onMsgClick,
    this.onMsgFocus,
    this.onMsgChanged,
    this.focusNode,
    this.onEditingComplete,
    this.onSubmitted,
  }) : super(key: key);

  @override
  HorizontalTitleMsgViewState createState() => HorizontalTitleMsgViewState();
}

class HorizontalTitleMsgViewState extends State<HorizontalTitleMsgView> {
  @override
  Widget build(BuildContext context) {
    var column = Column(
      children: <Widget>[
        VisibleView(
          visible: widget.topLine ? Visible.visible : Visible.gone,
          child: Container(
            margin: widget.topLineMargin,
            width: double.infinity,
            height: .5,
            color: BaseColorUtils.colorGreyLiteLiteLite,
          ),
        ),
        Container(
          height: widget.height,
          width: widget.width,
          color: null == widget.onClick ? widget.bgColor : null,
          padding: widget.padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  VisibleView(
                    child: ImageView(
                      src: widget.leftIconSrc,
                      width: widget.leftIconWidth,
                      height: widget.leftIconHeight,
                      radius: widget.legtIconRadius,
                      fit: BoxFit.fitWidth,
                    ),
                    visible: widget.leftIcon,
                  ),
                  TextView(
                    widget.title,
                    margin: widget.leftIcon == Visible.gone
                        ? null
                        : EdgeInsets.only(left: 12, right: 6),
                    fontWeight: widget.titleFontWeight,
                    color: widget.titleColor,
                    size: widget.titleSize,
                  ),
                  Visibility(
                      visible: null != widget.subTitle,
                      child: TextView(
                        widget.subTitle,
                        size: 13,
                        margin: EdgeInsets.all(0),
//                        bgColor: ColorUtils.colorGreen,
                        radius: 6,
                        color: BaseColorUtils.colorGreyLite,
                        padding: EdgeInsets.only(left: 3, right: 3),
                      )),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  VisibleView(
                    child: Clickable(
                      child: TextView(
                        null == widget.subMsg ? 'NULL' : widget.subMsg,
                        bgColor: widget.msgBgColor,
                        maxLine: 5,
                        width: widget.subMsgWidth,
                        textAlign: TextAlign.right,
                        padding: EdgeInsets.only(
                            right: !BaseSysUtils.empty(widget.msg) ? 16 : 0),
                        fontWeight: widget.subMsgFontWeight,
                        color: widget.subMsgColor,
                        size: widget.subMsgSize,
                      ),
                      onTap: widget.subMsgClick,
                    ),
                    visible: BaseSysUtils.empty(widget.subMsg)
                        ? Visible.gone
                        : Visible.visible,
                  ),
                  widget.msgEditable
                      ? Container(
                          child: EditView(
                            text: widget.msg,
                            onEditingComplete: widget.onEditingComplete,
                            onSubmitted: widget.onSubmitted,
                            focusNode: widget.focusNode,
                            onClick: widget.onMsgFocus,
                            hintText: widget.msgHintText,
//                          alignment: Alignment.centerRight,
                            showLine: false,
                            textAlign: TextAlign.right,
                            controller: widget.msgController,
                            margin: EdgeInsets.only(
                                right: widget.rightIcon ? 8 : 0),
                            textColor: widget.msgColor,
                            textSize: widget.msgSize,
                            maxLines: 1,
                            onChanged: widget.onMsgChanged,
                          ),
                          width: 150,
                          alignment: Alignment.centerRight,
                        )
                      : Clickable(
                          child: TextView(
                            null == widget.msg ? '无' : widget.msg,
                            bgColor: widget.msgBgColor,
                            margin: EdgeInsets.only(
                                right: widget.rightIcon ? 8 : 0),
                            fontWeight: widget.msgFontWeight,
                            color: widget.msgColor,
                            size: widget.msgSize,
                          ),
                          onTap: widget.onMsgClick,
                          bgColor: widget.msgBgColor,
                        ),
                  Visibility(
                    child: ImageView(
                      src: 'assets/ic_arrow_right.png',
                      width: 6,
                      height: 11,
                      color: widget.rightIconColor,
                    ),
                    visible: widget.rightIcon,
                  ),
                ],
              ),
            ],
          ),
        ),
        VisibleView(
          visible: widget.bottomLine ? Visible.visible : Visible.gone,
          child: Container(
            margin: widget.bottomLineMargin,
            width: double.infinity,
            height: .5,
            color: BaseColorUtils.colorGreyLiteLiteLite,
          ),
        ),
      ],
    );
    return /*Container(
      margin: widget.margin,
      child: null == widget.onClick
          ? column
          : Material(
              color: widget.bgColor,
              child: InkWell(
//              color: ColorUtils.white,
                  onTap: widget.onClick,
//              padding: EdgeInsets.all(0),
                  child: column),
            ),
    );*/
        Clickable(
      bgColor: widget.bgColor,
      margin: widget.margin,
      child: column,
      onTap: widget.onClick,
    );
  }
}
