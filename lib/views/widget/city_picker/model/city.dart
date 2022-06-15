/// 城市的数据模型
class City {
  /// 名称
  String? name;

  /// 代码
  var code;

  /// 首字母
  String? letter;

  ///原模型
  String? jsonStr;

  City({
    this.name,
    this.code,
    this.letter,
    this.jsonStr,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json["name"].toString(),
      code: json["code"],
      letter: json["letter"].toString(),
      jsonStr: json["jsonStr"].toString(),
    );
  }
}
