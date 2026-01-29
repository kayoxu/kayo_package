import 'dart:convert';
import '../kayo_package.dart';

extension BaseObjectExtension on Object? {
  /// Returns [data] if this object is null or not of type [T].
  T defaultValue<T>({required T data}) {
    if (this == null || this is! T) {
      return data;
    }
    return this as T;
  }

  /// Returns [data] (default 0) if this object is null or not an int.
  /// Handles double to int conversion.
  int defaultInt({int data = 0}) {
    if (this == null) return data;
    if (this is int) return this as int;
    if (this is double) return (this as double).toInt();
    if (this is String) return int.tryParse(this as String) ?? data;
    return data;
  }

  /// Returns [data] (default KayoPackage.share.nullText) if this object is null or empty string.
  /// Handles num to String conversion.
  String defaultStr({String? data}) {
    if (this == null) return data ?? KayoPackage.share.nullText;
    if (this is String) {
      final s = this as String;
      return s.isEmpty ? (data ?? KayoPackage.share.nullText) : s;
    }
    if (this is num) return toString();
    return data ?? KayoPackage.share.nullText;
  }

  /// Returns [data] (default 0.0) if this object is null or not a double.
  /// Handles int to double conversion.
  double defaultDouble({double data = 0.0}) {
    if (this == null) return data;
    if (this is double) return this as double;
    if (this is int) return (this as int).toDouble();
    if (this is String) return double.tryParse(this as String) ?? data;
    return data;
  }

  /// Returns the first element if this is a non-empty List, cast to [T].
  T? findFirst<T>() {
    if (this is List) {
      final list = this as List;
      if (list.isNotEmpty) {
        return list.first as T?;
      }
    }
    return null;
  }

  /// Returns the last element if this is a non-empty List, cast to [T].
  T? findLast<T>() {
    if (this is List) {
      final list = this as List;
      if (list.isNotEmpty) {
        return list.last as T?;
      }
    }
    return null;
  }

  /// Returns the element at [index] if this is a List and index is valid, cast to [T].
  T? findData<T>(int index) {
    if (this is List) {
      final list = this as List;
      if (index >= 0 && index < list.length) {
        return list[index] as T?;
      }
    }
    return null;
  }

  /// Serializes the object to JSON string, optionally removing null values from Map/List.
  String? toJson2({bool removeNull = true}) {
    if (this == null) return null;
    try {
      // 1. Convert to JSON object (Map/List/Primitive)
      // If it's already a String, try to decode it first to clean it, 
      // otherwise direct encode might be double encoding if the user passed a JSON string.
      // However, original logic was: if String -> use as is (unless decode fails?).
      // Original logic: if !String -> jsonEncode. Then json.decode(jsonStr).
      // This suggests the input 'this' could be a Dart Object (Map/List) OR a JSON String.
      
      dynamic jsonObject;
      if (this is String) {
        try {
           jsonObject = json.decode(this as String);
        } catch (e) {
           // Not a valid JSON string, treat as string value? 
           // Or maybe it was meant to be a raw string.
           // Original code: jsonStr = this! as String; then json.decode(jsonStr);
           // If decode failed, it would throw. So we maintain that behavior or improve.
           rethrow; 
        }
      } else {
        // It's a Map, List, or other object.
        // To safely handle deep structures, we can use jsonEncode to get a string, then decode.
        // This handles 'toJson()' methods on custom objects.
        // It is inefficient but robust for "cleaning" custom objects.
        jsonObject = json.decode(json.encode(this));
      }

      if (removeNull) {
        if (jsonObject is Map) {
          _removeMapNull(jsonObject);
        } else if (jsonObject is List) {
          _removeListNull(jsonObject);
        }
      }
      return json.encode(jsonObject);
    } catch (e) {
      // debugPrint('toJson2 error: $e');
      return null;
    }
  }

  /// Converts the object to a Map<String, dynamic>, optionally removing null values.
  Map<String, dynamic>? toJMap2({bool removeNull = true}) {
    if (this == null) return {};
    try {
      dynamic jsonObject;
      if (this is String) {
         jsonObject = json.decode(this as String);
      } else {
         jsonObject = json.decode(json.encode(this));
      }

      if (jsonObject is Map) {
        if (removeNull) {
          _removeMapNull(jsonObject);
        }
        return Map<String, dynamic>.from(jsonObject);
      }
      return {};
    } catch (e) {
      return {};
    }
  }
}

void _removeMapNull(Map<dynamic, dynamic> map) {
  map.removeWhere((key, value) {
    if (value == null) return true;
    if (value is Map) {
      _removeMapNull(value);
      // Optional: remove empty maps? Original didn't.
    } else if (value is List) {
      _removeListNull(value);
    }
    return false;
  });
}

void _removeListNull(List<dynamic> list) {
  for (var element in list) {
    if (element is Map) {
      _removeMapNull(element);
    } else if (element is List) {
      _removeListNull(element);
    }
  }
}
