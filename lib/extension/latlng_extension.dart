import 'package:kayo_package/map/gps_utils.dart';

extension LatLngExtension on BaseLatLng? {
  BaseLatLng? bd092gcj02() {
    try {
      if (null != this) {
        List<num> data = GpsUtils.bd09_To_Gcj02(this!.lat!, this!.lng!);
        return BaseLatLng()
          ..lat = data[0].toDouble()
          ..lng = data[1].toDouble();
      }
      return this;
    } catch (e) {
      print(e);
      return this;
    }
  }
}

extension LatLngExtension2 on double? {
  double bd092gcj02({double? lat, double? lng}) {
    double? la = lat;
    double? ln = lng;

    try {
      if (null != this && 0 != this) {
        int type = -1;

        if ((lat ?? 0) == 0) {
          la = this;
          type = 0;
        }
        if ((lng ?? 0) == 0) {
          ln = this;
          type = 1;
        }

        if ((la ?? 0) == 0 || (ln ?? 0) == 0) {
          return this ?? 0;
        }

        List<num> data = GpsUtils.bd09_To_Gcj02(la!, ln!);

        if (type == 0 || type == 1) {
          return data[type].toDouble();
        }
      }
      return this ?? 0;
    } catch (e) {
      print(e);
      return this ?? 0;
    }
  }
}
