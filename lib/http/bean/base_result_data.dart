import 'package:flutter/material.dart';
import 'package:kayo_package/http/base_code.dart';

///  tfblue_flutter_module
///  common.http
///
///  Created by kayoxu on 2019-06-10 17:25.
///  Copyright © 2019 kayoxu. All rights reserved.

class BaseResultData<T> {
  int? code = 200;
  T? data;

  var timestamp;
  String? sign;
  String? msg;
  String? message;

  BaseResultData(
    this.msg,
    this.code, {
    this.data,
    this.message,
  });

  BaseResultData sendMsg() {
    if (code != BaseCode.RESULT_OK) {
      BaseCode.errorHandleFunction(this.code, this.msg);
    }
    return this;
  }

  factory BaseResultData.fromJson(Map<String, dynamic> json) =>
      _$BaseResultDataFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResultDataToJson(this);

  @override
  String toString() {
    return 'BaseResultData{code: $code, data: $data, timestamp: $timestamp, sign: $sign, msg: $msg}';
  }
}

BaseResultData<T> _$BaseResultDataFromJson<T>(Map<String, dynamic> json) {
  return BaseResultData(
    json['msg'] as String?,
    json['code'] as int?,
    message: json['message'] as String?,
    data: json['data'],
  )
    ..timestamp = json['timestamp']
    ..sign = json['sign'] as String?;
}

Map<String, dynamic> _$BaseResultDataToJson(BaseResultData instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'timestamp': instance.timestamp,
      'sign': instance.sign,
      'msg': instance.msg,
      'message': instance.message,
    };

class BaseResultDataMsg<T> {
  BaseResultData<T> resultData;
  String error;

  BaseResultDataMsg(this.resultData, this.error);
}
