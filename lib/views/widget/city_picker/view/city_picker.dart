import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';

import '../city_picker.dart';
import '../listener/item_listener.dart';
import '../model/tab.dart';
import '../view/item_widget.dart';
import 'inherited_widget.dart';
import 'layout_delegate.dart';
import 'package:flutter/widgets.dart';
import 'package:mpcore/mpcore.dart';

/// 省市区选择器
///
/// 从服务器获取数据
///
class CityPickerWidget extends StatefulWidget {
  ///选中的
  final List<City>? selectedList;

  /// 组件高度
  final double? height;

  /// 标题高度
  final double? titleHeight;

  /// 顶部圆角
  final double? corner;

  /// 左边间距
  final double? paddingLeft;

  /// 标题样式
  final Widget? titleWidget;

  /// 标题样式
  final Widget? okWidget;

  /// 关闭图标组件
  final Widget? closeWidget;

  /// tab 高度
  final double? tabHeight;

  /// 是否启用街道
  final bool? enableStreet;

  /// 是否显示 indicator
  final bool? showTabIndicator;

  /// indicator 颜色
  final Color? tabIndicatorColor;

  /// indicator 高度
  final double? tabIndicatorHeight;

  /// label 文字大小
  final double? labelTextSize;

  /// 选中 label 颜色
  final Color? selectedLabelColor;

  /// 未选中 label 颜色
  final Color? unselectedLabelColor;

  /// item 头部高度
  final double? itemHeadHeight;

  /// item 头部背景颜色
  final Color? itemHeadBackgroundColor;

  /// item 头部分割线颜色
  final Color? itemHeadLineColor;

  /// item 头部分割线高度
  final double? itemHeadLineHeight;

  /// item 头部文字样式
  final TextStyle? itemHeadTextStyle;

  /// item 高度
  final double? itemHeight;

  /// 索引组件宽度
  final double? indexBarWidth;

  /// 索引组件 item 高度
  final double? indexBarItemHeight;

  /// 索引组件背景颜色
  final Color? indexBarBackgroundColor;

  /// 索引组件文字样式
  final TextStyle? indexBarTextStyle;

  /// 选中城市的图标组件
  final Widget? itemSelectedIconWidget;

  /// 选中城市文字样式
  final TextStyle? itemSelectedTextStyle;

  /// 未选中城市文字样式
  final TextStyle? itemUnSelectedTextStyle;

  /// 监听事件
  final LinkagePickerListener? cityPickerListener;

  CityPickerWidget({
    this.selectedList,
    this.height,
    this.titleHeight,
    this.corner,
    this.paddingLeft,
    this.titleWidget,
    this.okWidget,
    this.closeWidget,
    this.tabHeight,
    this.enableStreet,
    this.showTabIndicator,
    this.tabIndicatorColor,
    this.tabIndicatorHeight,
    this.labelTextSize,
    this.selectedLabelColor,
    this.unselectedLabelColor,
    this.itemHeadHeight,
    this.itemHeadBackgroundColor,
    this.itemHeadLineColor,
    this.itemHeadLineHeight,
    this.itemHeadTextStyle,
    this.itemHeight,
    this.indexBarWidth,
    this.indexBarItemHeight,
    this.indexBarBackgroundColor,
    this.indexBarTextStyle,
    this.itemSelectedIconWidget,
    this.itemSelectedTextStyle,
    this.itemUnSelectedTextStyle,
    required this.cityPickerListener,
  });

  @override
  State<StatefulWidget> createState() => CityPickerState();
}

class CityPickerState extends State<CityPickerWidget>
    with TickerProviderStateMixin
    implements ItemClickListener {
  LinkagePickerListener? _cityPickerListener;

  MPMainTabController? _tabController;
  MPPageController? _pageController;

  List<TabTitle> _myTabs = [
    TabTitle(index: 0, title: "请选择", city: null),
  ];

  List<City> _cities = [];

  @override
  void initState() {
    super.initState();

    // if (null != widget.selectedList && widget.selectedList!.length > 0) {
    //   _cities = widget.selectedList!;
    //   _myTabs = widget.selectedList!.map((e) => TabTitle(index: 0, title: e.name, city: e)).toList();
    // }

    _tabController = MPMainTabController();
    _pageController = MPPageController();

    _cityPickerListener = widget.cityPickerListener;
  }

  @override
  void dispose() {
    if (mounted) {
      _tabController?.dispose();
      _pageController?.dispose();
    }
    super.dispose();
  }

  @override
  void onItemClick(int? tabIndex, City? city) {
    if (_cities.length - 1 < tabIndex!) {
      _cities.insert(tabIndex, city!);
    } else {
      _cities[tabIndex] = city!;
    }

    _myTabs = [];
    for (int i = 0; i < tabIndex + 2; i++) {
      if (i == tabIndex + 1) {
        _myTabs.add(TabTitle(index: i, title: "请选择", city: city));
      } else {
        _myTabs.add(TabTitle(index: i, title: _cities[i].name, city: null));
      }
    }

    _tabController = MPMainTabController();
    _pageController!.jumpToPage(tabIndex + 1);
    // _tabController!.animateTo(tabIndex + 1);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final route = CustomInheritedWidget.of(context)!.router;
    return Container();
    // return AnimatedBuilder(
    //   animation: route.animation!,
    //   builder: (BuildContext context, Widget? child) =>
    //       CustomSingleChildLayout(
    //           delegate: CustomLayoutDelegate(
    //               progress: route.animation!.value, height: widget.height),
    //           child: GestureDetector(
    //             child: Material(
    //                 color: Colors.transparent,
    //                 child: Container(
    //                     width: double.infinity,
    //                     child: Column(children: <Widget>[
    //                       _topTextWidget(),
    //                       // LineView(
    //                       //   height: .5,
    //                       //   color: BaseColorUtils
    //                       //       .darkWindow(context: context)
    //                       //       .dark,
    //                       // ),
    //                       Expanded(
    //                         child: Column(children: <Widget>[
    //                           _middleTabWidget(),
    //                           Expanded(child: _bottomListWidget())
    //                         ]),
    //                       )
    //                     ]))),
    //           )),
    // );
  }

  /// 头部文字组件
  Widget _topTextWidget() {
    return Container(
      height: widget.titleHeight,
      decoration: BoxDecoration(
          color: BaseColorUtils.colorWindowWhite,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(widget.corner!),
              topRight: Radius.circular(widget.corner!))),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
                onTap: () => {Navigator.pop(context)},
                child: Container(
                  width: 100,
                  padding: EdgeInsets.only(left: widget.paddingLeft!),
                  alignment: Alignment.centerLeft,
                  height: double.infinity,
                  child: widget.closeWidget ?? MPIcon(
                      MaterialIcons.close, size: 26),
                )),
            widget.titleWidget ??
                Container(
                  padding: EdgeInsets.only(left: widget.paddingLeft!),
                  child: Text(
                    'Select',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            GestureDetector(
              child: Container(
                width: 100,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: widget.paddingLeft!),
                child: widget.okWidget ??
                    Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              ),
              onTap: () {
                _cityPickerListener?.onFinish.call(_cities);
                Navigator.pop(context);
              },
            ),
          ]),
    );
  }

  /// 中间 tab 组件
  Widget _middleTabWidget() {
    return Container(
      width: double.infinity,
      height: widget.tabHeight,
      color: BaseColorUtils.colorWindowWhite,
      // child: TabBar(
      //   controller: _tabController,
      //   onTap: (index) {
      //     _pageController!.jumpToPage(index);
      //   },
      //   isScrollable: true,
      //   indicatorSize: TabBarIndicatorSize.tab,
      //   // labelPadding: EdgeInsets.only(left: widget.paddingLeft!),
      //   indicator: widget.showTabIndicator!
      //   // ? UnderlineTabIndicator(
      //   //     insets: EdgeInsets.only(left: widget.paddingLeft!),
      //   //     borderSide: BorderSide(
      //   //         width: widget.tabIndicatorHeight!,
      //   //         color: widget.tabIndicatorColor ??
      //   //             Theme.of(context).primaryColor),
      //   //   )
      //       ? IUnderlineTabIndicator(
      //       color:
      //       widget.tabIndicatorColor ?? Theme
      //           .of(context)
      //           .primaryColor)
      //       : BoxDecoration(),
      //   indicatorColor:
      //   widget.tabIndicatorColor ?? Theme
      //       .of(context)
      //       .primaryColor,
      //   unselectedLabelColor: widget.unselectedLabelColor ?? Colors.black54,
      //   labelColor: widget.selectedLabelColor ?? Theme
      //       .of(context)
      //       .primaryColor,
      //   tabs: _myTabs.map((data) {
      //     return Text(data.title!,
      //         style: TextStyle(fontSize: widget.labelTextSize));
      //   }).toList(),
      // ),
    );
  }

  /// 底部城市列表组件
  Widget _bottomListWidget() {
    return MPPageView(
      controller: _pageController,
      // onPageChanged: (index) {
      //   _tabController!.animateTo(index);
      // },
      children: _myTabs.map((tab) {
        return ItemWidget(
          index: tab.index,
          parentData: tab.city,
          paddingLeft: widget.paddingLeft,
          itemHeadHeight: widget.itemHeadHeight,
          itemHeadBackgroundColor: widget.itemHeadBackgroundColor,
          itemHeadLineColor: widget.itemHeadLineColor,
          itemHeadLineHeight: widget.itemHeadLineHeight,
          itemHeadTextStyle: widget.itemHeadTextStyle,
          itemHeight: widget.itemHeight,
          indexBarWidth: widget.indexBarWidth,
          indexBarItemHeight: widget.indexBarItemHeight,
          indexBarBackgroundColor: widget.indexBarBackgroundColor,
          indexBarTextStyle: widget.indexBarTextStyle,
          itemSelectedIconWidget: widget.itemSelectedIconWidget,
          itemSelectedTextStyle: widget.itemSelectedTextStyle,
          itemUnSelectedTextStyle: widget.itemUnSelectedTextStyle,
          cityPickerListener: widget.cityPickerListener,
          itemClickListener: this,
          emptyDataCallBack: (data) {
            if (_myTabs.length > 1) {
              _myTabs.removeLast();
              _tabController = MPMainTabController();
              _pageController!.jumpToPage(_myTabs.length - 1);
              // _tabController!.animateTo(_myTabs.length - 1);
              if (mounted) {
                setState(() {});
              }
            }
          },
        );
      }).toList(),
    );
  }
}
