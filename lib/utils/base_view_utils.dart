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
      String msg = 'No Data',
      EdgeInsets? margin,
      Color? msgColor,
      double? msgSize,
      double? width,
      double? height,
      double marginImageTop = 0}) {
    return Container(
      alignment: Alignment.topCenter,
      margin: null == margin ? EdgeInsets.only(top: 60) : margin,
      child: Column(
        // alignment: Alignment.center,
        children: <Widget>[
          ImageView(
            src: source(src ?? 'ic_no_data'),
            margin: EdgeInsets.only(bottom: marginImageTop),
            width: width ?? 120,
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
