import 'package:flutter/material.dart';

extension BaseObjectExtension on Object {
  T defaultValue<T>({required T data}) {
    if (null == this || this is! T) {
      return data;
    } else {
      return this as T;
    }
  }

  int defaultInt({int data = 0}) {
    if (null == this || this is! int) {
      if(this is double){
        return (this as double).toInt();
      }
      return data;
    } else {
      return this as int;
    }
  }

  String defaultStr({String data = '无'}) {
    if (null == this || '' == this || this is! String) {
      if (this is num) {
        return this.toString();
      }
      return data;
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
}
