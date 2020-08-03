import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kayo_package/kayo_package.dart';
import 'package:kayo_package/utils/base_color_utils.dart';

///支持顶部和顶部的TabBar控件
///配合AutomaticKeepAliveClientMixin可以keep住
class TabBarWidget extends StatefulWidget {
  ///底部模式type
  static const int BOTTOM_TAB = 1;

  ///顶部模式type
  static const int TOP_TAB = 2;

  ///
  static const int HIDE_TAB = 3;

  final int type;

  final List<Widget> tabItems;

  final List<Widget> tabViews;

  final Color backgroundColor;

  final Color indicatorColor;

  final Widget title;

  final Widget drawer;

  final PreferredSizeWidget appBar;

  final Widget floatingActionButton;

  final TarWidgetControl tarWidgetControl;

  final PageController topPageControl;

  final ValueChanged<int> onPageChanged;

  final ValueChanged<int> onTabChanged;

  final int initialIndex;

  final bool animate;
  final bool scrollable;
  final bool showBack;
  final bool centerTitle;
  final bool darkStatusText;
  final double elevation;
  final String titleStr;
  final List<Widget> actions;
  final bool showLine;
  final Color bgColor;

  TabBarWidget({
    Key key,
    this.type,
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
    this.elevation,
    this.titleStr,
    this.actions,
    this.darkStatusText = true,
    this.showLine = true,
    this.bgColor = const Color(0xffffffff),
  }) : super(key: key);

  @override
  TabBarWidgetState createState() => new TabBarWidgetState();
}

class TabBarWidgetState extends State<TabBarWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  VoidCallback _tabControllerChangeCallBack;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      initialIndex: widget.initialIndex,
      length: widget.tabItems.length,
    );
    _tabControllerChangeCallBack = () {
      if (!_tabController.indexIsChanging) {
        int _index = _tabController.index;
        this.widget.onPageChanged(_index);
      }
    };

    _tabController.addListener(_tabControllerChangeCallBack);
  }

  ///整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
//    _tabController.removeListener(_tabControllerChangeCallBack);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate) {
      _tabController.animateTo(widget.initialIndex);
    } else {
      _tabController.index = widget.initialIndex;
    }

    if (this.widget.type == TabBarWidget.TOP_TAB) {
      ///顶部tab bar
      return new Scaffold(
        floatingActionButton: widget.floatingActionButton,
        persistentFooterButtons: widget.tarWidgetControl == null
            ? null
            : widget.tarWidgetControl.footerButton,
        appBar: AppBar(
          elevation: widget.elevation ?? 0.5,
          actions: widget.actions,
          backgroundColor: BaseColorUtils.colorWindowWhite,
          centerTitle: widget.centerTitle,
          leading: widget.showBack == true
              ? IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                  ),
                  iconSize: 22,
                  color: Color(widget.darkStatusText ? 0xff50525c : 0xffffffff),
                  onPressed: () async {
                    if (Navigator.canPop(context)) {
                      return Navigator.of(context).pop();
                    } else {
                      return await SystemNavigator.pop();
                    }
                  }, // null disables the button
                )
              : null,
          brightness:
              widget.darkStatusText ? Brightness.light : Brightness.dark,
          title: widget.title ??
              Text(
                widget.titleStr,
                style: TextStyle(
                    color: widget.darkStatusText
                        ? BaseColorUtils.colorBlack
                        : BaseColorUtils.white),
                textAlign: TextAlign.center,
              ),
          bottom: new TabBar(
            controller: _tabController,
            tabs: widget.tabItems,
            indicatorColor: widget.indicatorColor,
            indicator: null,
            onTap: widget.onTabChanged,
          ),
        ),
        body: new PageView(
          controller: widget.topPageControl,
          children: widget.tabViews,
          onPageChanged: (index) {
            if (widget.animate) {
              _tabController.animateTo(index);
            } else {
              _tabController.index = index;
            }
            widget.onPageChanged?.call(index);
          },
        ),
      );
    } else if (this.widget.type == TabBarWidget.BOTTOM_TAB) {
      ///底部tab bar
      return new Scaffold(
          backgroundColor: BaseColorUtils.colorWindow,
          drawer: widget.drawer,
          appBar: widget.appBar,
          body: TabBarView(
              //TabBarView呈现内容，因此放到Scaffold的body中
              physics:
                  widget.scrollable ? null : NeverScrollableScrollPhysics(),
              controller: _tabController, //配置控制器
              children: widget.tabViews),
          bottomNavigationBar: Material(
            //为了适配主题风格，包一层Material实现风格套用
            color: widget.bgColor ?? BaseColorUtils.colorWindow, //底部导航栏主题颜色
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.only(top: 3),
                decoration: BoxDecoration(
//                  color: const Color(0xFFF0F0F0),
                  color: const Color(0xFFFFFFFF),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: widget.showLine == true
                          ? const Color(0xFFd0d0d0)
                          : widget.bgColor,
                      blurRadius: 0.5,
                      spreadRadius: 0.5,
//                      offset: Offset(-1, -1), //-1,-1
                    ),
                  ],
                ),
                child: TabBar(
//                  unselectedLabelStyle: TextStyle(fontSize: 14),
//                  labelStyle: TextStyle(fontSize: 14),
                  controller: _tabController,
//                  indicatorColor: const Color(0xFFF0F0F0),
                  indicatorColor: const Color(0xFFFFFFFF),
                  //tab标签的下划线颜色
                  // labelColor: const Color(0xFF000000),
                  indicatorWeight: .5,
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: const Color(0xFF8E8E8E),
                  isScrollable: false,
                  tabs: widget.tabItems,
                ),
              ),
            ),
          ));
    } else {
      ///隐藏Tab
      return BaseSysUtils.empty(widget.tabViews)
          ? WidgetNotFound()
          : Scaffold(
              backgroundColor: BaseColorUtils.colorWindow,
              drawer: widget.drawer,
              appBar: widget.appBar,
              body: widget.tabViews[0]);
    }
  }
}

class TarWidgetControl {
  List<Widget> footerButton = [];
}
