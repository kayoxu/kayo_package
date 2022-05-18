import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kayo_package/kayo_package.dart';
import 'package:kayo_package/utils/base_color_utils.dart';

///支持顶部和顶部的TabBar控件
///配合AutomaticKeepAliveClientMixin可以keep住
class TabBarWidgetAllowDark extends StatefulWidget {
  final List<Widget>? tabItems;

  final List<Widget>? tabViews;

  final Color? backgroundColor;

  final Color? indicatorColor;

  final Widget? title;

  final Widget? drawer;

  final PreferredSizeWidget? appBar;

  final Widget? floatingActionButton;

  final TarWidgetControl? tarWidgetControl;

  final PageController? topPageControl;

  final ValueChanged<int>? onPageChanged;

  final ValueChanged<int>? onTabChanged;

  final int? initialIndex;

  final bool? animate;
  final bool? scrollable;
  final bool? showBack;
  final bool? centerTitle;
  final bool? darkStatusText;
  final double? elevation;
  final String? titleStr;
  final List<Widget>? actions;
  final bool? showLine;
  final Color? bgColor;
  final Function()? backClick;
  final bool? resizeToAvoidBottomInset;
  final bool? safeArea;

  TabBarWidgetAllowDark({
    Key? key,
    this.tabItems,
    this.tabViews,
    this.backgroundColor,
    this.indicatorColor,
    this.title,
    this.drawer,
    this.appBar,
    this.floatingActionButton,
    this.tarWidgetControl,
    this.topPageControl,
    this.onPageChanged,
    this.onTabChanged,
    this.initialIndex = 0,
    this.animate = true,
    this.scrollable = true,
    this.showBack = false,
    this.centerTitle = false,
    this.safeArea = true,
    this.elevation,
    this.titleStr,
    this.actions,
    this.backClick,
    this.darkStatusText = true,
    this.showLine = true,
    this.bgColor,
    this.resizeToAvoidBottomInset = true,
  }) : super(key: key);

  @override
  TabBarWidgetAllowDarkState createState() => new TabBarWidgetAllowDarkState();
}

class TabBarWidgetAllowDarkState extends State<TabBarWidgetAllowDark>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  PageController? _pageController;

  VoidCallback? _tabControllerChangeCallBack;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      initialIndex: widget.initialIndex ?? 0,
      length: widget.tabItems?.length ?? 0,
    );

    _pageController = PageController(initialPage: widget.initialIndex ?? 0);

    _tabControllerChangeCallBack = () {
      if (true != _tabController?.indexIsChanging) {
        int _index = _tabController?.index ?? 0;
        this.widget.onPageChanged?.call(_index);
        if ((_pageController?.hasClients == true) &&
            _index != (_pageController?.page ?? 0)) {
          _pageController?.animateToPage(_index,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOutQuint);
        }
      }
    };
    _tabController?.addListener(_tabControllerChangeCallBack!);
  }

  ///整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
//    _tabController.removeListener(_tabControllerChangeCallBack);
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate == true) {
      _tabController?.animateTo(widget.initialIndex ?? 0);
    } else {
      _tabController?.index = widget.initialIndex ?? 0;
    }

    var tabBar = TabBar(
//                  unselectedLabelStyle: TextStyle(fontSize: 14),
//                  labelStyle: TextStyle(fontSize: 14),
      controller: _tabController,
      indicatorColor: const Color(0x0fff),
//                   indicatorColor: const Color(0xFFFFFFFF),
      //tab标签的下划线颜色
      // labelColor: const Color(0xFF000000),
      indicatorWeight: .5,
      labelColor: Theme.of(context).primaryColor,
      unselectedLabelColor: const Color(0xfff),
      isScrollable: false,
      tabs: widget.tabItems ?? [],
    );
    return Scaffold(
        backgroundColor: widget.backgroundColor,
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        drawer: widget.drawer,
        appBar: widget.appBar,
        body: TabBarView(
            //TabBarView呈现内容，因此放到Scaffold的body中
            physics: widget.scrollable == true
                ? null
                : NeverScrollableScrollPhysics(),
            controller: _tabController, //配置控制器
            children: widget.tabViews ?? []),
        bottomNavigationBar: Material(
          //为了适配主题风格，包一层Material实现风格套用
          color: widget.bgColor, //底部导航栏主题颜色
          child: widget.safeArea == true
              ? SafeArea(
                  child: tabBar,
                )
              : tabBar,
        ));
  }
}
