import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';

/// A modern, elegant implementation of a Radio button with a label.
///
/// Wraps [Radio] and [Text] in an [InkWell] for better touch targets and ripple effects.
class RadioView<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final TextStyle? labelStyle;
  final Color? activeColor;
  final EdgeInsetsGeometry? padding;

  const RadioView({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label,
    this.activeColor,
    this.labelStyle,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChanged != null ? () => onChanged!(value) : null,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Radio<T>(
              value: value,
              // ignore: deprecated_member_use
              groupValue: groupValue,
              activeColor: activeColor,
              // ignore: deprecated_member_use
              onChanged: onChanged,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
            if (label != null && label!.isNotEmpty) ...[
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  label!,
                  style: labelStyle ??
                      TextStyle(
                          fontSize: 14,
                          color: BaseColorUtils.darkBlack(context: context)),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// A modern, elegant implementation of a Checkbox with a label.
///
/// Wraps [Checkbox] and [Text] in an [InkWell].
class CheckBoxView extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final String? label;
  final TextStyle? labelStyle;
  final Color? activeColor;
  final EdgeInsetsGeometry? padding;

  const CheckBoxView({
    Key? key,
    required this.value,
    required this.onChanged,
    this.label,
    this.activeColor,
    this.labelStyle,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChanged != null ? () => onChanged!(!value) : null,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: activeColor,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
            if (label != null && label!.isNotEmpty) ...[
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  label!,
                  style: labelStyle ??
                      TextStyle(
                          fontSize: 14,
                          color: BaseColorUtils.darkBlack(context: context)),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
