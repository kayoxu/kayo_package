import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';

///
///  kayo_package
///  map_utils.dart
///
///  Created by kayoxu on 2021/9/6 at 4:50 下午
///  Copyright © 2021 kayoxu. All rights reserved.
///
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  static void showMapNavi(
      BuildContext context, double latitude, double longitude) async {
    List<Widget> list = [];
    if (await _canGotoAppleMap(longitude, latitude) == true && Platform.isIOS) {
      var a = AlertSheet.sheetAction(
          text: _appMapTitle(),
          color: BaseColorUtils.colorAccent,
          showLine: true,
          callback: () async {
            Navigator.of(context).pop();
            _gotoAppleMap(longitude, latitude);
          });

      list.add(a);
    }
    if (await _canGoogleAppleMap(longitude, latitude) == true) {
      var a = AlertSheet.sheetAction(
          text: _googleMapTitle(),
          color: BaseColorUtils.colorAccent,
          showLine: true,
          callback: () async {
            Navigator.of(context).pop();
            _gotoGoogleMap(longitude, latitude);
          });

      list.add(a);
    }
    if (await _canGotoBaiduMap(longitude, latitude) == true) {
      var a = AlertSheet.sheetAction(
          text: _baimapTitle(),
          color: BaseColorUtils.colorAccent,
          showLine: true,
          callback: () async {
            Navigator.of(context).pop();
            _gotoBaiduMap(longitude, latitude);
          });

      list.add(a);
    }
    if (await _canGotoAMap(longitude, latitude) == true) {
      var a = AlertSheet.sheetAction(
          text: _amapTitle(),
          color: BaseColorUtils.colorAccent,
          showLine: true,
          callback: () async {
            Navigator.of(context).pop();
            _gotoAMap(longitude, latitude);
          });

      list.add(a);
    }
    if (await _canGotoTencentMap(longitude, latitude) == true) {
      var a = AlertSheet.sheetAction(
          text: _qqmapTitle(),
          color: BaseColorUtils.colorAccent,
          showLine: true,
          callback: () async {
            Navigator.of(context).pop();
            _gotoTencentMap(longitude, latitude);
          });

      list.add(a);
    }

    AlertSheet.sheet(context,
        title: _selectNav(),
        showCancel: true,
        cancelText: _cancelTitle(),
        cancelColor: BaseColorUtils.colorBlackLite,
        children: list);
  }

  static bool _notCn() => KayoPackage.share.locale!.languageCode != 'zh';

  static String _selectNav() => _notCn() ? 'Select navigation map' : '选择导航';

  static String _cancelTitle() => _notCn() ? 'Cancel' : '取消';

  static String _qqmapTitle() => _notCn() ? 'QQ Map' : '腾讯地图';

  static String _amapTitle() => _notCn() ? 'Gaode Map' : '高德地图';

  static String _baimapTitle() => _notCn() ? 'Baidu Map' : '百度地图';

  static String _appMapTitle() => _notCn() ? 'Apple Map' : '苹果地图';

  static String _googleMapTitle() => _notCn() ? 'Google Map' : '谷歌地图';

  static String _noMap(String name) =>
      _notCn() ? 'Not found $name~' : '未检测到$name~';

  static Future<bool> _canGotoAMap(longitude, latitude) async {
    var url =
        '${Platform.isAndroid ? 'android' : 'ios'}amap://navi?sourceApplication=amap&lat=$latitude&lon=$longitude&dev=0&style=2';
    return await canLaunch(url);
  }

  static Future<bool> _canGotoTencentMap(longitude, latitude) async {
    var url =
        'qqmap://map/routeplan?type=drive&fromcoord=CurrentLocation&tocoord=$latitude,$longitude&referer=IXHBZ-QIZE4-ZQ6UP-DJYEO-HC2K2-EZBXJ';
    return await canLaunch(url);
  }

  static Future<bool> _canGotoBaiduMap(longitude, latitude) async {
    var url =
        'baidumap://map/direction?destination=$latitude,$longitude&coord_type=bd09ll&mode=driving';
    return await canLaunch(url);
  }

  static Future<bool> _canGotoAppleMap(longitude, latitude) async {
    var url = 'http://maps.apple.com/?&daddr=$latitude,$longitude';
    return await canLaunch(url);
  }

  static Future<bool> _canGoogleAppleMap(longitude, latitude) async {
    var url = 'google.navigation:q=$latitude,$longitude';
    return await canLaunch(url);
  }

  /// 高德地图
  static Future<bool> _gotoAMap(longitude, latitude) async {
    var url =
        '${Platform.isAndroid ? 'android' : 'ios'}amap://navi?sourceApplication=amap&lat=$latitude&lon=$longitude&dev=0&style=2';

    bool canLaunchUrl = await canLaunch(url);

    if (!canLaunchUrl) {
      LoadingUtils.showInfo(data: _noMap(_amapTitle()));
      return false;
    }

    await launch(url);

    return true;
  }

  /// 腾讯地图
  static Future<bool> _gotoTencentMap(longitude, latitude) async {
    var url =
        'qqmap://map/routeplan?type=drive&fromcoord=CurrentLocation&tocoord=$latitude,$longitude&referer=IXHBZ-QIZE4-ZQ6UP-DJYEO-HC2K2-EZBXJ';

    bool canLaunchUrl = await _canGotoTencentMap(longitude, latitude);

    if (!canLaunchUrl) {
      LoadingUtils.showInfo(data: _noMap(_qqmapTitle()));
      return false;
    }

    await launch(url);

    return canLaunchUrl;
  }

  /// 百度地图
  static Future<bool> _gotoBaiduMap(longitude, latitude) async {
    var url =
        'baidumap://map/direction?destination=$latitude,$longitude&coord_type=bd09ll&mode=driving';

    bool canLaunchUrl = await canLaunch(url);

    if (!canLaunchUrl) {
      LoadingUtils.showInfo(data: _noMap(_baimapTitle()));
      return false;
    }

    await launch(url);

    return canLaunchUrl;
  }

  /// 苹果地图
  static Future<bool> _gotoAppleMap(longitude, latitude) async {
    var url = 'http://maps.apple.com/?&daddr=$latitude,$longitude';

    bool canLaunchUrl = await canLaunch(url);

    if (!canLaunchUrl) {
      LoadingUtils.showInfo(data: _noMap(_amapTitle()));
      return false;
    }

    return await launch(url);
  }

  /// 谷歌地图
  static Future<bool> _gotoGoogleMap(longitude, latitude) async {
    var url = 'google.navigation:q=$latitude,$longitude';
    bool canLaunchUrl = await canLaunch(url);
    if (!canLaunchUrl) {
      LoadingUtils.showInfo(data: _noMap(_amapTitle()));
      return false;
    }

    return await launch(url);
  }
}
