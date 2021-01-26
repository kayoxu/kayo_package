import 'package:flutter/services.dart';
import 'package:kayo_package/kayo_package.dart';

///价格输入框和数量输入框的限制
class PrecisionLimitFormatter extends TextInputFormatter {
  int _scale;
  double maxValue = double.infinity;
  bool withDecimal = true;

  PrecisionLimitFormatter(this._scale, {this.maxValue, this.withDecimal});

  RegExp exp = new RegExp("[0-9.]");
  static const String POINTER = ".";
  static const String DOUBLE_ZERO = "00";

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,
      TextEditingValue newValue) {
    ///输入完全删除
    if (newValue.text.isEmpty) {
      return TextEditingValue();
    }
    if (withDecimal == false && newValue.text.contains(POINTER)) {
      return oldValue;
    }


    if (newValue.text.toDouble() > maxValue) {
      return oldValue;
    }

    ///只允许输入小数
    if (!exp.hasMatch(newValue.text)) {
      return oldValue;
    }

    ///包含小数点的情况
    if (newValue.text.contains(POINTER)) {
      ///包含多个小数
      if (newValue.text.indexOf(POINTER) !=
          newValue.text.lastIndexOf(POINTER)) {
        return oldValue;
      }
      String input = newValue.text;
      int index = input.indexOf(POINTER);

      ///小数点后位数
      int lengthAfterPointer = input
          .substring(index, input.length)
          .length - 1;

      ///小数位大于精度
      if (lengthAfterPointer > _scale) {
        return oldValue;
      }
    } else if (newValue.text.startsWith(POINTER) ||
        newValue.text.startsWith(DOUBLE_ZERO)) {
      ///不包含小数点,不能以“00”开头
      return oldValue;
    }
    return newValue;
  }
}

class DecimalDigitsTextInputFormatter extends TextInputFormatter {
  final int decimalDigits;

  DecimalDigitsTextInputFormatter(this.decimalDigits,);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,
      TextEditingValue newValue,) {
    String newTxt = newValue.text.replaceExceptFirst('.', '');
    List<String> newArr = newTxt.split('.');
    if (newArr.length != 1 && newArr[1].length > decimalDigits) {
      String value = '${newArr[0]}.${newArr[1].substring(0, decimalDigits)}';
      return TextEditingValue(
          text: value,
          selection: TextSelection.collapsed(offset: value.length));
    }
    return TextEditingValue(
        text: newTxt,
        selection: TextSelection.collapsed(offset: newTxt.length));
  }
}
