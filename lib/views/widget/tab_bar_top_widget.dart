import 'package:flutter/material.dart';
import 'package:kayo_package/bean/home_page_item.dart';
import 'package:kayo_package/kayo_package.dart';
import 'package:kayo_package/utils/base_color_utils.dart';
import 'package:kayo_package/views/common/404.dart';
import 'package:mpcore/mpkit/mpkit.dart';

///支持顶部和顶部的TabBar控件
///配合AutomaticKeepAliveClientMixin可以keep住
class TabBarTopWidget extends StatefulWidget {
  final List<HomePageItem>? tabItems;

  final Color? backgroundColor;

  final Widget? title;

  final int? initialIndex;

  final bool? keepAlive;

  final ValueChanged<int>? onPage;

  TabBarTopWidget({
    Key? key,
    this.tabItems,
    this.backgroundColor,
    this.title,
    this.initialIndex = 0,
    this.keepAlive,
    this.onPage,
  }) : super(key: key);

  @override
  TabBarTopWidgetState createState() => new TabBarTopWidgetState();
}

class TabBarTopWidgetState extends State<TabBarTopWidget>
    with SingleTickerProviderStateMixin {
  MPPageController? _tabController;
  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabIndex = widget.initialIndex ?? 0;
    _tabController = MPPageController(initialPage: _tabIndex);
    _tabController?.addListener(() {
      setState(() {
        _tabIndex = _tabController?.page ?? 0;
        widget.onPage?.call(_tabIndex);
      });
    });
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
      return Column(
        children: [
          Container(
            height: 50,
            margin: EdgeInsets.only(top: 8),
            child: ListView.builder(
                itemCount: widget.tabItems?.length ?? 0,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var data = widget.tabItems![index];
                  return _renderIcon(
                      index: index,
                      title: data.tabName.defaultStr(data: '${index + 1}'));
                }),
          ),
          Expanded(
              child: MPPageView(
            controller: _tabController,
            children: (widget.tabItems ?? [])
                .map((e) => e.page ?? Container())
                .toList(),
          ))
        ],
      );
    }
  }

  Widget _renderIcon({
    required int index,
    required String title,
  }) {
    return Clickable(
      onTap: () {
        setState(() {
          _tabIndex = index;
          _tabController?.jumpToPage(index);
        });
      },
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 12, right: 12, bottom: 8, top: 8),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: index == _tabIndex ? 15 : 14,
              fontWeight:
                  index == _tabIndex ? FontWeight.bold : FontWeight.normal,
              color: index == _tabIndex
                  ? BaseColorUtils.colorAccent
                  : BaseColorUtils.colorBlack,
            ),
          ),
          LineView(
              margin: EdgeInsets.only(top: 4),
              height: 1,
              width: 15,
              color: index == _tabIndex
                  ? BaseColorUtils.colorAccent
                  : BaseColorUtils.transparent)
        ],
      ),
    );
  }
}
