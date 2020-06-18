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
        if (this.length != 7 ||
            int.tryParse(this.substring(1, 7), radix: 16) == null) {
          return defaultColor;
        } else {
          return new Color(
              int.parse(this.substring(1, 7), radix: 16) + 0xFF000000);
        }
      }
    } catch (e) {
      print(e);
      return defaultColor;
    }
  }
}
