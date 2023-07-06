extension BaseIntExtension on int? {
  int? fixeZero({int data = 0}) {
    if (null != this) {
      var i = this!;
      return i < data ? data : i;
    }
    return this;
  }
}

extension BaseDoubleExtension on double? {
  double? fixeZero({double data = 0}) {
    if (null != this) {
      var i = this!;
      return i < data ? data : i;
    }
    return this;
  }
}
