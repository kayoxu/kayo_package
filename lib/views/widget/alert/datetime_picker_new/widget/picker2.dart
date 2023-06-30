// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:mpcore/mpkit/mpkit.dart';

class CupertinoPicker extends StatefulWidget {
  CupertinoPicker.builder({
    Key? key,
    this.backgroundColor,
    this.scrollController,
    required this.itemExtent,
    required this.onSelectedItemChanged,
    required this.itemBuilder,
    this.selectionOverlay,
    required this.childCount,
  }) : super(key: key);

  final MPPageController? scrollController;

  final Color? backgroundColor;
  final Widget? selectionOverlay;
  final NullableIndexedWidgetBuilder itemBuilder;

  final double itemExtent;
  final int childCount;
  final ValueChanged<int>? onSelectedItemChanged;

  @override
  State<StatefulWidget> createState() => _CupertinoPickerState();
}

class _CupertinoPickerState extends State<CupertinoPicker> {
  MPPageController? _controller;

  int selectIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.scrollController == null) {
      _controller = MPPageController();
    } else {
      setState(() {
        selectIndex = widget.scrollController?.initialPage ?? 0;
      });
    }
    _addListener();
  }

  void _addListener() {
    _controller?.addListener(() {
      widget.onSelectedItemChanged?.call(_controller!.page);
    });
    widget.scrollController?.addListener(() {
      widget.onSelectedItemChanged?.call(widget.scrollController!.page);
    });
  }

  @override
  void didUpdateWidget(CupertinoPicker oldWidget) {
    if (widget.scrollController != null && oldWidget.scrollController == null) {
      _controller = null;
    } else if (widget.scrollController == null &&
        oldWidget.scrollController != null) {
      assert(_controller == null);
      _controller = MPPageController();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color? resolvedBackgroundColor = widget.backgroundColor;
    var result = MPPageView(
        scrollDirection: Axis.vertical,
        controller: widget.scrollController ?? _controller,
        children: List.generate(widget.childCount,
            (index) => widget.itemBuilder.call(context, index)!));

    return DecoratedBox(
      decoration: BoxDecoration(color: resolvedBackgroundColor),
      child: result,
    );
  }
}
