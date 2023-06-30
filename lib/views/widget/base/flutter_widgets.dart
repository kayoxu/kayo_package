import 'package:flutter/widgets.dart';
import 'package:kayo_package/utils/base_color_utils.dart';
import 'package:kayo_package/views/widget/base/clickable.dart';
import 'package:kayo_package/views/widget/base/line_view.dart';
import 'package:kayo_package/views/widget/tool_bar.dart';
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

  static Future<T> showCupertinoDialog<T>(
      {required BuildContext context, required WidgetBuilder builder}) {
    return showMPDialog(
      context: context,
      builder: builder,
    );
  }

  static Widget CupertinoDialogAction({Widget? child, Function()? onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: child,
      ),
    );
  }

  static Widget CupertinoAlertDialog({
    Widget? title,
    Widget? content,
    List<Widget>? actions,
  }) {
    return ToolBar(
        backgroundColor: BaseColorUtils.colorWhite,
        noBack: true,
        child: Column(
          children: [
            ...null != title
                ? [
              Container(
                child: title,
                padding: EdgeInsets.only(top: 4, bottom: 4),
              )
            ]
                : [],
            ...null != content
                ? [
              Container(
                child: content,
                padding: EdgeInsets.only(top: 4, bottom: 4),
              )
            ]
                : [],
            LineView(
              margin: EdgeInsets.only(top: 20, bottom: 10),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: actions ?? [],
              ),
            )
          ],
        ));
  }


}
