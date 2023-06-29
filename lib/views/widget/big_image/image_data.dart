import 'dart:io';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:typed_data';


///  smart_lock_flutter
///  bean.common
///
///  Created by kayoxu on 2019-09-05 14:44.
///  Copyright © 2019 kayoxu. All rights reserved.

class ImageData {
  ImageData({this.file, this.path, this.url, this.name, this.size, this.bytes});

  File? file;
  String? path;
  num? size;
  final String? name;
  String? url;
  Uint8List? bytes;

  bool get isUpload {
    return null != url && '' != url;
  }

  factory ImageData.fromJson(Map<String, dynamic> json) =>
      _$ImageDataFromJson(json);

  Map<String, dynamic> toJson() => _$ImageDataToJson(this);
}

ImageData _$ImageDataFromJson(Map<String, dynamic> json) {
  return ImageData(
    path: json['path'] as String,
    url: json['url'] as String,
    name: json['name'] as String,
    size: json['size'] as num?,
    bytes: json['bytes'] as Uint8List?,
  );
}

Map<String, dynamic> _$ImageDataToJson(ImageData instance) =>
    <String, dynamic>{
      'path': instance.path,
      'url': instance.url,
      'name': instance.name,
      'size': instance.size,
      'bytes': instance.bytes,
    };
