import 'package:flutter/material.dart';
import 'package:kayo_package/views/widget/base/image_view.dart';

///
///  flutter_ticket
///  home_page_item.dart
///
///  Created by kayoxu on 2020/6/11 at 5:11 PM
///  Copyright © 2020 kayoxu. All rights reserved.
///

class HomePageItem {
  int index;
  String tabName = '';
  String tabImage1 = '';
  String tabImage2 = '';
  Widget? page;
  String? desc;
  Function()? gotoPage;

  HomePageItem(
      {required this.index,
      required this.tabName,
      required this.tabImage1,
      required this.tabImage2,
      this.page,
      this.gotoPage,
      @required this.desc});

  ImageView getTabImage({required bool normal}) {
    return ImageView(
      src: source('${normal == true ? tabImage2 : tabImage1}'),
      width: 23,
      fit: BoxFit.fitHeight,
      margin: EdgeInsets.only(bottom: 2),
//      color: Color(normal == true ? 0xffA1A2A4 : 0xff4385FF),
      height: 23,
    );
  }
}
