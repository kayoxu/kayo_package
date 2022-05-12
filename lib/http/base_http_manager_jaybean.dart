import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:collection';
import 'package:connectivity/connectivity.dart';
import 'package:kayo_package/http/bean/base_result_data.dart';
import 'package:kayo_package/http/bean/result_enum.dart';

import 'package:kayo_package/kayo_package.dart';

import 'dart:convert' show json, utf8;

///  tfblue_flutter_module
///  common.http
///
///  Created by kayoxu on 2021-08-05 14:41.
///  Copyright © 2021 kayoxu. All rights reserved.
///

abstract class BaseHttpManagerJayBean {
  final tag = 'BaseHttpManagerJayBean';

  Map<String, int> _httpPageMap = new HashMap();
  int _pageSize = 20;

  static final CONTENT_TYPE_JSON = "application/json";
  static final CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";

  // Map optionParams = {
  //   "timeoutMs": 15000,
  //   "token": null,
  //   "authorizationCode": null,
  // };

  Dio? dio;

  ///加载中文字
  String textLoading();

  ///登录已失效，请重新登录
  String textLoginExpired();

  ///网络开小差了
  String textNetworkError();

  ///请求失败
  String textRequestError();

  ///模型转Json
  String toJson(data);

  ///json转模型
  Future<T?> getBean<T>(dynamic data);

  ///string转map
  Map<String, dynamic>? getMap(dynamic string);

  ///打印日志
  logInfo({String? tag, msg});

  ///保存缓存数据
  Future<void> setSharedData(String sharedUrl, json);

  ///读取缓存数据
  Future<String?> getSharedString(String sharedUrl);

  ///获取基础的Header
  Future<Map<String, dynamic>> getBaseHeader({bool? encryptionAppSend,
    bool? encryption,
    String? country,
    String? language,
    String? contentType,
    Map<String, dynamic>? optionHeader,});

  ///返回成功
  ResultEnum get resultOk;

  ///网络错误
  ResultEnum get resultErrorNetwork;

  ///网络超时
  ResultEnum get resultErrorTimeOut;

  ///其他错误
  ResultEnum get resultErrorUnknown;

  ///Json解释出错
  ResultEnum get resultErrorJson;

  ///登录过期
  ResultEnum get resultLoginExpiration;

  ///加密
  String encode(data);

  decode(String data);

  _httpPost(String url, Map<String, dynamic>? params,
      Map<String, dynamic>? header,
      {bool autoShowDialog = true,
        bool autoHideDialog = true,
        ValueChanged<dynamic>? onSuccess,
        ValueChanged<String>? onError,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress}) async {
    return netFetch(url, params, header, Options(method: 'POST'),
        autoHideDialog: autoHideDialog,
        autoShowDialog: autoShowDialog,
        onSuccess: onSuccess,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
        onError: onError);
  }

  ///  不牵涉分页的时候不用传loadMore，传入loadMore需要传入 page，limit
  doHttpPost<T>(String url, Map? params,
      {Map<String, dynamic>? header,
        bool autoShowDialog = true,
        bool autoHideDialog = true,
        ValueChanged<BaseResultData<T?>>? onSuccess,
        ValueChanged<BaseResultData<T?>>? onCache,
        ValueChanged<String>? onError,
        bool? loadMore,
        String? subKey,
        CancelToken? cancelToken,

        ///app发送加密数据
        bool? encryptionAppSend,

        ///app接受加密数据
        bool? encryption,

        ///本地化国家
        String? country,

        ///本地化语言
        String? language,

        ///post文件类型
        String? contentType,

        ///额外的header
        Map<String, dynamic>? optionHeader,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress}) async {
    if (autoShowDialog) LoadingUtils.show(data: textLoading());

    var paramsTemp = Map<String, dynamic>.from(params ?? {});
    header = header ?? Map<String, dynamic>();
    header.addAll(await getBaseHeader(
        encryption: encryption,
        encryptionAppSend: encryptionAppSend,
        language: language,
        country: country,
        contentType: contentType,
        optionHeader: optionHeader));

    var sharedUrl = getSharedUrl(url);
    var hasPage = paramsTemp.containsKey("page");
    var hasSize = paramsTemp.containsKey("size");
    var hasLimit = paramsTemp.containsKey("limit");

    if (null != loadMore) {
      if (!hasPage) {
        if (!_httpPageMap.containsKey(sharedUrl)) {
          _httpPageMap[sharedUrl] = 1;
        }

        if (!loadMore) {
          _httpPageMap[sharedUrl] = 1;
        } else {
          _httpPageMap[sharedUrl] = (_httpPageMap[sharedUrl] ?? 0) + 1;
        }

        paramsTemp["page"] = _httpPageMap[sharedUrl];
      }
      if (!hasSize && !hasLimit) {
        _pageSize = 20;
        paramsTemp["size"] = _pageSize;
        paramsTemp["limit"] = _pageSize;
      }
      if (hasSize == true) {
        _pageSize = paramsTemp["size"];
      }
      if (hasLimit == true) {
        _pageSize = paramsTemp["limit"];
      }
    }

    if (null == loadMore || loadMore != true && null != onCache) {
      var loadCache = await getSharedString(sharedUrl);
      if (!BaseSysUtils.empty(loadCache)) {
        try {
          T? bean = await getBean<T>(loadCache);
          if (null != onCache) {
            onCache(BaseResultData(resultOk.msg, resultOk.code, data: bean));
          }
        } catch (e) {
          print(e);
        }
      }
    }

    _httpPost(
      url,
      paramsTemp,
      header,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onSuccess: (resultData) async {
        BaseResultData<T> data =
        BaseResultData(resultData.msg, resultData.code);

        if (resultData.code == resultOk.code) {
          data.data = await getBean<T>(resultData.data);
        }

        String? errorData = '';

        if (/*resultData != null &&*/
        resultData.data != null && resultData.code == resultOk.code) {
          if (null != onSuccess) {
            onSuccess(data);
          }

          try {
            if (loadMore != true && null != onCache) {
              await setSharedData(sharedUrl, toJson(data.data));
            }
          } catch (e) {
            print(e);
          }
        } else {
          errorData = '${resultData.msg ?? resultData.data} ';
          if (BaseSysUtils.empty(errorData)) errorData = textRequestError();
          if (null != onError) onError(errorData);

          if (null != loadMore) {
            if (!hasPage) {
              if (!_httpPageMap.containsKey(sharedUrl)) {
                _httpPageMap[sharedUrl] = 1;
              }
              if (!loadMore) {
                _httpPageMap[sharedUrl] = 1;
              } else {
                _httpPageMap[sharedUrl] = (_httpPageMap[sharedUrl] ?? 1) - 1;
                if (_httpPageMap[sharedUrl]! < 1) {
                  _httpPageMap[sharedUrl] = 1;
                }
              }
            }
          }
        }
        if (autoHideDialog) LoadingUtils.dismiss();
      },
      onError: (e) {
        onError?.call(e.toString());
      },
    );
  }

  httpGet(url, params) {
    return netFetch(url, params, null, Options(method: 'GET'));
  }

  httpUpload(url, params, {Options? options}) {
    return netFetch(
        url, params, null, null != options ? options : Options(method: 'POST'));
  }

  ///发起网络请求
  ///[ url] 请求url
  ///[ params] 请求参数
  ///[ header] 外加头
  ///[ option] 配置
  netFetch(String? url, Map<String, dynamic>? params,
      Map<String, dynamic>? header, Options? option,
      {bool autoShowDialog = true,
        bool autoHideDialog = true,
        ValueChanged<BaseResultData>? onSuccess,
        ValueChanged<String>? onError,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress}) async {
    url = '$url'.replaceAll('\n', '');

    //没有网络
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      var msg = textNetworkError();
      _onError(onError, msg);
      return BaseResultData(msg, resultErrorNetwork.code).sendMsg();
    }

    if (option != null) {
      option.headers = header;
    } else {
      option = Options(method: 'POST');
      option.headers = header;
    }

    ///超时
    // option.connectTimeout = 1000 * 60;

    Response? response;
    var errorHeader = '';
    if (BaseSysUtils.isDebug) {
      errorHeader = '$url\n';
    }

    if (null == dio) {
      dio = Dio();
    }
    Map<String, dynamic>? paramsTemp = params;
    if (header?['jaybean-encryption-app-send'] == true && null != params) {
      paramsTemp = {};
      var keys = params.keys;
      for (String key in keys) {
        var value = params[key];
        if (params[key] is String) {
          paramsTemp[key] = encode(value);
        } else {
          paramsTemp[key] = value;
        }
      }
    }

    var par = paramsTemp;
    try {
      response = await dio!.request(url,
          data: par,
          options: option,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress);
    } on DioError catch (e) {
      Response? errorResponse;

      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse =
            Response(statusCode: 666, requestOptions: RequestOptions(path: ''));
      }
      if (e.type == DioErrorType.connectTimeout) {
        errorResponse?.statusCode = resultErrorTimeOut.code;
      }

      if (BaseSysUtils.isDebug) {
        logInfo(tag: tag, msg: '请求异常url: ' + url);
        logInfo(
            tag: tag,
            msg: '请求异常参数: ' + /* params is Map ? toJson(params) :*/ '$params');

        logInfo(
            tag: tag,
            msg: '请求异常: ' + e.toString() + " ___ " + e.response.toString());
      }

      //todo sbg
      if (errorResponse?.statusCode == resultLoginExpiration.code) {
        var msg = textLoginExpired();
        _onError(onError, msg);
        return BaseResultData(msg, resultLoginExpiration.code).sendMsg();
      }

      String msg = (BaseSysUtils.isDebug ? errorHeader : '') + e.message;
      var code = errorResponse?.statusCode ?? resultErrorUnknown.code;
      Map<String, dynamic>? map = Map<String, dynamic>();
      try {
        map = getMap(e.response.toString());
      } catch (e) {
        print(e);
        _onError(onError, e.toString());
        return BaseResultData(msg, code).sendMsg();
      }
      if (map?.containsKey('msg') == true) {
        msg = map?['msg'] ?? msg;
      }
      if (map?.containsKey('code') == true) {
        code = map?['code'] ?? code;
      }
      _onError(onError, msg);
      return BaseResultData(msg, code).sendMsg();
    }

    if (BaseSysUtils.isDebug) {
      logInfo(tag: tag, msg: '请求url: ' + url);
      logInfo(tag: tag, msg: '请求头: ' + option.headers.toString());
      if (params != null) {
        logInfo(tag: tag, msg: '请求参数: ' + params.toString());
        if (header?['jaybean-encryption-app-send'] == true) {
          logInfo(tag: tag, msg: '请求参数 加密: ' + par.toString());
        }
      }

      // if (optionParams["authorizationCode"] != null) {
      //   logInfo(
      //       tag: tag,
      //       msg: 'authorizationCode: ' + optionParams["authorizationCode"]);
      // }
    }

    try {
      var jsonStr = response.data;
      logInfo(tag: tag, msg: '返回数据: ' + jsonStr.toString());

      if (header?['jaybean-encryption'] == true) {
        if (jsonStr is String) {
          jsonStr = decode(jsonStr);
        } else if (jsonStr is Map) {
          jsonStr = decode(toJson(jsonStr));
        }
        logInfo(tag: tag, msg: '返回数据 解密: ' + jsonStr.toString());
      }
      if (jsonStr is String) {
        jsonStr = await json.decode(jsonStr);
      }
      var resultData = BaseResultData.fromJson(jsonStr);
      if (/*null != resultData*/ true) {
        if (BaseCode.RESULT_OK != resultData.code) {
          var msg = resultData.msg;
          _onError(onError, msg ?? '');
          return BaseResultData(msg, resultData.code).sendMsg();
        }

        onSuccess?.call(resultData);
        if (autoHideDialog) LoadingUtils.dismiss();
        return resultData;
      }
    } catch (e) {
      logInfo(tag: tag, msg: e.toString());

      var message = errorHeader + e.toString();

      _onError(onError, message);
      return BaseResultData(message, resultErrorJson.code).sendMsg();
    }
  }

  void _onError(ValueChanged<String>? onError, String message) {
    onError?.call(message);
    LoadingUtils.dismiss();
  }

  String getSharedUrl(String? url) {
    return (url ?? "")
        .replaceAll("/", "_")
        .replaceAll(":", "_")
        .replaceAll("?", "_")
        .replaceAll(".", "_");
  }
}