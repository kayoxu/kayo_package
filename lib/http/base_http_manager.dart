import 'dart:async';
import 'dart:collection';
import 'dart:convert' show json;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';

///  tfblue_flutter_module
///  common.http
///
///  Created by kayoxu on 2021-08-05 14:41.
///  Copyright © 2021 kayoxu. All rights reserved.
abstract class BaseHttpManager {
  static const String _tag = 'BaseHttpManager';

  final Map<String, int> _httpPageMap = {};
  int _pageSize = 20;

  static const String contentTypeJson = "application/json";
  static const String contentTypeForm = "application/x-www-form-urlencoded";

  final Map<String, dynamic> optionParams = {
    "timeoutMs": 15000,
    "token": null,
    "authorizationCode": null,
  };

  Dio? _dio;

  Dio get dio {
    _dio ??= Dio();
    return _dio!;
  }

  /// 加载中文字
  String textLoading();

  /// 登录已失效，请重新登录
  String textLoginExpired();

  /// 网络开小差了
  String textNetworkError();

  /// 请求失败
  String textRequestError();

  /// 模型转Json
  String toJson(dynamic data);

  /// json转模型
  Future<T?> getBean<T>(dynamic data);

  /// string转map
  Map<String, dynamic>? getMap(dynamic string);

  /// 打印日志
  void logInfo({String? tag, String? msg});

  bool releaseShowLog() => false;

  /// 保存缓存数据
  Future<void> setSharedData(String sharedUrl, dynamic json);

  /// 读取缓存数据
  Future<String?> getSharedString(String sharedUrl);

  /// 获取基础的Header
  Future<Map<String, dynamic>> getBaseHeader();

  Future<dynamic> baseHttpPost(
    String url,
    dynamic params,
    Map<String, dynamic>? header, {
    bool autoShowDialog = true,
    bool autoHideDialog = true,
    String? method,
    String? contentType,
    ValueChanged<BaseResultData>? onSuccess,
    ValueChanged<String>? onError,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return netFetch(
      url,
      params,
      header,
      Options(method: method ?? 'POST'),
      contentType,
      autoHideDialog: autoHideDialog,
      autoShowDialog: autoShowDialog,
      method: method,
      onSuccess: onSuccess,
      onError: onError,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// 不牵涉分页的时候不用传loadMore，传入loadMore需要传入 page，limit
  Future<void> doHttpPost<T>(
    String url,
    dynamic params, {
    Map<String, dynamic>? header,
    bool autoShowDialog = true,
    bool autoHideDialog = true,
    ValueChanged<T?>? onSuccess,
    ValueChanged<T?>? onCache,
    ValueChanged<String>? onError,
    String? method,
    bool? loadMore,
    String? subKey,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    if (!url.contains('http')) return;

    if (autoShowDialog) LoadingUtils.show(data: textLoading());

    var paramsTemp = Map<String, dynamic>.from((params is Map) ? params : {});
    header = header ?? {};
    header.addAll(await getBaseHeader());

    var sharedUrl = getSharedUrl(url);

    handlePagination(sharedUrl, paramsTemp, loadMore);

    if (loadMore != true && onCache != null) {
      await handleCacheRead(sharedUrl, onCache);
    }

    await baseHttpPost(
      url,
      params is Map ? paramsTemp : params,
      header,
      method: method,
      autoHideDialog: autoHideDialog,
      autoShowDialog: autoShowDialog,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onSuccess: (resultData) async {
        BaseResultData<T> data =
            BaseResultData(resultData.msg, resultData.code);

        if (resultData.code == BaseCode.RESULT_OK) {
          data.data = await getBean<T>(resultData.data);
        }

        if (resultData.code == BaseCode.RESULT_OK) {
          onSuccess?.call(data.data);

          try {
            await handleCacheWrite(sharedUrl, data.data, loadMore,
                onCache as ValueChanged<dynamic>?);
          } catch (e) {
            debugPrint(e.toString());
          }
        } else {
          String errorData = '${resultData.msg ?? resultData.data} ';
          if (BaseSysUtils.empty(errorData)) errorData = textRequestError();
          onError?.call(errorData);

          handlePaginationError(sharedUrl, loadMore, paramsTemp);
        }
        if (autoHideDialog) LoadingUtils.dismiss();
      },
      onError: (e) {
        onError?.call(e.toString());
      },
    );
  }

  Future<dynamic> httpGet(String url, dynamic params, {String? contentType}) {
    return netFetch(url, params, null, Options(method: 'GET'), contentType);
  }

  Future<dynamic> httpUpload(
    String url,
    dynamic params, {
    Options? options,
    String? method,
    Map<String, dynamic>? header,
    String? contentType,
  }) async {
    header = header ?? {};
    header.addAll(await getBaseHeader());

    return netFetch(
      url,
      params,
      header,
      options ?? Options(method: method ?? 'POST'),
      contentType,
    );
  }

  int get resultOkCode => BaseCode.RESULT_OK;
  int get resultErrorNetworkCode => BaseCode.RESULT_ERROR_NETWORK_ERROR;
  int get resultErrorTimeoutCode => BaseCode.RESULT_ERROR_NETWORK_TIMEOUT;
  int get resultErrorOtherCode => BaseCode.RESULT_ERROR_OTHER_ERROR;
  int get resultErrorJsonCode => BaseCode.RESULT_ERROR_NETWORK_JSON_EXCEPTION;
  int get resultLoginExpirationCode => BaseCode.RESULT_ERROR_SIGN_ERROR;

  Future<dynamic> processRequestParams(
      String url, dynamic params, Map<String, dynamic>? header) async {
    return params;
  }

  Future<dynamic> processResponseData(
      Response response, Map<String, dynamic>? header) async {
    return response.data;
  }

  void onResult(Response response) {}

  Future<dynamic> netFetch(
    String? url,
    dynamic params,
    Map<String, dynamic>? header,
    Options? option,
    String? contentType, {
    bool autoShowDialog = true,
    bool autoHideDialog = true,
    String? method,
    ValueChanged<BaseResultData>? onSuccess,
    ValueChanged<String>? onError,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    url = (url ?? '').replaceAll('\n', '');

    // Handle GET params manually to match legacy behavior
    if ((method ?? '').toUpperCase() == 'GET' && params is Map) {
      url = _buildGetUrl(url!, params);
    }

    // Check connectivity
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      var msg = textNetworkError();
      _onError(onError, msg);
      return BaseResultData(msg, resultErrorNetworkCode).sendMsg();
    }

    option ??= Options(method: method ?? 'POST');
    option.headers = header;

    if (!BaseSysUtils.empty(contentType)) {
      option.headers?['Content-Type'] = contentType;
    }
    if (PlatformUtils.isWeb) {
      option.headers?['Access-Control-Allow-Origin'] = '*';
    }

    Response? response;
    var errorHeader = BaseSysUtils.isDebug ? '$url\n' : '';

    var par = await processRequestParams(url!, params, header);

    try {
      response = await dio.request(
        url,
        data: par,
        options: option,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
      );
    } on DioException catch (e) {
      return _handleDioError(e, url, option, params, errorHeader, onError);
    }

    _logResponse(url, option, params, response);

    onResult(response!);

    return _processResponse(response, header, params, autoHideDialog, onSuccess,
        onError, errorHeader);
  }

  String _buildGetUrl(String url, Map params) {
    var m = Map<String, dynamic>.from(params);
    var keys = m.keys;
    int i = 0;
    for (String k in keys) {
      var value = m[k];
      if (value is List) {
        var d = '';
        var index = 0;
        for (var item in value) {
          if (index == 0) {
            d = '$k[]=$item';
          } else {
            d = '$d&$k[]=$item';
          }
          index++;
        }
        url = (i == 0) ? '$url?$d' : '$url&$d';
      } else {
        url = (i == 0) ? '$url?$k=$value' : '$url&$k=$value';
      }
      i++;
    }
    return url;
  }

  Future<BaseResultData> _handleDioError(
    DioException e,
    String url,
    Options option,
    dynamic params,
    String errorHeader,
    ValueChanged<String>? onError,
  ) async {
    Response? errorResponse = e.response ??
        Response(statusCode: 666, requestOptions: RequestOptions(path: ''));

    if (e.type == DioExceptionType.connectionTimeout) {
      errorResponse.statusCode = resultErrorTimeoutCode;
    }

    if (BaseSysUtils.isDebug || releaseShowLog()) {
      logInfo(tag: _tag, msg: '请求异常url: $url');
      logInfo(tag: _tag, msg: '请求异常请求头: ${option.headers}');
      logInfo(tag: _tag, msg: '请求异常参数: $params');
      logInfo(tag: _tag, msg: '请求异常: $e ___ ${e.response}');
    }

    if (errorResponse.statusCode == KayoPackage.share.reLoginCode) {
      var msg = textLoginExpired();
      _onError(onError, msg);
      return BaseResultData(msg, resultLoginExpirationCode).sendMsg();
    }

    String msg = (BaseSysUtils.isDebug ? errorHeader : '') + (e.message ?? '');
    var code = errorResponse.statusCode ?? resultErrorOtherCode;

    try {
      final map = getMap(e.response.toString());
      if (map != null) {
        if (map.containsKey('error')) {
          msg = map['error'] ?? msg;
        } else if (map.containsKey('message') && map['message'] is String) {
          msg = map['message'] ?? msg;
        }
        if (map.containsKey('code')) {
          code = map['code'] ?? code;
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      _onError(onError, e.toString());
      return BaseResultData(msg, code).sendMsg();
    }
    _onError(onError, msg);
    return BaseResultData(msg, code).sendMsg();
  }

  void _logResponse(
      String url, Options option, dynamic params, Response? response) {
    if (BaseSysUtils.isDebug || releaseShowLog()) {
      logInfo(tag: _tag, msg: '请求url: $url');
      logInfo(tag: _tag, msg: '请求头: ${option.headers}');
      if (params != null) {
        logInfo(tag: _tag, msg: '请求参数: $params');
      }
      logInfo(tag: _tag, msg: '返回数据: $response');

      if (optionParams["authorizationCode"] != null) {
        logInfo(
            tag: _tag,
            msg: 'authorizationCode: ${optionParams["authorizationCode"]}');
      }
    }
  }

  Future<dynamic> _processResponse(
    Response response,
    Map<String, dynamic>? header,
    dynamic params,
    bool autoHideDialog,
    ValueChanged<BaseResultData>? onSuccess,
    ValueChanged<String>? onError,
    String errorHeader,
  ) async {
    try {
      var jsonStr = await processResponseData(response, header);

      if (jsonStr is String) {
        try {
          jsonStr = json.decode(jsonStr);
        } catch (e) {
          // ignore if not json
        }
      }

      var jsonMap = <String, dynamic>{};

      if (jsonStr == null) {
        jsonMap = {'code': 200, 'data': ''};
      } else if (jsonStr is List) {
        // Logic to check if list contains code/message seems odd in original, simplified.
        // Assuming List is data.
        jsonMap = {'code': 200, 'data': jsonStr};
      } else if (jsonStr is Map) {
        if (!jsonStr.containsKey('code') ||
            (!jsonStr.containsKey('timestamp') &&
                !jsonStr.containsKey('sign') &&
                !jsonStr.containsKey('message'))) {
          jsonMap = {'code': 200, 'data': jsonStr};
        } else {
          jsonMap = Map<String, dynamic>.from(jsonStr);
        }
      }

      // Check for 'fullData' param or page key to wrap as data
      if ((jsonMap.containsKey('page') && jsonMap.containsKey('code') ||
              (params is Map && params['fullData'] == true)) &&
          resultOkCode == jsonMap['code']) {
        jsonMap = {'code': 200, 'data': jsonStr};
      }

      var resultData = BaseResultData.fromJson(jsonMap);
      if (resultOkCode != resultData.code) {
        var msg = resultData.msg ?? resultData.message;
        _onError(onError, msg ?? '');
        return BaseResultData(msg, resultData.code).sendMsg();
      }

      onSuccess?.call(resultData);
      if (autoHideDialog) LoadingUtils.dismiss();
      return resultData;
    } catch (e) {
      logInfo(tag: _tag, msg: e.toString());
      var message = errorHeader + e.toString();
      _onError(onError, message);
      return BaseResultData(message, resultErrorJsonCode).sendMsg();
    }
  }

  void handlePagination(
      String sharedUrl, Map<String, dynamic> paramsTemp, bool? loadMore) {
    var hasPage = paramsTemp.containsKey("page");
    var hasSize = paramsTemp.containsKey("size");
    var hasLimit = paramsTemp.containsKey("limit");

    if (loadMore != null) {
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
      if (hasSize) {
        _pageSize = paramsTemp["size"];
      }
      if (hasLimit) {
        _pageSize = paramsTemp["limit"];
      }
    }
  }

  Future<void> handleCacheRead<T>(
      String sharedUrl, ValueChanged<T?>? onCache) async {
    var loadCache = await getSharedString(sharedUrl);
    if (!BaseSysUtils.empty(loadCache)) {
      try {
        T? bean = await getBean<T>(loadCache);
        onCache?.call(bean);
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  Future<void> handleCacheWrite(String sharedUrl, dynamic data, bool? loadMore,
      ValueChanged<dynamic>? onCache) async {
    try {
      if (loadMore != true && onCache != null) {
        await setSharedData(sharedUrl, toJson(data));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void handlePaginationError(String sharedUrl, bool? loadMore, Map paramsTemp) {
    var hasPage = paramsTemp.containsKey("page");
    if (loadMore != null) {
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
