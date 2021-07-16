import 'package:flutter/material.dart';

///
///  kayo_package
///  _index_animation.dart
///
///  Created by kayoxu on 2020/8/13 at 11:30 AM
///  Copyright © 2020 kayoxu. All rights reserved.
///

class AnimationTween extends StatefulWidget {
  final Widget child;
  final int milliseconds;
  final bool animateX;
  final bool animateY;
  final double size;
  final ValueChanged<AnimationController>? controller;
  final AlignmentGeometry? alignment;

  const AnimationTween(
      {Key? key,
      required this.child,
      required this.controller,
      this.alignment,
      this.size = 100,
      this.milliseconds = 500,
      this.animateX = true,
      this.animateY = true})
      : super(key: key);

  _AnimationTweenState createState() => new _AnimationTweenState();
}

class _AnimationTweenState extends State<AnimationTween>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: Duration(milliseconds: widget.milliseconds), vsync: this);
    animation = new Tween(begin: 0.0, end: widget.size).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    widget.controller?.call(controller);
  }

  Widget build(BuildContext context) {
    return Container(
      alignment: widget.alignment,
      height: widget.animateY == true ? animation.value : null,
      width: widget.animateX == true ? animation.value : null,
      child: widget.child,
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}
