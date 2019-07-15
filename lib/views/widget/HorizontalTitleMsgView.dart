import 'package:flutter/material.dart';
import 'package:kayo_package/utils/BaseColorUtils.dart';
 import 'package:kayo_package/views/widget/VisibleView.dart';
import 'package:kayo_package/views/widget/base/Clickable.dart';
import 'package:kayo_package/views/widget/base/ImageView.dart';
import 'package:kayo_package/views/widget/base/TextView.dart';

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
  Visible leftIcon;
  String leftIconSrc;
  String subTitle;

  Color titleColor;
  double titleSize;
  FontWeight titleFontWeight;

  Color msgColor;
  double msgSize;
  FontWeight msgFontWeight;

  Color bgColor;
  bool topLine;
  bool bottomLine;

  EdgeInsets topLineMargin;
  EdgeInsets bottomLineMargin;
  VoidCallback onClick;
  double height;
  double width;

  HorizontalTitleMsgView({
    Key key,
    @required this.title,
    this.msg = '',
    this.rightIcon = false,
    this.padding,
    this.margin,
    this.leftIcon = Visible.gone,
    this.leftIconSrc = 'assets/ic_mine_time.png',
    this.subTitle,
    this.titleColor = BaseColorUtils.colorGrey,
    this.titleSize = 14,
    this.titleFontWeight,
    this.msgColor = BaseColorUtils.colorGrey,
    this.msgSize = 14,
    this.msgFontWeight,
    this.bgColor,
    this.topLine = false,
    this.bottomLine = false,
    this.topLineMargin = const EdgeInsets.only(left: 48, right: 14),
    this.bottomLineMargin = const EdgeInsets.only(left: 48, right: 14),
    this.onClick,
    this.height,
    this.width,
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
                      width: 18,
                      height: 22,
                      radius: 6,
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
                children: <Widget>[
                  TextView(
                   null == widget.msg?'无':widget.msg,
                    margin: EdgeInsets.only(right: widget.rightIcon ? 8 : 0),
                    fontWeight: widget.msgFontWeight,
                    color: widget.msgColor,
                    size: widget.msgSize,
                  ),
                  Visibility(
                    child: ImageView(
                      src: 'assets/ic_arrow_right.png',
                      width: 6,
                      height: 11,
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
