
import 'package:kayo_package/kayo_package_utils.dart';
import 'package:kayo_package/utils/base_time_utils.dart';

extension BaseDateTimeExtension on DateTime? {
  String toTimeStr({String? format, String? defaultTime, bool tz = false}) {
    try {
      if (null != this) {
        var seconds = this!.millisecondsSinceEpoch;
        if (tz) {
          var replaceAll = BaseTimeUtils.timestampToTimeStr(
              seconds, format: format).replaceAll(" ", "T");
          return "${replaceAll}Z";
        } else {
          return BaseTimeUtils.timestampToTimeStr(seconds, format: format);
        }
      }
      return defaultTime ?? KayoPackage.share.nullText;
    } catch (e) {
      print(e);
      return defaultTime ?? KayoPackage.share.nullText;
    }
  }
}