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
          text: '苹果地图',
          color: BaseColorUtils.colorAccent,
          showLine: true,
          callback: () async {
            Navigator.of(context).pop();
            _gotoAppleMap(longitude, latitude);
          });

      list.add(a);
    }
    if (await _canGotoBaiduMap(longitude, latitude) == true) {
      var a = AlertSheet.sheetAction(
          text: '百度地图',
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
          text: '高德地图',
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
          text: '腾讯地图',
          color: BaseColorUtils.colorAccent,
          showLine: true,
          callback: () async {
              Navigator.of(context).pop();
            _gotoTencentMap(longitude, latitude);
          });

      list.add(a);
    }

    AlertSheet.sheet(context,
        title: '选择导航',
        showCancel: true,
        cancelText: '取消',
        cancelColor: BaseColorUtils.colorBlackLite,
        children: list);
  }

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

  /// 高德地图
  static Future<bool> _gotoAMap(longitude, latitude) async {
    var url =
        '${Platform.isAndroid ? 'android' : 'ios'}amap://navi?sourceApplication=amap&lat=$latitude&lon=$longitude&dev=0&style=2';

    bool canLaunchUrl = await canLaunch(url);

    if (!canLaunchUrl) {
      LoadingUtils.showInfo(data: '未检测到高德地图~');
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
      LoadingUtils.showInfo(data: '未检测到腾讯地图~');
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
      LoadingUtils.showInfo(data: '未检测到百度地图~');
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
      LoadingUtils.showInfo(data: '打开失败~');
      return false;
    }

    return await launch(url);
  }
}
