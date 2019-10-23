import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kayo_package/utils/base_color_utils.dart';
import 'package:kayo_package/views/widget/base/clickable.dart';
import 'package:flutter_svg/flutter_svg.dart';

/**
 *  flutter_demo
 *
 *
 *  Created by kayoxu on 2019/1/23.
 *  Copyright © 2019 kayoxu. All rights reserved.
 */
source(String src, {String suffix = '.png'}) {
  if (!suffix.contains(".")) suffix = '.$suffix';
  return 'assets/${src}$suffix';
}

class ImageView extends StatefulWidget {
  String src;
  String url;
  bool useCache;
  File file;
  double width;
  double height;
  double rootwidth;
  double rootHeight;
  BoxFit fit;
  double radius;
  Color color;
  EdgeInsets margin;
  EdgeInsets padding;

  VoidCallback onClick;
  VoidCallback onLongClick;

  double elevation;
  Color shadowColor;
  double aspectRatio;
  Color bgColor;

  var isDown = false;

  ImageView({
    Key key,
    this.src,
    this.url,
    this.file,
    this.width,
    this.height,
    this.rootwidth,
    this.rootHeight,
    this.fit = BoxFit.fitHeight,
    this.radius = 0,
    this.color,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(0),
    this.onClick,
    this.onLongClick,
    this.elevation,
    this.shadowColor,
    this.bgColor,
    this.aspectRatio = -1,
    this.useCache = false,
  }) : super(key: key);

  @override
  ImageViewState createState() => ImageViewState();
}

class ImageViewState extends State<ImageView> {
// 圆形
//  ClipOval
//  圆角
//  ClipRRect borderRadius: BorderRadius.circular(10),
//  BoxDecoration BoxShape.circle

  @override
  Widget build(BuildContext context) {
    var image;
    if (null != widget.url && widget.url != '' && widget.url.length > 10) {
      if (widget.useCache) {
        image = CachedNetworkImage(
          placeholder: source('ic_moren'),
          imageUrl: widget.url,
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
        );
      }else{
        image = FadeInImage.assetNetwork(
          placeholder: source('ic_moren'),
          image: widget.url,
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
        );
      }
    } else if ((widget.src ?? '') != '') {
      if (widget.src.endsWith('.svg')) {
        image = SvgPicture.asset(
          widget.src,
          color: widget.color,
          width: widget.width,
          height: widget.height,
        );
      } else {
        image = Image.asset(
          widget.src,
          color: widget.color,
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
        );
      }
    } else if (null != widget.file) {
      image = Image.file(widget.file,
          color: widget.color,
          width: widget.width,
          height: widget.height,
          fit: widget.fit);
    } else {
      image = Image.asset('assets/ic_moren.png',
          color: widget.color,
          width: widget.width,
          height: widget.height,
          fit: widget.fit);
    }

    var container = Container(
      height: widget.rootHeight,
      width: widget.rootwidth,
      color: widget.bgColor,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.radius),
        child: null == widget.onClick
            ? image
            : AnimatedContainer(
          duration: Duration(milliseconds: 100),
          foregroundDecoration: BoxDecoration(
            color: widget.isDown
                ? Colors.white.withOpacity(0.5)
                : Colors.transparent,
          ),
          child: image,
        ),
      ),
    );

    var container2 = -1 == widget.aspectRatio
        ? container
        : AspectRatio(aspectRatio: widget.aspectRatio, child: container);

    return Clickable(
      margin: widget.margin,
      padding: widget.padding,
      child: container2,
      radius: widget.radius,
      onTap: widget.onClick,
      onLongPress: widget.onLongClick,
      bgColor: Colors.transparent,
      elevation: widget.elevation,
      shadowColor: widget.shadowColor,

      onTapDown: (d) {
        setState(() {
          widget.isDown = true;
        });
      },

      onHighlightChanged: (b) {
        if (!b) {
          setState(() {
            widget.isDown = false;
          });
        }
      },
      //      onTapUp: (d) => setState(() => this.isDown = false),
      onTapCancel: () {
        setState(() {
          widget.isDown = false;
        });
      },
    );
  }
}
