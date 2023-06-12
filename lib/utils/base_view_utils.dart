import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';

///  smart_lock_flutter
///  utils
///
///  Created by kayoxu on 2019-09-04 11:40.
///  Copyright © 2019 kayoxu. All rights reserved.
class BaseViewUtils {
  static Widget noData(
      {String? src,
      String? msg = 'No Data',
      EdgeInsets? margin,
      Color? msgColor,
      double? msgSize,
      double? width,
      double? height,
      double? marginImageTop = 0}) {
    return Container(
      alignment: Alignment.topCenter,
      margin: null == margin ? EdgeInsets.only(top: 60) : margin,
      child: Column(
        // alignment: Alignment.center,
        children: <Widget>[
          ImageView(
            src: BaseSysUtils.empty(src)
                ? 'packages/kayo_package/assets/ic_no_data.png'
                : source(src!),
            margin: EdgeInsets.only(bottom: marginImageTop ?? 0),
            width: width ?? 219,
            height: height ?? 120,
            fit: BoxFit.fitWidth,
          ),
          TextView(
            msg ?? '',
            size: msgSize ?? 13,
            margin: EdgeInsets.only(top: 4),
            color: msgColor ?? BaseColorUtils.colorBlackLiteLite,
          )
        ],
      ),
    );
  }
}
