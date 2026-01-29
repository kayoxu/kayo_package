---
name: HTTP Layer Guide
description: How to use the HTTP utilities in kayo_package
---
# HTTP Layer Guide

## Overview

kayo_package provides a structured HTTP layer with:

- `BaseAPI` - Host configuration
- `BaseHttpManager` - Request handling
- `BaseCode` - Response codes and error handling

## BaseAPI

Extend this class to configure your API hosts:

```dart
class API extends BaseAPI {
  bool appInactive = false;
  
  static API get share => API._share();
  static API? _instance;
  
  String? _host;
  String? _hostFile;
  
  API._();
  
  factory API._share() {
    _instance ??= API._();
    return _instance!;
  }
  
  @override
  bool get isEnv => false;  // false = dev, true = prod
  
  @override
  init() async {
    await SharedUtils.setHost(isEnv == false
        ? 'http://dev.api.com/'
        : 'http://prod.api.com/');
    
    _host = await SharedUtils.getHost();
  }
  
  @override
  String get host => _host ?? '';
  
  @override
  String get hostFile => _hostFile ?? '';
  
  @override
  String get hostSocket => '';
}
```

## BaseHttpManager

Extend this class for HTTP request handling:

```dart
class HttpManager extends BaseHttpManager {
  static HttpManager get share => HttpManager._share();
  static HttpManager? _instance;
  
  HttpManager._();
  
  factory HttpManager._share() {
    _instance ??= HttpManager._();
    return _instance!;
  }
  
  @override
  Future<Map<String, dynamic>> getBaseHeader() async {
    var userInfo = await SharedUtils.getUserInfo();
    
    return {
      if (userInfo?.token != null)
        'Authorization': 'Bearer ${userInfo!.token}',
      'Content-Type': 'application/json',
      'Platform': 'mobile',
    };
  }
  
  @override
  Future<T?> getBean<T>(data) => JsonUtils.getBean<T>(data);
  
  @override
  Map<String, dynamic>? getMap(dynamic string) => JsonUtils.getMap(string);
  
  @override
  String toJson(data) => JsonUtils.toJson(data);
  
  @override
  Future<String?> getSharedString(String key) => SharedUtils.getString(key);
  
  @override
  Future<void> setSharedData(String key, json) => SharedUtils.set(key, json);
  
  @override
  releaseShowLog() => true;  // Enable logging
  
  @override
  logInfo({String? tag, String? msg}) => LogUtils.info(msg: msg, tag: tag);
  
  // UI text overrides
  @override
  String textLoading() => '加载中...';
  
  @override
  String textNetworkError() => '网络错误';
  
  @override
  String textRequestError() => '请求失败';
  
  @override
  String textLoginExpired() => '登录已过期';
}
```

## Making Requests

### GET Request

```dart
HttpManager.share.request(
  requestMethod: RequestMethod.GET,
  url: '${API.share.host}api/v1/items',
  data: {'page': 1, 'limit': 20},
  onSuccess: (data) async {
    var result = await HttpManager.share.getBean<ItemListEntity>(data);
    onSuccess?.call(result);
  },
  onCache: (data) async {
    // Handle cached data
  },
  onError: (code, message) {
    onError?.call(message);
  },
);
```

### POST Request

```dart
HttpManager.share.request(
  requestMethod: RequestMethod.POST,
  url: '${API.share.host}api/v1/items',
  data: {
    'name': 'New Item',
    'value': 100,
  },
  onSuccess: (data) async {
    var result = await HttpManager.share.getBean<ItemEntity>(data);
    onSuccess?.call(result);
  },
  onError: (code, message) {
    LoadingUtils.showError(data: message);
  },
);
```

## Service Pattern

Create service classes for each API domain:

```dart
class ItemService {
  void getList(
    Map<String, dynamic> params, {
    ValueChanged<ItemListEntity?>? onSuccess,
    ValueChanged<ItemListEntity?>? onCache,
    ValueChanged<String>? onError,
  }) {
    HttpManager.share.request(
      requestMethod: RequestMethod.GET,
      url: '${API.share.host}api/v1/items',
      data: params,
      onSuccess: (data) async {
        var result = await HttpManager.share.getBean<ItemListEntity>(data);
        onSuccess?.call(result);
      },
      onCache: (data) async {
        var result = await HttpManager.share.getBean<ItemListEntity>(data);
        onCache?.call(result);
      },
      onError: (code, message) {
        onError?.call(message);
      },
    );
  }
  
  void create(
    Map<String, dynamic> data, {
    ValueChanged<ItemEntity?>? onSuccess,
    ValueChanged<String>? onError,
  }) {
    HttpManager.share.request(
      requestMethod: RequestMethod.POST,
      url: '${API.share.host}api/v1/items',
      data: data,
      onSuccess: (response) async {
        var result = await HttpManager.share.getBean<ItemEntity>(response);
        onSuccess?.call(result);
      },
      onError: (code, message) {
        onError?.call(message);
      },
    );
  }
}
```

## HttpQuery Aggregator

Aggregate all services in one place:

```dart
class HttpQuery {
  static HttpQuery get share => HttpQuery._share();
  static HttpQuery? _instance;
  
  HttpQuery._();
  
  factory HttpQuery._share() {
    _instance ??= HttpQuery._();
    return _instance!;
  }
  
  late ItemService itemService = ItemService();
  late UserService userService = UserService();
  // Add more services...
}

// Usage in ViewModel
HttpQuery.share.itemService.getList({...});
```

## Error Handling

BaseCode provides standard error codes:

```dart
class BaseCode {
  static const int RESULT_OK = 0;
  static const int RESULT_ERROR_NETWORK_ERROR = -1;
  static const int RESULT_ERROR_NETWORK_TIMEOUT = -2;
  static const int RESULT_ERROR_NETWORK_JSON_EXCEPTION = -3;
  static const int RESULT_ERROR_SIGN_ERROR = 401;
}

// Handle in main.dart
BaseCode.eventBus.on<BaseHttpErrorEvent>().listen((event) {
  switch (event.code) {
    case BaseCode.RESULT_ERROR_NETWORK_ERROR:
      LoadingUtils.showError(data: event.message);
      break;
    case BaseCode.RESULT_ERROR_SIGN_ERROR:
      // Re-login required
      showLoginDialog();
      break;
  }
});
```
