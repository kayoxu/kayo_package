import 'city.dart';

/// tab 的数据模型
class TabTitle {
  /// 索引
  int? index;

  /// 标题
  String? title;

  City? city;

  TabTitle({
    this.index,
    this.title,
    this.city,
  });
}
