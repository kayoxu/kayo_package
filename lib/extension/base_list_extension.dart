import 'package:kayo_package/kayo_package.dart';

extension BaseListExtension on List {
  bool get isList => null != this || !(this is List);

  List get dealNotList => isList ? this : [];

  String toStringWith({String splitUnit = '、', String def = '无'}) {
    String str = this.dealNotList.toString();
    return str
        .substring(1, str.length - 1)
        .replaceAll(', ', splitUnit)
        .defaultStr();
  }
}
