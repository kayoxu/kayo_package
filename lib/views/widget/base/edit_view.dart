import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kayo_package/extension/color_extension.dart';
import 'package:kayo_package/utils/base_color_utils.dart';
import 'package:kayo_package/utils/base_sys_utils.dart';
import 'package:kayo_package/views/widget/base/image_view.dart';

///  kayo_plugin
///  views.widget
///
///  Created by kayoxu on 2019/2/1 1:10 PM.
///  Copyright © 2019 kayoxu. All rights reserved.

class EditView extends StatefulWidget {
  final bool? obscureText;

  final String? text;
  final String? hintText;
  final String? errorText;
  final Color? hintTextColor;
  final double? hintTextSize;

  final Color? textColor;
  final double? textSize;

  final ValueChanged<String>? onChanged;

  final TextStyle? textStyle;

  final TextEditingController? controller;
  final TextInputType? keyboardType;

  final EdgeInsets? margin;
  final EdgeInsets? padding;

  final int? maxLength;

  final String? src;
  final InputBorder? inputBorder;
  final int? maxLines;
  final double? radius;
  final Alignment? alignment;

  final VoidCallback? onClick;

  final bool? showBorder;
  final bool? showLine;
  final Color? lineColor;
  final TextAlign? textAlign;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final bool? useDefaultEditController;
  final bool? editable;
  final bool? showLabelText;
  final bool? isDense;
  final TextInputAction? textInputAction;
  final bool? enableinteractiveSelection;
  final List<TextInputFormatter>? inputFormatters;
  final InputDecoration? inputDecoration;

  EditView({
    Key? key,
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
    this.textInputAction,
    this.isDense = false,
    this.enableinteractiveSelection = true,
    this.inputDecoration,
  }) : super(key: key);

  @override
  EditViewState createState() => EditViewState();
}

class EditViewState extends State<EditView> {
  onClick() {}

  TextEditingController? controllerDefault;

  @override
  void initState() {
    super.initState();
    controllerDefault = widget.controller;
    initController();
  }

  void initController() {
    if (((widget.useDefaultEditController == true) ||
            (true != widget.editable)) &&
        null == controllerDefault) {
      controllerDefault = TextEditingController(text: widget.text ?? '');
      print('flutter TextEditingController initState');
    }
  }

  @override
  void dispose() {
    if (((widget.useDefaultEditController == true) ||
            (true != widget.editable)) &&
        null != controllerDefault) {
      if (widget.controller != controllerDefault) {
        // widget.controller?.dispose();
        try {
          controllerDefault?.dispose();
        } catch (e) {
          print(e);
        }
      }
      controllerDefault = null;
      print('flutter TextEditingController dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // initController();

    return Container(
      alignment: widget.alignment,
      child: Padding(
        padding: widget.margin ?? EdgeInsets.only(left: 0),
        child: Container(
//           height: 1 == widget.maxLines ? 42 : null,
          padding: widget.padding,
          decoration: true == widget.showBorder
              ? BoxDecoration(
                  color: BaseColorUtils.colorWhite.dark,
                  borderRadius: BorderRadius.circular(widget.radius ?? 0),
                  boxShadow: [
                      BoxShadow(
                          color: BaseColorUtils.colorWhiteDark.dark,
                          blurRadius: 2,
                          spreadRadius: .5)
                    ])
              : null,
          child: TextField(
              onTap: null == widget.onClick ? onClick : widget.onClick,
              enableInteractiveSelection: widget.enableinteractiveSelection,
              inputFormatters: widget.inputFormatters,
              style: null == widget.textStyle
                  ? TextStyle(
                      color: widget.textColor.darkNull,
                      fontSize: widget.textSize,
                    )
                  : widget.textStyle,
              autocorrect: false,
              enabled: widget.editable,
              onEditingComplete: widget.onEditingComplete,
              onSubmitted: widget.onSubmitted,
              focusNode: widget.focusNode,
              textAlign: widget.textAlign ?? TextAlign.start,
              maxLength: widget.maxLength,
              maxLengthEnforcement: MaxLengthEnforcement.none,
              maxLines: widget.maxLines,
              textInputAction: widget.textInputAction ?? TextInputAction.done,
              keyboardType: widget.keyboardType,
              controller: controllerDefault,
              onChanged: widget.onChanged,
              obscureText: widget.obscureText ?? false,
              decoration: widget.inputDecoration ??
                  ((widget.showLabelText == true)
                      ? InputDecoration(labelText: widget.hintText)
                      : InputDecoration(
                          // hasFloatingPlaceholder: false,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          isDense: widget.isDense,
                          icon: BaseSysUtils.empty(widget.src)
                              ? null
                              : ImageView(
                                  width: 25,
                                  height: 25,
                                  src: widget.src ?? '',
                                ),
                          hintStyle: TextStyle(
                              color: widget.hintTextColor.darkNull,
                              fontSize: widget.hintTextSize),
                          hintText: widget.hintText,
                          errorText: (widget.errorText?.isEmpty ?? true)
                              ? null
                              : widget.errorText,
                          labelStyle: TextStyle(color: Colors.yellow.dark),
                          enabledBorder: true != widget.showBorder && true == widget.showLine
                              ? UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: widget.lineColor.darkNull ??
                                          BaseColorUtils
                                              .colorGreyLiteLite.dark))
                              : InputBorder.none,
                          focusedBorder: true != widget.showBorder && true == widget.showLine
                              ? UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: widget.lineColor.darkNull ??
                                          BaseColorUtils
                                              .colorGreyLiteLite.dark))
                              : InputBorder.none,
                          border: true != widget.showBorder && true == widget.showLine
                              ? UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: widget.lineColor.darkNull ??
                                          BaseColorUtils.colorGreyLiteLite.dark))
                              : InputBorder.none))),
        ),
      ),
    );
  }
}
