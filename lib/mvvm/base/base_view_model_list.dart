import 'package:flutter/material.dart';
import 'package:kayo_package/mvvm/base/base_view_model_refresh_list.dart';

///
///  kayo_package
///  base_view_model_list.dart
///
///  Created by kayoxu on 2020/8/6 at 6:26 PM
///  Copyright © 2020 kayoxu. All rights reserved.
///


///只有列表，可分页
abstract class BaseViewModelList<T> extends BaseViewModelRefreshList<T> {
  @override
  loadData(
      {ValueChanged<List<T>> onSuccess,
      ValueChanged<List<T>> onCache,
      ValueChanged<String> onError});

  @override
  void dispose() {
    super.dispose();
  }
}
