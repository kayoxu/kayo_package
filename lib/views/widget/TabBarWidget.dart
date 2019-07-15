import 'package:flutter/material.dart';
import 'package:kayo_package/utils/BaseColorUtils.dart';
 
///支持顶部和顶部的TabBar控件
///配合AutomaticKeepAliveClientMixin可以keep住
class TabBarWidget extends StatefulWidget {
  ///底部模式type
  static const int BOTTOM_TAB = 1;

  ///顶部模式type
  static const int TOP_TAB = 2;

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
    if (this.widget.type == TabBarWidget.TOP_TAB) {
      ///顶部tab bar
      return new Scaffold(
        floatingActionButton: widget.floatingActionButton,
        persistentFooterButtons: widget.tarWidgetControl == null
            ? []
            : widget.tarWidgetControl.footerButton,
        appBar: AppBar(
          elevation: 0.5,
          backgroundColor: BaseColorUtils.colorWindowWhite,
          title: widget.title,
          bottom: new TabBar(
            controller: _tabController,
            tabs: widget.tabItems,
            indicatorColor: widget.indicatorColor,
            indicator: null,
          ),
        ),
        body: new PageView(
          controller: widget.topPageControl,
          children: widget.tabViews,
          onPageChanged: (index) {
            _tabController.animateTo(index);
            widget.onPageChanged?.call(index);
          },
        ),
      );
    } else {
      ///底部tab bar
      return new Scaffold(
        backgroundColor: BaseColorUtils.colorWindow,
          drawer: widget.drawer,
          appBar: widget.appBar,
          body: TabBarView(
              //TabBarView呈现内容，因此放到Scaffold的body中
              controller: _tabController, //配置控制器
              children: widget.tabViews),
          bottomNavigationBar: Material(
            //为了适配主题风格，包一层Material实现风格套用
            color: BaseColorUtils.colorWindow, //底部导航栏主题颜色
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.only(top: 3),
                decoration: BoxDecoration(
//                  color: const Color(0xFFF0F0F0),
                  color: const Color(0xFFFFFFFF),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: const Color(0xFFd0d0d0),
                      blurRadius: 0.5,
                      spreadRadius:  0.5,
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
    }
  }
}

class TarWidgetControl {
  List<Widget> footerButton = [];
}
