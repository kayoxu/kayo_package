import 'package:flutter/material.dart';
import 'package:kayo_package/bean/home_page_item.dart';
import 'package:kayo_package/utils/base_color_utils.dart';
import 'package:kayo_package/views/common/404.dart';
import 'package:mpcore/mpkit/mpkit.dart';

///支持顶部和顶部的TabBar控件
///配合AutomaticKeepAliveClientMixin可以keep住
class TabBarWidget extends StatefulWidget {
  final List<HomePageItem>? tabItems;

  final Color? backgroundColor;

  final Widget? title;

  final int? initialIndex;

  final bool? keepAlive;

  TabBarWidget({
    Key? key,
    this.tabItems,
    this.backgroundColor,
    this.title,
    this.initialIndex = 0,
    this.keepAlive,
  }) : super(key: key);

  @override
  TabBarWidgetState createState() => new TabBarWidgetState();
}

class TabBarWidgetState extends State<TabBarWidget>
    with SingleTickerProviderStateMixin {
  MPMainTabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = MPMainTabController();
  }

  ///整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var tbl = widget.tabItems?.length ?? 0;
    if (tbl == 0) {
      return WidgetNotFound(
        backClick: () {
          Navigator.of(context).pop();
        },
      );
    } else if (tbl == 1) {
      return widget.tabItems![0].page ?? Container();
    } else {
      return MPMainTabView(
          controller: _tabController,
          keepAlive: widget.keepAlive ?? false,
          tabs: (widget.tabItems ?? []).map((e) {
            return MPMainTabItem(
                activeTabWidget: Container(
                  width: 44,
                  height: 44,
                  child: _renderIcon(
                      icon: e.getTabImage(normal: false),
                      title: e.tabName,
                      actived: true),
                ),
                inactiveTabWidget: Container(
                  width: 44,
                  height: 44,
                  child: _renderIcon(
                    icon: e.getTabImage(normal: true),
                    title: e.tabName,
                    actived: false,
                  ),
                ),
                builder: (context) {
                  return e.page!;
                });
          }).toList());
    }
  }

  Widget _renderIcon({
    required Widget icon,
    required String title,
    required bool actived,
  }) {
    return Column(
      children: [
        icon,
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: actived
                ? BaseColorUtils.colorAccent
                : BaseColorUtils.colorBlackLiteLite,
          ),
        ),
      ],
    );
  }
}
