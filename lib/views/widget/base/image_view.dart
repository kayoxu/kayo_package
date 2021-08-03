import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kayo_package/utils/base_color_utils.dart';
import 'package:kayo_package/views/widget/base/clickable.dart';
//import 'package:flutter_svg/flutter_svg.dart';

///
///  flutter_demo
///
///
/// Created by kayoxu on 2019/1/23.
///  Copyright © 2019 kayoxu. All rights reserved.
///
///
source(String src, {String suffix = '.png'}) {
  if (!suffix.contains(".")) suffix = '.$suffix';
  return 'assets/${src}$suffix';
}

@immutable
class ImageView extends StatefulWidget {
  final String? src;
  final String? url;
  final bool? useCache;
  final File? file;
  final double? width;
  final double? height;
  @Deprecated('用rootWidth代替')
  final double? rootwidth;
  final double? rootWidth;
  final double? rootHeight;
  final ImageProvider? imageProvider;
  final BoxFit fit;
  final double radius;
  final Color? color;
  final EdgeInsets margin;
  final EdgeInsets padding;

  final VoidCallback? onClick;
  final VoidCallback? onLongClick;

  final double? elevation;
  final Color? shadowColor;
  final double? aspectRatio;
  final Color? bgColor;
  final EdgeInsets? imagePadding;
  final Color? imagePaddingColor;
  final double? imagePaddingRadius;
  final String? defaultImage;

  ImageView({
    Key? key,
    this.src,
    this.url,
    this.file,
    this.width,
    this.height,
    this.rootwidth,
    this.rootWidth,
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
    this.imagePadding,
    this.imagePaddingColor,
    this.imagePaddingRadius,
    this.defaultImage,
    this.aspectRatio = -1,
    this.useCache = false,
    this.imageProvider,
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

  bool isDown = false;

  @override
  Widget build(BuildContext context) {
    var image;
    if (null != widget.imageProvider) {
      image = Image(
          image: widget.imageProvider!,
          width: widget.width,
          height: widget.height,
          color: widget.color,
          fit: widget.fit);
    } else {
      if (null != widget.url && widget.url != '' && widget.url!.length > 10) {
        if (widget.useCache == true) {
          image = CachedNetworkImage(
            placeholder: (context, str) {
              return Image.asset(widget.defaultImage ??
                  'packages/kayo_package/assets/ic_no_data.png');
            },
            imageUrl: widget.url!,
            width: widget.width,
            height: widget.height,
            color: widget.color,
            fit: widget.fit,
          );
        } else {
          image = FadeInImage.assetNetwork(
            placeholder: widget.defaultImage ??
                'packages/kayo_package/assets/ic_no_data.png',
            image: widget.url ?? '',
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
          );
        }
      } else if ((widget.src ?? '') != '') {
//      if (widget.src.endsWith('.svg')) {
//        image = SvgPicture.asset(
//          widget.src,
//          color: widget.color,
//          width: widget.width,
//          height: widget.height,
//        );
//      } else

        {
          image = Image.asset(
            widget.src ?? '',
            color: widget.color,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
          );
        }
      } else if (null != widget.file) {
        image = Image.file(widget.file!,
            color: widget.color,
            width: widget.width,
            height: widget.height,
            fit: widget.fit);
      } else {
        image = Image.asset(
            widget.defaultImage ??
                'packages/kayo_package/assets/ic_no_data.png',
            color: widget.color,
            width: widget.width,
            height: widget.height,
            fit: widget.fit);
      }
    }

    var container = Container(
      height: widget.rootHeight,
      width: widget.rootwidth ?? widget.rootWidth,
      color: widget.bgColor,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.radius),
        child: null == widget.onClick
            ? image
            : AnimatedContainer(
                duration: Duration(milliseconds: 100),
                foregroundDecoration: BoxDecoration(
                  color: isDown
                      ? Colors.grey.withOpacity(0.1)
                      : Colors.transparent,
                ),
                child: image,
              ),
      ),
    );

    var container2 = -1 == widget.aspectRatio
        ? container
        : AspectRatio(aspectRatio: widget.aspectRatio ?? 1, child: container);

    return null != widget.imagePadding
        ? Container(
            decoration: BoxDecoration(
              color: widget.imagePaddingColor ?? Colors.transparent,
              borderRadius:
                  BorderRadius.circular(widget.imagePaddingRadius ?? 0),
            ),
            padding: widget.imagePadding,
            alignment: Alignment.center,
            child: image,
          )
        : Clickable(
            margin: widget.margin,
            padding: widget.padding,
            child: container2,
            radius: widget.radius,
            onTap: widget.onClick,
            onLongPress: widget.onLongClick,
            bgColor: Colors.transparent,
            elevation: widget.elevation,
            shadowColor: widget.shadowColor,
            materialBtn: false,
            onTapDown: (d) {
              setState(() {
                isDown = true;
              });
            },

            onHighlightChanged: (b) {
              if (!b) {
                setState(() {
                  isDown = false;
                });
              }
            },
            //      onTapUp: (d) => setState(() => this.isDown = false),
            onTapCancel: () {
              setState(() {
                isDown = false;
              });
            },
          );
  }
}
