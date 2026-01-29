import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';

extension BaseWidgetExtension on Widget? {
  /// Control visibility (visible, invisible, gone)
  Widget setVisible({Key? key, required Visible? visible}) {
    if (null != this) {
      var v = visible ?? Visible.visible;
      return Visibility(
              key: key,
              visible: v != Visible.gone,
              child: v != Visible.invisible
                  ? this!
                  : Opacity(
                      opacity: v == Visible.visible ? 1.0 : 0.0, child: this!))
          .addIgnorePointer(ignoring: v == Visible.invisible);
    }
    return SizedBox();
  }

  /// Control visibility (visible, invisible, gone)
  Widget setVisible2({Key? key, required bool? visible}) {
    if (null != this) {
      return Visibility(
        child: this!,
        visible: visible ?? true,
      );
    }
    return SizedBox();
  }

  Widget inkWell({
    Key? key,
    Widget? child,
    GestureTapCallback? onTap,
    GestureTapCallback? onDoubleTap,
    GestureLongPressCallback? onLongPress,
    GestureTapDownCallback? onTapDown,
    GestureTapCancelCallback? onTapCancel,
    ValueChanged<bool>? onHighlightChanged,
    ValueChanged<bool>? onHover,
    MouseCursor? mouseCursor,
    Color? focusColor,
    Color? hoverColor,
    Color? highlightColor,
    WidgetStateProperty<Color?>? overlayColor,
    Color? splashColor,
    InteractiveInkFeatureFactory? splashFactory,
    double? radius,
    BorderRadius? borderRadius,
    ShapeBorder? customBorder,
    bool? enableFeedback = true,
    bool excludeFromSemantics = false,
    FocusNode? focusNode,
    bool canRequestFocus = true,
    ValueChanged<bool>? onFocusChange,
    bool autofocus = false,
  }) {
    return InkWell(
      child: this,
      key: key,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      onTapDown: onTapDown,
      onTapCancel: onTapCancel,
      onHighlightChanged: onHighlightChanged,
      onHover: onHover,
      mouseCursor: mouseCursor,
      focusColor: focusColor,
      hoverColor: hoverColor,
      highlightColor: highlightColor,
      overlayColor: overlayColor,
      splashColor: splashColor,
      splashFactory: splashFactory,
      radius: radius,
      borderRadius: borderRadius,
      customBorder: customBorder,
      enableFeedback: enableFeedback ?? true,
      excludeFromSemantics: excludeFromSemantics,
      focusNode: focusNode,
      canRequestFocus: canRequestFocus,
      onFocusChange: onFocusChange,
      autofocus: autofocus,
    );
  }

  /// Add padding
  Widget setPadding({Key? key, required EdgeInsets padding}) {
    if (null != this) {
      return Padding(
        key: key,
        padding: padding,
        child: this,
      );
    }
    return SizedBox();
  }

  /// Set alignment
  Widget setAlign(
      {Key? key,
      required AlignmentGeometry alignment,
      double? widthFactor,
      double? heightFactor}) {
    if (null != this) {
      return Align(
        key: key,
        alignment: alignment,
        widthFactor: widthFactor,
        heightFactor: heightFactor,
        child: this,
      );
    }
    return SizedBox();
  }

  /// Wrap with Container
  Widget addContainer(
      {Key? key,
      EdgeInsets? padding,
      EdgeInsets? margin,
      Alignment? alignment,
      Color? color,
      double? height,
      double? width,
      bool? enable = true,
      Decoration? decoration}) {
    if (enable != true) {
      return this!;
    }
    if (null != this) {
      return null != padding ||
              null != margin ||
              null != alignment ||
              null != color ||
              null != decoration
          ? Container(
              key: key,
              height: height,
              width: width,
              padding: padding,
              margin: margin,
              alignment: alignment,
              child: this,
              color: null == decoration ? color : null,
              decoration: decoration,
            )
          : this!;
    }
    return SizedBox();
  }

  /// Wrap with FittedBox
  /// Automatically adjust widget size to fit single line
  Widget addFittedBox({
    Key? key,
  }) {
    if (null != this) {
      return LayoutBuilder(builder: (_, constraints) {
        return FittedBox(
          child: ConstrainedBox(
            constraints: constraints.copyWith(
              minWidth: constraints.maxWidth,
              maxWidth: double.infinity,
            ),
            child: this!,
          ),
        );
      });
    }
    return SizedBox();
  }

  /// Wrap with SafeArea
  Widget addSafeArea(
      {Key? key,
      bool? left,
      bool? top,
      bool? right,
      bool? bottom,
      EdgeInsets? minimum,
      bool? maintainBottomViewPadding}) {
    if (null != this) {
      return SafeArea(
          key: key,
          child: this!,
          left: left ?? true,
          top: top ?? true,
          right: right ?? true,
          bottom: bottom ?? true,
          minimum: minimum ?? EdgeInsets.zero,
          maintainBottomViewPadding: maintainBottomViewPadding ?? false);
    }
    return SizedBox();
  }

  /// Wrap with Expanded
  Widget addExpanded({int? flex = 1, Key? key}) {
    if (null != this) {
      if (null == flex) {
        return this!;
      }
      return Expanded(
        key: key,
        child: this!,
        flex: flex,
      );
    }
    return SizedBox();
  }

  /// Wrap with Flexible
  Widget addFlexible({int? flex, Key? key, FlexFit? fit}) {
    if (null != this) {
      return Flexible(
        key: key,
        fit: fit ?? FlexFit.loose,
        child: this!,
        flex: flex ?? 1,
      );
    }
    return SizedBox();
  }

  /// AbsorbPointer prevents user input.
  /// AbsorbPointer consumes the event, while IgnorePointer does not.
  /// Wrap with AbsorbPointer
  Widget addAbsorbPointer(
      {Key? key, bool? absorbing = true, bool? ignoringSemantics}) {
    if (null != this) {
      Widget child = this!;
      if (ignoringSemantics == true) {
        child = ExcludeSemantics(child: child);
      }
      return absorbing != true
          ? this!
          : AbsorbPointer(
              key: key,
              absorbing: absorbing!,
              child: child,
            );
    }
    return SizedBox();
  }

  /// Wrap with IgnorePointer
  /// AbsorbPointer consumes the event, while IgnorePointer does not.
  Widget addIgnorePointer(
      {Key? key, bool? ignoring = true, bool? ignoringSemantics}) {
    if (null != this) {
      Widget child = this!;
      if (ignoringSemantics == true) {
        child = ExcludeSemantics(child: child);
      }
      return ignoring != true
          ? this!
          : IgnorePointer(
              key: key,
              ignoring: ignoring!,
              child: child,
            );
    }
    return SizedBox();
  }

  /// Add background image
  Widget addBgImg(
      {Key? key,
      String? src,
      BoxFit fit = BoxFit.fill,
      Color color = BaseColorUtils.colorWhite,
      bool wrapContainer = true,
      bool darkNoBg = true,
      double width = double.infinity}) {
    if (null == this) {
      return Container();
    }
    if (!BaseSysUtils.empty(src)) {
      if (wrapContainer) {
        return Container(
          child: this,
          decoration: BoxDecoration(
              color: color.dark,
              image: KayoPackage.share.isDark() && darkNoBg
                  ? null
                  : DecorationImage(
                      image: AssetImage(src!),
                      fit: fit,
                    )),
        );
      }

      return Stack(
        children: [
          ImageView(
            src: src,
            fit: fit,
            width: width,
          ).dark(darkNoBg: darkNoBg),
          this!
        ],
      );
    }
    return this!;
  }
}
