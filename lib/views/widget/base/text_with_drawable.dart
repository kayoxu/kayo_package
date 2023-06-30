import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kayo_package/views/widget/base/edit_view.dart';
import 'package:kayo_package/views/widget/visible_view.dart';
import 'package:mpcore/mpkit/mpkit.dart';

@Deprecated('Use `Other` widget instead')
class TextWithDrawable extends StatelessWidget {
  final String text;
  final Color fontColor;
  final double fontSize;
  final FontWeight fontWeight;
  final Widget? drawableStart;
  final Widget? drawableTop;
  final Widget? drawableEnd;
  final Widget? drawableBottom;
  final double? drawableStartPadding;
  final double? drawableTopPadding;
  final double? drawableEndPadding;
  final double? drawableBottomPadding;
  final double drawablePadding;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Decoration? decoration;
  final int maxLines;
  final bool isFill;
  final TextAlign? textAlign;

  TextWithDrawable({
    this.text = '',
    this.fontColor = const Color(0xff666666),
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.drawableStart,
    this.drawableTop,
    this.drawableEnd,
    this.drawableBottom,
    this.drawableStartPadding,
    this.drawableTopPadding,
    this.drawableEndPadding,
    this.drawableBottomPadding,
    this.drawablePadding = 0,
    this.padding,
    this.margin,
    this.decoration,
    this.maxLines = 1,
    this.isFill = false,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    bool onlyRow = (null != drawableStart || null != drawableEnd) &&
        (null == drawableTop && null == drawableBottom);
    bool onlyColumn = (null != drawableTop || null != drawableBottom) &&
        (null == drawableStart && null == drawableEnd);
    Widget txt = Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: fontColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
    Widget onlyRowWidget = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        if (null != drawableStart) drawableStart!,
        SizedBox(
            width: null == drawableStartPadding
                ? drawablePadding
                : drawableStartPadding),
        isFill ? Expanded(child: txt) : txt,
        SizedBox(
            width: null == drawableEndPadding
                ? drawablePadding
                : drawableEndPadding),
        if (null != drawableEnd) drawableEnd!,
      ],
    );
    Widget onlyColumnWidget = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        if (null != drawableTop) drawableTop!,
        SizedBox(
            height: null == drawableTopPadding
                ? drawablePadding
                : drawableTopPadding),
        isFill ? Expanded(child: txt) : txt,
        SizedBox(
            height: null == drawableBottomPadding
                ? drawablePadding
                : drawableBottomPadding),
        if (null != drawableBottom) drawableBottom!,
      ],
    );
    Widget child;
    if (onlyRow) {
      child = onlyRowWidget;
    } else if (onlyColumn) {
      child = onlyColumnWidget;
    } else {
      child = onlyRowWidget;
    }
    return Container(
      width: isFill && onlyRow ? double.infinity : null,
      height: isFill && onlyColumn ? double.infinity : null,
      padding: padding,
      margin: margin,
      decoration: decoration,
      child: child,
    );
  }
}

@Deprecated('Use `Other` widget instead')
class ShowInfoRow extends StatelessWidget {
  final String? left;
  final Widget? leftWidget;
  final String? right;
  final Widget? rightWidget;
  final int leftFlex;
  final int rightFlex;
  final int maxLines;
  final Color bgColor;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color leftColor;
  final Color rightColor;
  final double leftFontSize;
  final double rightFontSize;
  final FontWeight leftFontWeight;
  final FontWeight rightFontWeight;
  final GestureTapCallback? onTap;

  ShowInfoRow({
    this.left,
    this.leftWidget,
    this.right,
    this.rightWidget,
    this.leftFlex = 1,
    this.maxLines = 1,
    this.rightFlex = 2,
    this.bgColor = Colors.transparent,
    this.borderRadius,
    this.padding,
    this.margin,
    this.leftColor = const Color(0xff333333),
    this.rightColor = const Color(0xff666666),
    this.leftFontSize = 14,
    this.rightFontSize = 14,
    this.leftFontWeight = FontWeight.w600,
    this.rightFontWeight = FontWeight.normal,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget view = Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: borderRadius,
      ),
      child: Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: leftFlex,
            child: leftWidget ??
                Text(
                  left ?? '',
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: leftColor,
                    fontSize: leftFontSize,
                    fontWeight: leftFontWeight,
                  ),
                ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: rightFlex,
            child: rightWidget ??
                Text(
                  right ?? '',
                  textAlign: TextAlign.end,
                  maxLines: maxLines,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: rightColor,
                    fontSize: rightFontSize,
                    fontWeight: rightFontWeight,
                  ),
                ),
          ),
        ],
      ),
    );
    Widget child;
    if (null == onTap) {
      child = view;
    } else {
      child = GestureDetector(
        onTap: onTap,
        child: view,
      );
    }
    return child;
  }
}

@Deprecated('Use `Other` widget instead')
class TextWithBg extends StatelessWidget {
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final String text;
  final double fontSize;
  final Color? fontColor;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final String? bgImg;
  final Color? bgColor;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;
  final BoxShape shape;
  final Gradient? gradient;
  final int maxLines;

  TextWithBg({
    this.width,
    this.height,
    this.alignment,
    this.padding,
    this.margin,
    this.text = "",
    this.fontSize = 14,
    this.fontColor,
    this.fontWeight,
    this.textAlign,
    this.bgImg,
    this.bgColor,
    this.border,
    this.borderRadius,
    this.boxShadow,
    this.shape = BoxShape.rectangle,
    this.gradient,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: alignment,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        image: null == bgImg
            ? null
            : DecorationImage(image: AssetImage(bgImg!), fit: BoxFit.cover),
        color: bgColor,
        border: border,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
        shape: shape,
        gradient: gradient,
      ),
      child: Text(
        text,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: fontSize,
          color: fontColor,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}

@Deprecated('Use `Other` widget instead')
class IncludeWidget {
  ///横向、纵向分割线
  /// [Line]
  @Deprecated('Use `Other` widget instead')
  static Widget line({
    Color color = const Color(0xFFF4F4F4),
    bool isHor = true,
    double? width,
    double? height,
    EdgeInsets? margin,
  }) {
    double w;
    double h;
    if (isHor) {
      w = null == width ? double.infinity : width;
      h = null == height ? 1 : height;
    } else {
      w = null == width ? 1 : width;
      h = null == height ? double.infinity : height;
    }
    return Container(
      width: w,
      height: h,
      margin: margin,
      color: color,
    );
  }

  ///带背景的文字
  ///图层从上到下:bgImg>gradient>bgColor
  ///设置了shape: BoxShape.circle，则不能再设置borderRadius
  ///border: Border.all(color: Colors.black, width: 2)
  ///borderRadius: BorderRadius.all(Radius.circular(5))
  ///shape: BoxShape.circle
  ///阴影位置由offset决定,阴影模糊层度由blurRadius大小决定（大就更透明更扩散），阴影模糊大小由spreadRadius决定
  ///boxShadow: [BoxShadow(color: Colors.green,offset: Offset(5, 5),blurRadius: 10,spreadRadius: 5,)]
  ///环形渲染:RadialGradient，扫描式渐变:SweepGradient，线性渐变:LinearGradient
  ///gradient: LinearGradient(colors: [Colors.red, Colors.blue], begin: Alignment.topLeft, end: Alignment.bottomRight),
  /// [TextWithBg]
  @Deprecated('Use `Other` widget instead')
  static Widget textWithBg({
    double? width,
    double? height,
    AlignmentGeometry alignment = Alignment.center,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    String text = "",
    double fontSize = 14,
    Color? fontColor,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.center,
    String? bgImg,
    Color? bgColor,
    BoxBorder? border,
    BorderRadiusGeometry? borderRadius,
    List<BoxShadow>? boxShadow,
    BoxShape shape = BoxShape.rectangle,
    Gradient? gradient,
  }) {
    return UnconstrainedBox(
      child: Container(
        width: width,
        height: height,
        alignment: alignment,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          image: null == bgImg
              ? null
              : DecorationImage(image: AssetImage(bgImg), fit: BoxFit.cover),
          color: bgColor,
          border: border,
          borderRadius: borderRadius,
          boxShadow: boxShadow,
          shape: shape,
          gradient: gradient,
        ),
        child: Text(
          text,
          textAlign: textAlign,
          style: TextStyle(
            fontSize: fontSize,
            color: fontColor,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }

  ///通用的左右布局信息展示
  /// [ShowInfoRow]
  @Deprecated('Use `Other` widget instead')
  static Widget showInfoKeyValue({
    String? key,
    String? value,
    int keyFlex = 1,
    int valueFlex = 2,
    Color bgColor = Colors.transparent,
    EdgeInsetsGeometry padding = const EdgeInsets.only(top: 20, bottom: 20),
    EdgeInsetsGeometry? margin,
    Color keyColor = const Color(0xff333333),
    Color valueColor = const Color(0xff666666),
    double fontSize = 14,
    FontWeight keyFontWeight = FontWeight.w600,
    FontWeight valueFontWeight = FontWeight.normal,
  }) {
    return Container(
      color: bgColor,
      padding: padding,
      margin: margin,
      child: Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: keyFlex,
            child: Text(
              key ?? '',
              textAlign: TextAlign.start,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: keyColor,
                fontSize: fontSize,
                fontWeight: keyFontWeight,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: valueFlex,
            child: Text(
              value ?? '',
              textAlign: TextAlign.end,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: valueColor,
                fontSize: fontSize,
                fontWeight: valueFontWeight,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///通用的左右布局信息输入、选择
  /// [InputInfoRow]
  @Deprecated('Use `Other` widget instead')
  static Widget inputKeyValue({
    String? key,
    String? value,
    String? hintText,
    String? unit,
    TextInputType? inputType,
    TextEditingController? controller,
    int keyFlex = 1,
    int valueFlex = 2,
    Color bgColor = Colors.transparent,
    EdgeInsetsGeometry? margin,
    Color keyColor = const Color(0xff333333),
    Color valueColor = const Color(0xff666666),
    Color hintColor = const Color(0xff999999),
    double fontSize = 14,
    FontWeight keyFontWeight = FontWeight.w600,
    bool showArrowRight = false,
    GestureTapCallback? onTap,
    EdgeInsetsGeometry contentPadding =
        const EdgeInsets.only(left: 10, top: 20, bottom: 20),
  }) {
    controller = controller ?? TextEditingController();
    if (null != value) {
      controller.value = controller.value.copyWith(
        text: value,
        selection: TextSelection.fromPosition(
          TextPosition(
            affinity: TextAffinity.downstream,
            offset: value.length,
          ),
        ),
      );
    }
    bool readOnly = null != onTap;
    Pattern? reg;
    if (inputType == TextInputType.number || inputType == TextInputType.phone) {
      reg = RegExp('[0-9.]');
    }
    EditView textField = EditView(
      controller: controller,
      textAlign: TextAlign.end,
      keyboardType: inputType,
      maxLines: 1,
      editable: readOnly != true,
      inputFormatters: [
        if (null != reg) FilteringTextInputFormatter.allow(reg),
      ],

      textStyle: TextStyle(
        color: valueColor,
        fontSize: fontSize,
      ),
    );
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: bgColor,
        margin: margin,
        child: Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: keyFlex,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  key ?? '',
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: keyColor,
                    fontSize: fontSize,
                    fontWeight: keyFontWeight,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: valueFlex,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    //IgnorePointer
                    child:
                        readOnly ? IgnorePointer(child: textField) : textField,
                  ),
                  SizedBox(width: 10),
                  VisibleView(
                    visible: showArrowRight ? Visible.visible : Visible.gone,
                    child: MPIcon(
                      MaterialIcons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

@Deprecated('Use `Other` widget instead')
class InputInfoRow extends StatelessWidget {
  final String? left;
  final String? right;
  final String? hintText;
  final String? unit;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final int leftFlex;
  final int rightFlex;
  final Color bgColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color leftColor;
  final Color rightColor;
  final Color hintColor;
  final double fontSize;
  final FontWeight leftFontWeight;
  final bool showArrowRight;
  final GestureTapCallback? onTap;
  final EdgeInsetsGeometry contentPadding;
  final bool required;
  final ValueChanged<String>? onChange;
  final String? regStr;

  ///输入内容最大长度
  final int? maxLength;

  InputInfoRow({
    this.left,
    this.right,
    this.hintText,
    this.unit,
    this.inputType,
    this.controller,
    this.leftFlex = 1,
    this.rightFlex = 2,
    this.bgColor = Colors.transparent,
    this.padding,
    this.margin,
    this.leftColor = const Color(0xff333333),
    this.rightColor = const Color(0xff666666),
    this.hintColor = const Color(0xff999999),
    this.fontSize = 14,
    this.leftFontWeight = FontWeight.w600,
    this.showArrowRight = false,
    this.onTap,
    this.contentPadding = const EdgeInsets.only(left: 10, top: 20, bottom: 20),
    this.required = false,
    this.onChange,
    this.regStr,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController editingController =
        controller ?? TextEditingController();
    if (null != right) {
      editingController.value = editingController.value.copyWith(
        text: right,
        selection: TextSelection.fromPosition(
          TextPosition(
            affinity: TextAffinity.downstream,
            offset: right!.length,
          ),
        ),
      );
    }
    bool readOnly = null != onTap;
    EditView textField = EditView(
      controller: editingController,
      textAlign: TextAlign.end,
      keyboardType: inputType,
      maxLines: 1,
      editable: readOnly != true,
      inputFormatters: [
        if (null != maxLength) LengthLimitingTextInputFormatter(maxLength),
        if (null != regStr) FilteringTextInputFormatter.allow(RegExp(regStr!)),
      ],
      // decoration: InputDecoration(
      //   hintText: hintText,
      //   hintStyle: TextStyle(
      //     color: hintColor,
      //     fontSize: fontSize,
      //   ),
      //   contentPadding: contentPadding,
      //   border: InputBorder.none,
      //   suffixText: unit,
      //   suffixStyle: TextStyle(
      //     color: rightColor,
      //     fontSize: fontSize,
      //   ),
      // ),
      textStyle: TextStyle(
        color: rightColor,
        fontSize: fontSize,
      ),
      onChanged: onChange,
    );
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: bgColor,
        margin: margin,
        padding: padding,
        child: Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: leftFlex,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    Text(
                      left ?? '',
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: leftColor,
                        fontSize: fontSize,
                        fontWeight: leftFontWeight,
                      ),
                    ),
                    VisibleView(
                      visible: required ? Visible.visible : Visible.gone,
                      child: Text(
                        '*',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: rightFlex,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    //IgnorePointer
                    child:
                        readOnly ? IgnorePointer(child: textField) : textField,
                  ),
                  SizedBox(width: 10),
                  VisibleView(
                    visible: showArrowRight ? Visible.visible : Visible.gone,
                    child: MPIcon(
                      MaterialIcons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
