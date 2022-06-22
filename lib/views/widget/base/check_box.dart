import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';
import 'package:kayo_package/utils/base_sys_utils.dart';

import 'clickable.dart';
import 'text_view.dart';

class RadioView extends StatelessWidget {
  final ValueChanged<dynamic>? onChanged;
  final dynamic value;
  final String? name;
  final dynamic groupValue;
  final Color? activeColor;
  final Color? nameColor;
  final int? nameSize;
  final bool? single;

  RadioView(
      {required this.value,
      required this.name,
      required this.groupValue,
      required this.activeColor,
      required this.onChanged,
      this.nameColor = BaseColorUtils.colorBlack,
      this.nameSize = 14,
      this.single});

  @override
  Widget build(BuildContext context) {
    var radio = Radio(
      value: value ?? 0,
      activeColor: activeColor,
      groupValue: groupValue,
      onChanged: onChanged,
    );
    return Clickable(
      radius: 12,
      bgColor: Colors.transparent,
      padding: EdgeInsets.only(right: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          radio,
          TextView(
            name ?? '',
            color: nameColor ?? BaseColorUtils.colorBlack,
            size: 14,
          ),
        ],
      ),
      onTap: () {
        onChanged?.call(value);
      },
    );
  }
}

class CheckBoxView extends StatelessWidget {
  final ValueChanged<bool?>? onChanged;
  final bool? value;
  final String? name;
  final Color? activeColor;
  final Color nameColor;
  final EdgeInsets? padding;
  final double? nameSize;

  CheckBoxView(
      {required this.value,
      required this.name,
      required this.activeColor,
      required this.onChanged,
      this.nameColor = BaseColorUtils.colorBlack,
      this.nameSize = 14,
      this.padding});

  @override
  Widget build(BuildContext context) {
    var value2 = value ?? false;
    var check = Checkbox(
      activeColor: activeColor,
      onChanged: onChanged,
      value: value2,
    );
    return Clickable(
      radius: 12,
      bgColor: Colors.transparent,
      padding: padding ?? EdgeInsets.only(right: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          check,
          Flexible(
            child: TextView(
              name ?? '',
              maxLine: 10,
              color: nameColor,
              // width: w,
              size: nameSize ?? 14,
            ),
          ),
        ],
      ),
      onTap: null == onChanged
          ? null
          : () {
              onChanged?.call(!value2);
            },
    );
  }
}
