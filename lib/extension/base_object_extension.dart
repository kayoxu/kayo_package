import 'dart:convert';

import 'package:flutter/material.dart';

import '../kayo_package.dart';

extension IterableMapIndexed<E> on Iterable<E> {
  Iterable<R> mapIndexed2<R>(R Function(int index, E) transform) sync* {
    var index = 0;
    for (final element in this) {
      yield transform(index++, element);
    }
  }
}


extension BaseObjectExtension on Object? {
  T defaultValue<T>({required T data}) {
    if (null == this || this is! T) {
      return data;
    } else {
      return this as T;
    }
  }

  int defaultInt({int data = 0}) {
    if (null == this || this is! int) {
      if (this is double) {
        return (this as double).toInt();
      }
      return data;
    } else {
      return this as int;
    }
  }

  String defaultStr({String? data}) {
    if (null == this || '' == this || this is! String) {
      if (this is num) {
        return this.toString();
      }
      return data ?? KayoPackage.share.nullText;
    } else {
      return this as String;
    }
  }

  double defaultDouble({double data = 0}) {
    if (null == this || this is! double) {
      if (this is int) {
        return (this as int).toDouble();
      }
      return data;
    } else {
      return this as double;
    }
  }

  T? findFirst<T>() {
    if (null != this && this is List) {
      if ((this as List).length > 0) {
        return (this as List).first as T;
      }
    }
    return null;
  }

  T? findLast<T>() {
    if (null != this && this is List) {
      if ((this as List).length > 0) {
        return (this as List).last as T;
      }
    }
    return null;
  }

  T? findData<T>(int index) {
    if (null != this && this is List) {
      if ((this as List).length > 0 && index < (this as List).length) {
        return (this as List)[index] as T;
      }
    }
    return null;
  }

  String? toJson2({bool removeNull = true}) {
    if (null != this) {
      var jsonStr = '';
      if (!(this is String)) {
        jsonStr = jsonEncode(this);
      } else {
        jsonStr = this! as String;
      }
      var jm = json.decode(jsonStr);
      if (jm is Map) {
        removeMapNull(jm);
      } else if (jm is List) {
        for (var m in jm) {
          if (m is Map) {
            removeMapNull(m);
          }
        }
      }
      return json.encode(jm);
    }
    return null;
  }

  Map<String, dynamic>? toJMap2({bool removeNull = true}) {
    if (null != this) {
      var jsonStr = '';
      if (!(this is String)) {
        jsonStr = jsonEncode(this);
      } else {
        jsonStr = this! as String;
      }
      var jm = json.decode(jsonStr);
      if (jm is Map) {
        removeMapNull(jm);
      } else if (jm is List) {
        for (var m in jm) {
          if (m is Map) {
            removeMapNull(m);
          }
        }
      }
      return jm;
    }
    return Map<String, dynamic>();
  }
}

void removeMapNull(Map<dynamic, dynamic> jd) {
  jd.removeWhere((key, value) {
    if (null == value) return true;
    if (value is Map) {
      removeMapNull(value);
    }
    if (value is List) {
      for (var j in value) {
        if (j is Map) {
          removeMapNull(j);
        }
      }
    }
    return false;
  });
}
