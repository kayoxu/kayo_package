import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kayo_package/utils/base_color_utils.dart';
import 'package:kayo_package/utils/base_sys_utils.dart';
import 'package:kayo_package/views/widget/base/image_view.dart';
import 'package:flutter/widgets.dart';
import 'package:mpcore/mpkit/mpkit.dart';

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

  // final InputBorder? inputBorder;
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
  final double? height;
  final double? width;

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
    // this.inputBorder,
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
    this.height,
    this.width,
  }) : super(key: key);

  @override
  EditViewState createState() => EditViewState();
}

class EditViewState extends State<EditView> {
  FocusNode? defaultFocusNode;

  @override
  void initState() {
    super.initState();
    initController();
    if (null == widget.focusNode) {
      defaultFocusNode = FocusNode();
    }
  }

  void initController() {}

  @override
  void dispose() {
    defaultFocusNode?.unfocus();
    defaultFocusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // initController();
    return Container(
//           height: 1 == widget.maxLines ? 42 : null,
//       alignment: widget.alignment,

      margin: widget.margin ?? EdgeInsets.only(left: 0),
      height: widget.height ?? 40,
      width: widget.width ?? double.infinity,
      padding: widget.padding,
      decoration: true == widget.showBorder
          ? BoxDecoration(
          color: BaseColorUtils.colorWhite,
          borderRadius: BorderRadius.circular(widget.radius ?? 0),
          boxShadow: [
            BoxShadow(
                color: BaseColorUtils.colorWhiteDark,
                blurRadius: 2,
                spreadRadius: .5)
          ])
          : null,
      child: MPEditableText(
        // onTap: null == widget.onClick ? onClick : widget.onClick,
        enableInteractiveSelection: widget.enableinteractiveSelection ?? true,
        inputFormatters: widget.inputFormatters,
        style: null == widget.textStyle
            ? TextStyle(
          color: widget.textColor ?? BaseColorUtils.colorBlack,
          fontSize: widget.textSize ?? 14,
        )
            : widget.textStyle!,
        autocorrect: false,
        readOnly: widget.editable == false,
        onEditingComplete: widget.onEditingComplete,
        placeholder: widget.hintText,
        placeholderStyle: TextStyle(
            color: widget.hintTextColor ?? BaseColorUtils.colorBlackLiteLite,
            fontSize: widget.hintTextSize ?? 14),
        onSubmitted: widget.onSubmitted,
        focusNode: widget.focusNode ?? FocusNode(),
        textAlign: widget.textAlign ?? TextAlign.start,
        maxLength: widget.maxLength,
        // maxLengthEnforcement: MaxLengthEnforcement.none,
        maxLines: widget.maxLines ?? 1,
        textInputAction: widget.textInputAction ?? TextInputAction.done,
        keyboardType: widget.keyboardType,
        controller: widget.controller!,
        onChanged: (d){
          widget.onChanged?.call(d);
         },
        obscureText: widget.obscureText ?? false,
        // decoration: (widget.showLabelText == true)
        //     ? InputDecoration(labelText: widget.hintText)
        //     : InputDecoration(
        //         // hasFloatingPlaceholder: false,
        //         floatingLabelBehavior: FloatingLabelBehavior.never,
        //         isDense: widget.isDense,
        //         icon: BaseSysUtils.empty(widget.src)
        //             ? null
        //             : ImageView(
        //                 width: 25,
        //                 height: 25,
        //                 src: widget.src ?? '',
        //               ),
        //         hintStyle: TextStyle(
        //             color: widget.hintTextColor,
        //             fontSize: widget.hintTextSize),
        //         hintText: widget.hintText,
        //         errorText: (widget.errorText?.isEmpty ?? true)
        //             ? null
        //             : widget.errorText,
        //         labelStyle: TextStyle(color: Colors.yellow),
        //         enabledBorder:
        //             true != widget.showBorder && true == widget.showLine
        //                 ? UnderlineInputBorder(
        //                     borderSide: BorderSide(
        //                         color: widget.lineColor ??
        //                             BaseColorUtils.colorGreyLiteLite))
        //                 : InputBorder.none,
        //         focusedBorder:
        //             true != widget.showBorder && true == widget.showLine
        //                 ? UnderlineInputBorder(
        //                     borderSide: BorderSide(
        //                         color: widget.lineColor ??
        //                             BaseColorUtils.colorGreyLiteLite))
        //                 : InputBorder.none,
        //         border:
        //             true != widget.showBorder && true == widget.showLine
        //                 ? UnderlineInputBorder(
        //                     borderSide: BorderSide(
        //                         color: widget.lineColor ??
        //                             BaseColorUtils.colorGreyLiteLite))
        //                 : InputBorder.none)
      ),
    );
  }
}
