import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kayo_package/kayo_package.dart';
import 'package:kayo_package/utils/base_color_utils.dart';

///支持顶部和顶部的TabBar控件
///配合AutomaticKeepAliveClientMixin可以keep住
class TabBarWidgetAllowDark extends StatefulWidget {
  final List<BottomNavigationBarItem>? tabItems;

  final List<Widget>? tabViews;

  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;

  final Widget? drawer;

  final PreferredSizeWidget? appBar;

  final Widget? floatingActionButton;

  final int? initialIndex;

  final bool? animate;
  final bool? scrollable;
  final bool? centerTitle;
  final double? elevation;
  final List<Widget>? actions;
  final bool? resizeToAvoidBottomInset;

  TabBarWidgetAllowDark({
    Key? key,
    this.tabItems,
    this.tabViews,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.drawer,
    this.appBar,
    this.floatingActionButton,
    this.initialIndex = 0,
    this.animate = true,
    this.scrollable = true,
    this.centerTitle = false,
    this.elevation,
    this.actions,
    this.resizeToAvoidBottomInset = true,
  }) : super(key: key);

  @override
  TabBarWidgetAllowDarkState createState() => new TabBarWidgetAllowDarkState();
}

class TabBarWidgetAllowDarkState extends State<TabBarWidgetAllowDark>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageIndex = widget.initialIndex ?? 0;
  }

  ///整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: widget.backgroundColor,
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        drawer: widget.drawer,
        appBar: widget.appBar,
        floatingActionButton: widget.floatingActionButton,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(), // 禁止滑动
          controller: _pageController,
          onPageChanged: (int index) {
            setState(() {
              pageIndex = index;
            });
          },
          children: widget.tabViews ?? [],
        ),
        bottomNavigationBar: BottomNavigationBar(
          // backgroundColor: context.backgroundColor,
          items: widget.tabItems ?? [],
          type: BottomNavigationBarType.fixed,
          currentIndex: pageIndex,
          elevation: 5.0,
          iconSize: 21.0,
          selectedFontSize: 10.0,
          unselectedFontSize: 10.0,
          selectedItemColor: widget.selectedItemColor ?? Theme
              .of(context)
              .primaryColor,
          unselectedItemColor: widget.unselectedItemColor ?? Colors.grey,
          onTap: (index) =>
          widget.animate == true
              ? _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 100),
            curve: Curves.ease,
          )
              : _pageController.jumpToPage(index),
        ));
  }
}
