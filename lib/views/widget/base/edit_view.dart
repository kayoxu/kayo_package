import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kayo_package/utils/base_color_utils.dart';
import 'package:kayo_package/utils/base_sys_utils.dart';
import 'package:kayo_package/views/widget/base/image_view.dart';

/**
 *  kayo_plugin
 *  views.widget
 *
 *  Created by kayoxu on 2019/2/1 1:10 PM.
 *  Copyright © 2019 kayoxu. All rights reserved.
 */

class EditView extends StatefulWidget {
  bool obscureText;

  String text;
  String hintText;
  String errorText;
  Color hintTextColor;
  double hintTextSize;

  Color textColor;
  double textSize;

  ValueChanged<String> onChanged;

  TextStyle textStyle;

  TextEditingController controller;
  TextInputType keyboardType;

  EdgeInsets margin;
  EdgeInsets padding;

  int maxLength;

  String src;
  InputBorder inputBorder;
  int maxLines;
  double radius;
  Alignment alignment;

  VoidCallback onClick;

  bool showBorder;
  bool showLine;
  Color lineColor;
  TextAlign textAlign;
  FocusNode focusNode;
  VoidCallback onEditingComplete;
  ValueChanged<String> onSubmitted;
  bool useDefaultEditController;
  bool editable;
  bool showLabelText;
  List<TextInputFormatter> inputFormatters;

  EditView({
    Key key,
    this.text,
    this.hintText,
    this.errorText,
    this.textColor = BaseColorUtils.colorBlack,
    this.hintTextColor = BaseColorUtils.colorGreyLiteLite,
    this.textSize = 14,
    this.hintTextSize = 14,
    this.onChanged,
    this.textStyle,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.emailAddress,
    this.src,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.inputBorder,
    this.maxLines = 1,
    this.radius = 3,
    this.alignment = Alignment.centerLeft,
    this.maxLength,
    this.onClick,
    this.showBorder = false,
    this.showLine = true,
    this.textAlign = TextAlign.left,
    this.focusNode,
    this.onEditingComplete,
    this.onSubmitted,
    this.useDefaultEditController = false,
    this.editable = true,
    this.showLabelText = false,
    this.inputFormatters,
    this.lineColor,
  }) : super(key: key);

  @override
  EditViewState createState() => EditViewState();
}

class EditViewState extends State<EditView> {
  onClick() {}

  @override
  void initState() {
    super.initState();
    initController();
  }

  void initController() {
    if ((widget.useDefaultEditController || !widget.editable) &&
        null == widget.controller) {
      widget.controller = TextEditingController(text: widget.text ?? '');
      print('flutter TextEditingController initState');
    }
  }

  @override
  void dispose() {
    if ((widget.useDefaultEditController || !widget.editable) &&
        null != widget.controller) {
      widget.controller.dispose();
      widget.controller = null;
      print('flutter TextEditingController dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initController();

    return Container(
      alignment: widget.alignment,
      child: Padding(
        padding: widget.margin,
        child: Container(
//           height: 1 == widget.maxLines ? 42 : null,
          padding: widget.padding,
          decoration: true == widget.showBorder
              ? BoxDecoration(
                  color: BaseColorUtils.colorWhite,
                  borderRadius: BorderRadius.circular(widget.radius),
                  boxShadow: [
                      BoxShadow(
                          color: BaseColorUtils.colorWhiteDark,
                          blurRadius: 2,
                          spreadRadius: .5)
                    ])
              : null,
          child: TextField(
              onTap: null == widget.onClick ? onClick : widget.onClick,
              inputFormatters: widget.inputFormatters,
              style: null == widget.textStyle
                  ? TextStyle(
                      color: widget.textColor,
                      fontSize: widget.textSize,
                    )
                  : widget.textStyle,
              autocorrect: false,
              enabled: widget.editable,
              onEditingComplete: widget.onEditingComplete,
              onSubmitted: widget.onSubmitted,
              focusNode: widget.focusNode,
              textAlign: widget.textAlign,
              maxLength: widget.maxLength,
              maxLengthEnforced: false,
              maxLines: widget.maxLines,
              textInputAction: TextInputAction.done,
              keyboardType: widget.keyboardType,
              controller: widget.controller,
              onChanged: widget.onChanged,
              obscureText: widget.obscureText,
              decoration: widget.showLabelText
                  ? InputDecoration(labelText: widget.hintText)
                  : InputDecoration(
                      hasFloatingPlaceholder: false,
                      icon: BaseSysUtils.empty(widget.src)
                          ? null
                          : ImageView(
                              width: 25,
                              height: 25,
                              src: widget.src,
                            ),
                      hintStyle: TextStyle(
                          color: widget.hintTextColor,
                          fontSize: widget.hintTextSize),
                      hintText: widget.hintText,
                      errorText: (widget.errorText?.isEmpty ?? true)
                          ? null
                          : widget.errorText,
                      labelStyle: TextStyle(color: Colors.yellow),
                      enabledBorder:
                          true != widget.showBorder && true == widget.showLine
                              ? UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: widget.lineColor ??
                                          BaseColorUtils.colorGreyLiteLite))
                              : InputBorder.none,
                      focusedBorder:
                          true != widget.showBorder && true == widget.showLine
                              ? UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: widget.lineColor ??
                                          BaseColorUtils.colorGreyLiteLite))
                              : InputBorder.none,
                      border:
                          true != widget.showBorder && true == widget.showLine
                              ? UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: widget.lineColor ??
                                          BaseColorUtils.colorGreyLiteLite))
                              : InputBorder.none)),
        ),
      ),
    );
  }
}
