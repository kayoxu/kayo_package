import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';

/**
 *  smart_lock_flutter
 *  utils
 *
 *  Created by kayoxu on 2019-09-04 11:40.
 *  Copyright © 2019 kayoxu. All rights reserved.
 */
class BaseViewUtils {
  static Widget noData(
      {String src, String msg = 'No Data', EdgeInsets margin}) {
    return Container(
      alignment: Alignment.topCenter,
      margin: null == margin ? EdgeInsets.only(top: 60) : margin,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          ImageView(
            src: source(src ?? 'ic_no_data'),
            width: 120,
            height: 120,
          ),
          Positioned(
            child: TextView(msg ?? '',color: BaseColorUtils.colorGreyLite,),
            bottom: 0,
          )
        ],
      ),
    );
  }
}