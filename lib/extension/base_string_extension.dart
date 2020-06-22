import 'dart:ui';

extension BaseStringExtension on String {
  int toInt({int value = 0}) {
    try {
      if (this?.isNotEmpty == true) {
        value = int.tryParse(this);
      }
    } catch (e) {
      print(e);
    } finally {
      return value;
    }
  }

  Color toColor({Color defaultColor = const Color(0xff333333)}) {
    try {
      if (this?.isNotEmpty == true) {
        if (this.length == 6 &&
            int.tryParse(this.substring(0, 6), radix: 16) != null) {
          //        000000
          return Color(int.parse(this.substring(0, 6), radix: 16) + 0xFF000000);
        } else if (this.length == 7 &&
            int.tryParse(this.substring(1, 7), radix: 16) != null) {
          //        #000000
          return Color(int.parse(this.substring(1, 7), radix: 16) + 0xFF000000);
        } else if (this.length == 8 &&
            int.tryParse(this.substring(0, 8), radix: 16) != null) {
          //        ff000000
          return Color(int.parse(this.substring(0, 8), radix: 16));
        } else if (this.length == 9 &&
            int.tryParse(this.substring(1, 9), radix: 16) != null) {
          //        #ff000000
          return Color(int.parse(this.substring(1, 9), radix: 16));
        } else {
          return defaultColor;
        }
      }
    } catch (e) {
      print(e);
      return defaultColor;
    }
  }

  String toTimeStr() {
    try {
      if (this?.isNotEmpty == true) {
        this.length


      }
    } catch (e) {
      print(e);
      return '';
    }
  }
}
