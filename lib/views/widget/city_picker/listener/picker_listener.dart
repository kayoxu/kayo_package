import 'package:flutter/material.dart';

import '../model/city.dart';

/// 事件监听
abstract class LinkagePickerListener {
  void onLoadData(City? parentData,
      ValueChanged<List<City>>? dataResult);

  void onFinish(List<City>? data);
}
