import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';

typedef TabMenuBuilder = Widget Function(
    BuildContext context, TabMenu data, bool checked);

class TabMenuView extends StatefulWidget {
  final List<TabMenu>? menus;
  final int? checkedIndex;
  final ValueChanged<TabMenu>? onItemClick;
  final TabMenuBuilder? builder;
  double? height;
  EdgeInsets? margin;
  BorderRadius? borderRadius;
  final double? radius;
  Color? bgColor;

  TabMenuView({
    Key? key,
    required this.menus,
    required this.checkedIndex,
    required this.onItemClick,
    this.builder,
    this.height = 50,
    this.margin = const EdgeInsets.only(bottom: 10),
    this.borderRadius = const BorderRadius.only(
        bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
    this.radius,
    this.bgColor = BaseColorUtils.white,
  }) : super(key: key);

  @override
  _TabMenuViewState createState() => _TabMenuViewState();
}

class _TabMenuViewState extends State<TabMenuView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      margin: widget.margin,
      decoration: BoxDecoration(
          color: widget.bgColor,
          borderRadius: null != widget.radius
              ? BorderRadius.all(Radius.circular(widget.radius ?? 0))
              : BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _getTabCount(context, widget.menus ?? [],
            widget.checkedIndex ?? 0, widget.onItemClick, widget.builder),
      ),
    );
  }
}

List<Widget> _getTabCount(
    BuildContext? context,
    List<TabMenu>? menus,
    int? checkedIndex,
    ValueChanged<TabMenu>? onItemClick,
    TabMenuBuilder? builder) {
  var list = <Widget>[];

  if (menus != null && menus.length > 0) {
    int ii = 0;
    for (var i in menus) {
      list.add(_tabMenuItem(
        ii++,
        i,
        checkedIndex,
        menus,
        onItemClick,
        builder,
        context,
      ));
    }
  }
  return list;
}

Widget _tabMenuItem(
  int? index,
  TabMenu? data,
  int? checkedIndex,
  List<TabMenu>? menus,
  ValueChanged<TabMenu>? onItemClick,
  TabMenuBuilder? builder,
  BuildContext? context,
) {
  return Clickable(
      onTap: () {
        onItemClick?.call(menus![index!]);
      },
      child: null != builder
          ? builder(context!, data!, index == checkedIndex)
          : Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                    child: TextView(
                  '${data?.name ?? ''}${(data?.count ?? 0) == 0 ? '' : ((data?.count ?? 0) > 99 ? '99' : (data?.count ?? 0))}',
                  padding: EdgeInsets.all(0),
                  width: 100,
                  margin: EdgeInsets.all(0),
                  alignment: Alignment.center,
                  textAlign: TextAlign.center,
                  color: index == checkedIndex
                      ? BaseColorUtils.colorAccent
                      : BaseColorUtils.colorBlackLite,
                  fontWeight: index == checkedIndex
                      ? FontWeight.bold
                      : FontWeight.normal,
                  size: 16,
                )),
                LineView(
                  height: 2,
                  color: BaseColorUtils.colorAccent,
                  width: 32,
                  visible: index == checkedIndex
                      ? Visible.visible
                      : Visible.invisible,
                )
              ],
            ));
}
