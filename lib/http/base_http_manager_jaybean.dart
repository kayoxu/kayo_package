import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kayo_package/http/bean/result_enum.dart';
import 'package:kayo_package/kayo_package.dart';

abstract class BaseHttpManagerJayBean extends BaseHttpManager {
  final tag = 'BaseHttpManagerJayBean';

  /// Encryption hooks
  String encode(data);
  decode(String data);

  /// Abstract hooks from BaseHttpManager that we still need to implement?
  /// BaseHttpManager has abstract methods:
  /// textLoading, textLoginExpired, textNetworkError, textRequestError
  /// toJson, getBean, getMap, logInfo
  /// setSharedData, getSharedString
  /// getBaseHeader (arg-less)

  /// We override getBaseHeader (from Base) to forward to our custom getBaseHeader
  @override
  Future<Map<String, dynamic>> getBaseHeader({
    bool? encryptionAppSend,
    bool? encryption,
    String? country,
    String? language,
    String? contentType,
    Map<String, dynamic>? optionHeader,
  });

  /// Status Codes overrides
  @override
  int get resultOkCode => resultOk.code;
  @override
  int get resultErrorNetworkCode => resultErrorNetwork.code;
  @override
  int get resultErrorTimeoutCode => resultErrorTimeOut.code;
  @override
  int get resultErrorOtherCode => resultErrorUnknown.code;
  @override
  int get resultErrorJsonCode => resultErrorJson.code;
  @override
  int get resultLoginExpirationCode => resultLoginExpiration.code;

  ResultEnum get resultOk;
  ResultEnum get resultErrorNetwork;
  ResultEnum get resultErrorTimeOut;
  ResultEnum get resultErrorUnknown;
  ResultEnum get resultErrorJson;
  ResultEnum get resultLoginExpiration;

  /// Parameter Processing (Encryption)
  @override
  Future<dynamic> processRequestParams(
      String url, dynamic params, Map<String, dynamic>? header) async {
    var par = params;
    if (params is Map) {
      Map<String, dynamic>? paramsTemp = Map<String, dynamic>.from(params);
      if (header?['jaybean-encryption-app-send'] == true) {
        // Encryption logic
        par = encode(par);
      } else {
        par = paramsTemp; // Use typed map
      }
    }
    return par;
  }

  /// Response Processing (Decryption)
  @override
  Future<dynamic> processResponseData(
      Response response, Map<String, dynamic>? header) async {
    var jsonStr = response.data;
    if (BaseSysUtils.isDebug) {
      logInfo(tag: tag, msg: '返回数据: ' + jsonStr.toString());
    }

    if (header?['jaybean-encryption'] == true) {
      if (jsonStr is String) {
        jsonStr = decode(jsonStr);
      } else if (jsonStr is Map) {
        jsonStr =
            decode(toJson(jsonStr)); // Warning: toJson is abstract in Base
      }
      if (BaseSysUtils.isDebug) {
        logInfo(tag: tag, msg: '返回数据 解密: ' + jsonStr.toString());
      }
    }
    return jsonStr;
  }

  /// Abstract onResult for subclasses
  @override
  void onResult(Response data);

  /// Refactored doHttpPost using helpers
  doHttpPost<T>(String url, dynamic params,
      {Map<String, dynamic>? header,
      bool autoShowDialog = true,
      bool autoHideDialog = true,
      ValueChanged<T?>? onSuccess,
      ValueChanged<T?>? onCache,
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
      String? method,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    if (autoShowDialog) LoadingUtils.show(data: textLoading());

    var paramsTemp = Map<String, dynamic>.from((params is Map) ? params : {});
    header = header ?? Map<String, dynamic>();

    // Call abstract getBaseHeader with args
    header.addAll(await getBaseHeader(
        encryption: encryption,
        encryptionAppSend: encryptionAppSend,
        language: language,
        country: country,
        contentType: contentType,
        optionHeader: optionHeader));

    var sharedUrl = getSharedUrl(url);

    // Use Helper
    handlePagination(sharedUrl, paramsTemp, loadMore);

    if (null == loadMore || loadMore != true && null != onCache) {
      await handleCacheRead(sharedUrl, onCache);
    }

    // Call Super _httpPost (inherited as _httpPost is in Base)
    // _httpPost calls netFetch
    baseHttpPost(
      url,
      params is Map ? paramsTemp : params, // Use paramsTemp if map
      header,
      method: method,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onSuccess: (resultData) async {
        BaseResultData<T> data =
            BaseResultData(resultData.msg, resultData.code);

        if (resultData.code == resultOk.code) {
          // We override resultOkCode so base uses generic check,
          // but here we manually get bean.
          // Actually onSuccess in BaseHttpManager wraps parsing.
          // But here we need T? bean.
          // BaseHttpManager.netFetch calls onSuccess(BaseResultData).
          // resultData.data is Map (parsed json).
          try {
            data.data = await getBean<T>(resultData.data);
          } catch (e) {
            String msg = resultErrorJson.msg;
            if (null != onError) onError(msg);
            if (autoHideDialog) LoadingUtils.dismiss();
            BaseResultData(msg, resultErrorNetwork.code).sendMsg();
            return;
          }
        }

        String? errorData = '';
        if (resultData.code == resultOk.code) {
          // Using resultOkCode via getter
          if (null != onSuccess) {
            onSuccess(data.data); // data.data is T?
          }
          try {
            await handleCacheWrite(sharedUrl, data.data, loadMore,
                onCache as ValueChanged<dynamic>?);
          } catch (e) {
            print(e);
          }
        } else {
          // Error Block
          errorData = '${resultData.msg ?? resultData.data} ';
          if (BaseSysUtils.empty(errorData)) errorData = textRequestError();
          if (null != onError) onError(errorData);

          handlePaginationError(sharedUrl, loadMore, paramsTemp);
        }
        if (autoHideDialog) LoadingUtils.dismiss();
      },
      onError: (e) {
        onError?.call(e.toString());
      },
    );
  }
}
