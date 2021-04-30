import 'package:flutter/material.dart';

///
///  kayo_package
///  notification_center.dart
///
///  Created by kayoxu on 4/30/21 at 8:38 AM
///  Copyright © 2021 kayoxu. All rights reserved.
///

// LiveDataBus.share.addObserver<LockData>('postName', (data) {
// LogUtils.info(tag: 'postName', msg: data.name);
// });

// LiveDataBus.share
//     .post('postName', LockData(name: '111111'));

// LiveDataBus.share.remove('postName');


typedef PostData = Function(dynamic object);

class LiveDataBus {
  /// 工厂模式
  factory LiveDataBus() => _getInstance();

  static LiveDataBus get share => _getInstance();
  static LiveDataBus? _instance;

  LiveDataBus._internal() {
    // 初始化
  }

  static LiveDataBus _getInstance() {
    if (_instance == null) {
      _instance = LiveDataBus._internal();
    }
    return _instance!;
  }

  ///创建Map来记录名称
  Map<String, dynamic> _postNameMap = Map<String, dynamic>();

  ///添加监听者方法
  addObserver<T>(String postName, object(T? data)) {
    remove(postName);
    _postNameMap.addAll({postName: object});
  }

  ///发送通知传值
  post(String postName, dynamic data) {
    //检索Map是否含有postName
    if (_postNameMap.containsKey(postName)) {
      _postNameMap[postName]?.call(data);
    }
  }

  ///移除通知
  remove(String postName) {
    if (_postNameMap.containsKey(postName)) {
      _postNameMap.remove(postName);
    }
  }
}
