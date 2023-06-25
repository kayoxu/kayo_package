import 'package:flutter/material.dart';
import 'package:kayo_package/utils/base_color_utils.dart';
import 'package:lpinyin/lpinyin.dart';
import '../model/section_city.dart';
import '../model/city.dart';
import '../listener/item_listener.dart';
import '../listener/picker_listener.dart';
import 'listview_section.dart';
import 'package:flutter/material.dart';
import 'package:mpcore/mpcore.dart';
/// 城市列表组件
class ItemWidget<City> extends StatefulWidget {
  /// 当前列表的索引
  final int? index;

  // /// 上一级城市代码
  // final String? code;
  //
  // /// 上一级城市名称
  // final String? name;

  final City parentData;

  final ValueChanged<String> emptyDataCallBack;

  /// 左边间距
  final double? paddingLeft;

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

  final LinkagePickerListener? cityPickerListener;

  final ItemClickListener? itemClickListener;

  ItemWidget({
    required this.index,
    required this.parentData,
    required this.emptyDataCallBack,
    // required this.code,
    // required this.name,
    required this.paddingLeft,
    required this.itemHeadHeight,
    required this.itemHeadBackgroundColor,
    required this.itemHeadLineColor,
    required this.itemHeadLineHeight,
    required this.itemHeadTextStyle,
    required this.itemHeight,
    required this.indexBarWidth,
    required this.indexBarItemHeight,
    required this.indexBarBackgroundColor,
    required this.indexBarTextStyle,
    required this.itemSelectedIconWidget,
    required this.itemSelectedTextStyle,
    required this.itemUnSelectedTextStyle,
    required this.cityPickerListener,
    required this.itemClickListener,
  });

  @override
  State<StatefulWidget> createState() => ItemWidgetState();
}

class ItemWidgetState extends State<ItemWidget>
    with AutomaticKeepAliveClientMixin {
  ScrollController? _scrollController;

  LinkagePickerListener? _cityPickerListener;
  ItemClickListener? _itemClickListener;

  // 选中的名称
  String? _title = "请选择";

  // 上次保存的名称
  City? _preData;

  // 列表数据
  List<SectionCity> _mList = [];

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    _itemClickListener = widget.itemClickListener;
    _cityPickerListener = widget.cityPickerListener;

    if (_cityPickerListener != null) {
      _loadData();
    }
  }

  /// 判断上一级数据是否变动，如果变动就更新
  @override
  void didUpdateWidget(covariant ItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_cityPickerListener != null) {
      if (null != _preData &&
          null != widget.parentData &&
          _preData != widget.parentData) {
        _title = "";
        _loadData();
      }
    }
  }

  void _loadData() {
    _cityPickerListener!.onLoadData(widget.parentData, (value) {
      if (value.length > 0) {
        _mList = sortCity(value);
        _preData = widget.parentData;
        if (mounted) {
          setState(() {});
        }
      } else {
        if (mounted) {
          setState(() {});
        }
        widget.emptyDataCallBack.call('');
      }
    });
  }

  /// 排序数据
  List<SectionCity> sortCity(List<City> value) {
    // 先排序
    List<City> _cityList = [];
    value.forEach((city) {
      String letter = PinyinHelper.getFirstWordPinyin(city.name!)
          .substring(0, 1)
          .toUpperCase();
      if (![
        'A',
        'B',
        'C',
        'D',
        'E',
        'F',
        'G',
        'H',
        'I',
        'J',
        'K',
        'L',
        'M',
        'N',
        'O',
        'P',
        'Q',
        'R',
        'S',
        'T',
        'U',
        'V',
        'W',
        'X',
        'Y',
        'Z'
      ].contains(letter)) {
        letter = '#';
      }
      _cityList.add(City(code: city.code, letter: letter, name: city.name));
    });
    _cityList.sort((a, b) => a.letter!.compareTo(b.letter!));
    // 组装数据
    List<SectionCity> _sectionList = [];
    String? _letter = "A";
    List<City> _cityList2 = [];
    for (int i = 0; i < _cityList.length; i++) {
      if (_letter == _cityList[i].letter) {
        _cityList2.add(_cityList[i]);
      } else {
        if (_cityList2.length > 0) {
          _sectionList.add(SectionCity(letter: _letter, data: _cityList2));
        }
        _cityList2 = [];
        _cityList2.add(_cityList[i]);
        _letter = _cityList[i].letter;
      }
      if (i == _cityList.length - 1) {
        if (_cityList2.length > 0) {
          _sectionList.add(SectionCity(letter: _letter, data: _cityList2));
        }
      }
    }
    return _sectionList;
  }

  /// 点击索引，列表滑动
  void clickIndexBar(int index) {
    double position = 0;
    int length = 0;
    // 计算位置
    for (int i = 0; i < _mList.length; i++) {
      if (_mList[index].letter == _mList[i].letter) {
        if (i == 0) {
          position = 0;
        } else {
          position = i * widget.itemHeadHeight! + length * widget.itemHeight!;
        }
      }
      length += _mList[i].data!.length;
    }
    _scrollController!.animateTo(position,
        duration: Duration(milliseconds: 10), curve: Curves.linear);
  }

  @override
  void dispose() {
    if (mounted) {
      _scrollController?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      width: double.infinity,
      height: double.infinity,
      // color: Theme.of(context).dialogBackgroundColor,
      child: Stack(
        children: [
          ExpandableListView(
            controller: _scrollController,
            builder: SliverExpandableChildDelegate<City, SectionCity>(
                sectionList: _mList,
                headerBuilder: (context, sectionIndex, index) {
                  return Container(
                    width: double.infinity,
                    height: widget.itemHeadHeight,
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                        width: widget.itemHeadLineHeight!,
                        color: widget.itemHeadLineColor ?? Colors.black38,
                      )),
                      color: widget.itemHeadBackgroundColor ?? BaseColorUtils.colorAccent
                          // Theme.of(context).dialogBackgroundColor
                      ,
                    ),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: widget.paddingLeft!),
                    child: Text(_mList[sectionIndex].letter!,
                        style: widget.itemHeadTextStyle ??
                            TextStyle(fontSize: 15, color: Colors.black)),
                  );
                },
                itemBuilder: (context, sectionIndex, itemIndex, index) {
                  City city = _mList[sectionIndex].data![itemIndex];
                  bool isSelect = city.name == _title;
                  return GestureDetector(
                    onTap: () {
                      _title = city.name!;
                      if (mounted) {
                        setState(() {});
                      }
                      if (_itemClickListener != null) {
                        _itemClickListener!.onItemClick(widget.index, city);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: widget.itemHeight,
                      padding: EdgeInsets.only(left: widget.paddingLeft!),
                      alignment: Alignment.centerLeft,
                      child: Row(children: <Widget>[
                        Expanded(
                            child: Text(city.name!,
                                style: isSelect
                                    ? widget.itemSelectedTextStyle ??
                                        TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: BaseColorUtils.colorAccent//Theme.of(context).primaryColor
                                        )
                                    : widget.itemUnSelectedTextStyle ??
                                        TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54))),
                        SizedBox(width: isSelect ? 3 : 0),
                        Offstage(
                          offstage: !isSelect,
                          child: widget.itemSelectedIconWidget ??
                              MPIcon(MaterialIcons.done,
                                  color: BaseColorUtils.colorAccent,
                                  size: 16),
                        ),
                        SizedBox(width: 16),
                      ]),
                    ),
                  );
                }),
          ),
          Positioned(
            right: widget.paddingLeft,
            top: 0,
            bottom: 0,
            child: Container(
              width: widget.indexBarWidth,
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_mList.length, (index) {
                  return _indexBarItem(index);
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _indexBarItem(int index) {
    // 有4种类型
    int type = 0;
    if (index == 0 && index == _mList.length - 1) {
      type = 1;
    } else if (index == 0) {
      type = 2;
    } else if (index == _mList.length - 1) {
      type = 3;
    } else {
      type = 4;
    }
    return GestureDetector(
      onTap: () {
        clickIndexBar(index);
      },
      child: Container(
        width: widget.indexBarWidth,
        height: type == 4
            ? widget.indexBarItemHeight
            : widget.indexBarItemHeight! + 4,
        alignment: type == 2
            ? Alignment.bottomCenter
            : type == 3
                ? Alignment.topCenter
                : Alignment.center,
        padding: type == 2
            ? EdgeInsets.only(bottom: 2)
            : type == 3
                ? EdgeInsets.only(top: 2)
                : EdgeInsets.all(0),
        decoration: BoxDecoration(
            color: widget.indexBarBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: (type == 1 || type == 2)
                  ? Radius.circular(50)
                  : Radius.circular(0),
              topRight: (type == 1 || type == 2)
                  ? Radius.circular(50)
                  : Radius.circular(0),
              bottomLeft: (type == 1 || type == 3)
                  ? Radius.circular(50)
                  : Radius.circular(0),
              bottomRight: (type == 1 || type == 3)
                  ? Radius.circular(50)
                  : Radius.circular(0),
            )),
        child: Text(_mList[index].letter!,
            style: widget.indexBarTextStyle ??
                TextStyle(fontSize: 11, color: Colors.black54)),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
