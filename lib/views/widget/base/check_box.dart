import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';
import 'package:kayo_package/utils/base_sys_utils.dart';

import 'clickable.dart';
import 'text_view.dart';

class RadioView extends StatelessWidget {
  ValueChanged<int?> onChanged;
  int value;
  String name;
  int groupValue;
  Color activeColor;
  Color nameColor;
  int nameSize;
  bool? single;

  RadioView(
      {required this.value,
      required this.name,
      required this.groupValue,
      required this.activeColor,
      required this.onChanged,
      this.nameColor = BaseColorUtils.colorBlack,
      this.nameSize = 14});

  @override
  Widget build(BuildContext context) {
    var radio = Radio(
      value: value,
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
            color: nameColor,
            size: 14,
          ),
        ],
      ),
      onTap: () {
        onChanged(value);
      },
    );
  }
}

class CheckBoxView extends StatelessWidget {
  ValueChanged<bool?>? onChanged;
  bool? value;
  String? name;
  Color? activeColor;
  Color nameColor;
  EdgeInsets? padding;
  double? nameSize;

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
          TextView(
            name ?? '',
            color: nameColor,
            size: nameSize ?? 14,
          ),
        ],
      ),
      onTap: () {
        onChanged?.call(!value2);
      },
    );
  }
}
