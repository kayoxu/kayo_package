import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';

///
///  kayo_package
///  drag_view.dart
///
///  Created by kayoxu on 4/22/21 at 1:38 PM
///  Copyright © 2021 kayoxu. All rights reserved.
/// DragView

class DragView extends StatefulWidget {
  final Widget child;
  final Widget? childWhenDragging;

  const DragView({Key? key, this.childWhenDragging, required this.child})
      : super(key: key);

  @override
  _DragViewState createState() => new _DragViewState();
}

class _DragViewState extends State<DragView>
    with SingleTickerProviderStateMixin {
  double _top = 200.0;
  double _left = 4.0;

  bool firstIn = true;

  late Widget theChild;
  GlobalKey _keyChild = GlobalKey();
  RenderBox? renderBox;

  @override
  void initState() {
    super.initState();
    theChild = widget.child;
  }

  @override
  Widget build(BuildContext context) {
    if (firstIn == true) {
      MediaQueryData mo = MediaQuery.of(context);

      firstIn = false;
      try {
        _top = (mo.size.height) - 64 - 300;
        _left = (mo.size.width) - 64;
      } catch (e) {
        print(e);
        firstIn = true;
      }
    }

    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: Container(
              child: theChild,
              key: _keyChild,
            ),
            onPanDown: (DragDownDetails e) {
              renderBox =
                  _keyChild.currentContext?.findRenderObject() as RenderBox?;
            },
            onTap: () {},
            onPanUpdate: (DragUpdateDetails e) {
              setState(() {
                theChild = widget.childWhenDragging ?? widget.child;
                _left += e.delta.dx;
                _top += e.delta.dy;

                if (_left < 0) {
                  _left = 0;
                }

                if (_top < 0) {
                  _top = 0;
                }

                var left = (context.size?.width ?? 300) -
                    (renderBox?.size?.width ?? 56);
                if (_left > left) {
                  _left = left;
                }

                var height2 = (context.size?.height ?? 400) -
                    (renderBox?.size?.height ?? 56);
                if (_top > height2) {
                  _top = height2;
                }
              });
            },
            onPanEnd: (DragEndDetails e) {
              setState(() {
                theChild = widget.child;
              });
            },
          ),
        )
      ],
    );
  }
}
