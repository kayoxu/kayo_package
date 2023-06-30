import 'package:flutter/widgets.dart';
import 'package:kayo_package/utils/base_color_utils.dart';
import 'package:kayo_package/views/widget/base/clickable.dart';
import 'package:mpcore/mpkit/mpkit.dart';

class F {
  static Widget Material({Color color = BaseColorUtils.colorWindowWhite,
    BorderRadius borderRadius = BorderRadius.zero,
    Widget? child}) {
    return Container(
      child: child,
      decoration: BoxDecoration(color: color, borderRadius: borderRadius),
    );
  }

  static Widget IconButton({required Function() onPressed,
    Widget? icon,}) {
    return Clickable(
      child: icon,
      radius: 8,
      onTap: onPressed,
    );
  }

  static showModalBottomSheet({required BuildContext context,
    required WidgetBuilder builder, Color? backgroundColor}) {
    showMPDialog(
        context: context, builder: builder, barrierColor: backgroundColor);
  }




}
