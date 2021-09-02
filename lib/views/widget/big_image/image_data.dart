import 'dart:io';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kayo_package/kayo_package.dart';

///  smart_lock_flutter
///  bean.common
///
///  Created by kayoxu on 2019-09-05 14:44.
///  Copyright © 2019 kayoxu. All rights reserved.

class ImageData {
  ImageData({this.file, this.path, this.url});

  final File? file;
  final String? path;
  String? url;

  bool get isUpload {
    return !BaseSysUtils.empty(url);
  }

  factory ImageData.fromJson(Map<String, dynamic> json) =>
      _$ImageDataFromJson(json);

  Map<String, dynamic> toJson() => _$ImageDataToJson(this);
}

ImageData _$ImageDataFromJson(Map<String, dynamic> json) {
  return ImageData(
    path: json['path'] as String,
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$ImageDataToJson(ImageData instance) => <String, dynamic>{
      'path': instance.path,
      'url': instance.url,
    };
