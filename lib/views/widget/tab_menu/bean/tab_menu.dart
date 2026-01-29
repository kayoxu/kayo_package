class TabMenu {
  int? count;
  var name;
  var id;
  int? index;

  TabMenu({this.count, this.name, this.id,this.index});

  factory TabMenu.fromJson(Map<String, dynamic> json) =>
      _$TabMenuFromJson(json);

  Map<String, dynamic> toJson() => _$TabMenuToJson(this);

  @override
  String toString() {
    return 'TabMenu{count: $count, name: $name, id: $id}';
  }
}

TabMenu _$TabMenuFromJson(Map<String, dynamic> json) {
  return TabMenu(
    index: json['index'] as int,
    count: json['count'] as int,
    name: json['name'],
    id: json['id'],
  );
}

Map<String, dynamic> _$TabMenuToJson(TabMenu instance) => <String, dynamic>{
      'index': instance.index,
      'count': instance.count,
      'name': instance.name,
      'id': instance.id,
    };
