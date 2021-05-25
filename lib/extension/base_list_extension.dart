import 'package:kayo_package/kayo_package.dart';

extension BaseListExtension on List? {
  bool get isList => null != this || !(this is List);

  List get dealNotList => isList == true ? this! : [];

  String toStringWith({String splitUnit = '、', String? def}) {
    String str = this.dealNotList.toString();
    return str
        .substring(1, str.length - 1)
        .replaceAll(', ', splitUnit)
        .defaultStr(data: def ?? KayoPackage.share.nullText);
  }
}
