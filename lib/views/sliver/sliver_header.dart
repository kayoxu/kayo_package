import 'package:flutter/material.dart';


///
///  kayo_package
///  sliver_header.dart
///
///  Created by kayoxu on 2020/9/15 at 2:10 PM
///  Copyright © 2020 kayoxu. All rights reserved.
///

class SliverHeader extends SliverPersistentHeaderDelegate {
  double maxHeight;

  double miniHeight;

  Widget? child;
  bool? shouldRebuildWidget;

  SliverHeader(
      {this.maxHeight = 50.0,
        this.miniHeight = 50.0,
        this.child,
        this.shouldRebuildWidget});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child!;
  } // 头部展示内容

  @override
  double get maxExtent => maxHeight; // 最大高度

  @override
  double get minExtent => miniHeight; // 最小高度

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) =>
      this.shouldRebuildWidget ?? false; // 因为所有的内容都是固定的，所以不需要更新
}
