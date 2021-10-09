import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';

typedef DataChangedCallback(dynamic data);
typedef DataChangedCallbackMore<T>(List<int> indexes, List<T> data);
typedef DataChangedCallback2(int index, dynamic data);

const double _kDataPickerHeight = 210.0;
const double _kDataPickerTitleHeight = 44.0;
const double _kDataPickerItemHeight = 36.0;
const double _kDataPickerFontSize = 15.0;

class DataPickerLocale {
  /// English (EN) United States
  static const String en_us = 'en';

  /// Chinese (ZH) Simplified
  static const String zh_cn = 'zh';
}

class DataPicker {
  static String defaultDataPickerLocale = DataPickerLocale.zh_cn;

  static Future show<T>(BuildContext context,
      {bool showTitleActions: true,
      required List<T> datas,
      int selectedIndex: 0,
      List<int>? selectedIndexes,
      DataChangedCallback? onChanged,
      DataChangedCallback? onConfirm,
      DataChangedCallbackMore<T>? onConfirmMore,
      DataChangedCallback2? onConfirm2,
      String suffix: '',
      bool? multipleChoice,
      String? title,
      String? locale,
      bool bottomSheet: true}) {
    locale = locale ?? defaultDataPickerLocale;
    return showDataPicker(context,
        showTitleActions: showTitleActions,
        datas: datas,
        selectedIndex: selectedIndex,
        selectedIndexes: selectedIndexes,
        onChanged: onChanged,
        onConfirm: onConfirm,
        onConfirmMore: onConfirmMore,
        onConfirm2: onConfirm2,
        suffix: suffix,
        multipleChoice: multipleChoice,
        title: title,
        locale: locale,
        bottomSheet: bottomSheet);
  }

  @Deprecated('用show代替showDataPicker')
  static Future showDataPicker<T>(BuildContext context,
      {bool showTitleActions: true,
      required List<T> datas,
      int selectedIndex: 0,
      List<int>? selectedIndexes,
      DataChangedCallback? onChanged,
      DataChangedCallback? onConfirm,
      DataChangedCallbackMore<T>? onConfirmMore,
      DataChangedCallback2? onConfirm2,
      String suffix: '',
      bool? multipleChoice,
      String? title,
      String? locale,
      bool bottomSheet: true}) {
    locale = locale ?? defaultDataPickerLocale;
    if (true == bottomSheet) {
      return showModalBottomSheet(
          context: context,
          isDismissible: true,
          isScrollControlled: false,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12))),
          builder: (BuildContext context) {
            return BottomSheetSingleWidget(
              datas: datas,
              isEN: !BaseSysUtils.equals('zh', locale),
              selectedIndex: selectedIndex,
              selectedIndexes: selectedIndexes,
              onChanged: onChanged,
              onConfirm2: onConfirm2,
              multipleChoice: multipleChoice,
              title: title,
              onConfirm: onConfirm,
              onConfirmMore: onConfirmMore,
            );
          });
    } else {
      return Navigator.push(
          context,
          new _DataPickerRoute(
            showTitleActions: showTitleActions,
            initialData: selectedIndex,
            datas: datas,
            onChanged: onChanged,
            onConfirm: onConfirm,
            onConfirm2: onConfirm2,
            locale: locale,
            suffix: suffix,
            title: title ?? '',
            theme: Theme.of(context /*, shadowThemeOnly: true*/),
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
          ));
    }
  }
}

class _DataPickerRoute<T> extends PopupRoute<T> {
  _DataPickerRoute({
    this.showTitleActions,
    this.datas,
    this.initialData,
    this.onChanged,
    this.onConfirm,
    this.onConfirm2,
    this.theme,
    this.barrierLabel,
    this.locale,
    this.suffix,
    this.title,
    RouteSettings? settings,
  }) : super(settings: settings);

  final List<dynamic>? datas;
  final bool? showTitleActions;
  final int? initialData;
  final DataChangedCallback? onChanged;
  final DataChangedCallback? onConfirm;
  final DataChangedCallback2? onConfirm2;
  final ThemeData? theme;
  final String? locale;
  final String? suffix;
  final String? title;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  bool get barrierDismissible => true;

  @override
  final String? barrierLabel;

  @override
  Color get barrierColor => Colors.black54;

  // AnimationController? _animationController;

  // @override
  // AnimationController createAnimationController() {
  //   // assert(_animationController == null);
  //   // _animationController =
  //   //     BottomSheet.createAnimationController(navigator.overlay);
  //   // return _animationController;
  // }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    Widget bottomSheet = new MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: _DataPickerComponent(
        initialData: initialData,
        datas: datas,
        onChanged: onChanged,
        locale: locale,
        suffix: suffix,
        title: title,
        route: this,
      ),
    );
    if (theme != null) {
      bottomSheet = new Theme(data: theme!, child: bottomSheet);
    }
    return bottomSheet;
  }
}

class _DataPickerComponent extends StatefulWidget {
  _DataPickerComponent({
    Key? key,
    required this.route,
    this.initialData: 0,
    this.datas,
    this.onChanged,
    this.locale,
    this.suffix,
    this.title,
  });

  final DataChangedCallback? onChanged;
  final int? initialData;
  final List<dynamic>? datas;

  final _DataPickerRoute? route;

  final String? locale;
  final String? suffix;
  final String? title;

  @override
  State<StatefulWidget> createState() => _DataPickerState(this.initialData);
}

class _DataPickerState extends State<_DataPickerComponent> {
  int? _initialIndex;
  FixedExtentScrollController? dataScrollCtrl;

  _DataPickerState(this._initialIndex) {
    if ((this._initialIndex ?? 0) < 0) {
      this._initialIndex = 0;
    }
    dataScrollCtrl =
        new FixedExtentScrollController(initialItem: _initialIndex ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new AnimatedBuilder(
        animation: widget.route!.animation!,
        builder: (BuildContext? context, Widget? child) {
          return new ClipRect(
            child: new CustomSingleChildLayout(
              delegate: new _BottomPickerLayout(widget.route!.animation!.value,
                  showTitleActions: widget.route!.showTitleActions),
              child: new GestureDetector(
                child: Material(
                  color: Colors.transparent,
                  child: _renderPickerView(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _setData(int index) {
    if (_initialIndex != index) {
      _initialIndex = index;
      setState(() {});
      _notifyDataChanged();
    }
  }

  void _notifyDataChanged() {
    if (widget.onChanged != null) {
      widget.onChanged!(widget.datas![_initialIndex ?? 0]);
    }
  }

  Widget _renderPickerView() {
    Widget itemView = _renderItemView();
    if (widget.route!.showTitleActions == true) {
      return Column(
        children: <Widget>[
          _renderTitleActionsView(),
          itemView,
        ],
      );
    }
    return itemView;
  }

  Widget _renderDataPickerComponent(String suffixAppend) {
    return new Expanded(
      flex: 1,
      child: Container(
          padding: EdgeInsets.all(8.0),
          height: _kDataPickerHeight,
          decoration: BoxDecoration(color: Colors.white),
          child: CupertinoPicker(
            backgroundColor: Colors.white,
            scrollController: dataScrollCtrl,
            itemExtent: _kDataPickerItemHeight,
            onSelectedItemChanged: (int index) {
              _setData(index);
            },
            children: List.generate(widget.datas!.length, (int index) {
              return Container(
                height: _kDataPickerItemHeight,
                alignment: Alignment.center,
                child: Row(
                  children: <Widget>[
                    new Expanded(
                        child: Text(
                      '${widget.datas![index]}$suffixAppend',
                      style: TextStyle(
                          color: Color(0xFF000046),
                          fontSize: _kDataPickerFontSize),
                      textAlign: TextAlign.center,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                    ))
                  ],
                ),
              );
            }),
          )),
    );
  }

  Widget _renderItemView() {
    return _renderDataPickerComponent(widget.suffix!);
  }

  // Title View
  Widget _renderTitleActionsView() {
    String done = _localeDone();
    String cancel = _localeCancel();

    return Container(
      height: _kDataPickerTitleHeight,
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: _kDataPickerTitleHeight,
            child: TextButton(
              child: Text(
                '$cancel',
                style: TextStyle(
                  color: Theme.of(context).unselectedWidgetColor,
                  fontSize: 16.0,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: _kDataPickerTitleHeight,
            child: Text(
              widget.title ?? '',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
          ),
          Container(
            height: _kDataPickerTitleHeight,
            child: TextButton(
              child: Text(
                '$done',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 16.0,
                ),
              ),
              onPressed: () {
                if (widget.route!.onConfirm != null) {
                  widget.route!.onConfirm!(widget.datas![_initialIndex ?? 0]);
                }
                if (widget.route!.onConfirm2 != null) {
                  widget.route!.onConfirm2!(
                      _initialIndex ?? 0, widget.datas![_initialIndex ?? 0]);
                }
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  String _localeDone() {
    if (widget.locale == null) {
      return '确定';
    }

    String lang = widget.locale!.split('_').first;

    switch (lang) {
      case 'en':
        return 'Done';

      case 'zh':
        return '确定';

      default:
        return '';
    }
  }

  String _localeCancel() {
    if (widget.locale == null) {
      return '取消';
    }

    String lang = widget.locale!.split('_').first;

    switch (lang) {
      case 'en':
        return 'Cancel';

      case 'zh':
        return '取消';

      default:
        return '';
    }
  }
}

class _BottomPickerLayout extends SingleChildLayoutDelegate {
  _BottomPickerLayout(this.progress, {this.itemCount, this.showTitleActions});

  final double? progress;
  final int? itemCount;
  final bool? showTitleActions;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double maxHeight = _kDataPickerHeight;
    if (showTitleActions == true) {
      maxHeight += _kDataPickerTitleHeight;
    }

    return new BoxConstraints(
        minWidth: constraints.maxWidth,
        maxWidth: constraints.maxWidth,
        minHeight: 0.0,
        maxHeight: maxHeight);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double height = size.height - childSize.height * progress!;
    return new Offset(0.0, height);
  }

  @override
  bool shouldRelayout(_BottomPickerLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}

class BottomSheetSingleWidget<T> extends StatefulWidget {
  final int? selectedIndex;
  final List<int>? selectedIndexes;
  final List<T>? datas;
  final String? title;

  final DataChangedCallback? onChanged;
  final DataChangedCallback? onConfirm;
  final DataChangedCallbackMore<T>? onConfirmMore;
  final DataChangedCallback2? onConfirm2;
  final bool? isEN;
  final bool? multipleChoice;

  const BottomSheetSingleWidget(
      {Key? key,
      this.datas,
      this.selectedIndex,
      this.selectedIndexes,
      this.title,
      this.onChanged,
      this.multipleChoice,
      this.onConfirm,
      this.onConfirmMore,
      this.onConfirm2,
      this.isEN})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _BottomSheetSingleState<T>();
}

class _BottomSheetSingleState<T> extends State<BottomSheetSingleWidget<T>> {
  double itemHeight = 56;
  double marginBottom = 10;
  double viewHeight = 0;

  // int selectedIndex = 0;
  late List<int> selectedIndexes;
  bool multipleChoice = false;

  @override
  void initState() {
    super.initState();
    // selectedIndex = widget.selectedIndex ?? 0;
    selectedIndexes = widget.selectedIndexes ?? [widget.selectedIndex ?? 0];
    multipleChoice = widget.multipleChoice ?? false;
    viewHeight = itemHeight * (widget.datas?.length ?? 0) + marginBottom + 47;

    if (viewHeight > 300) {
      // viewHeight = 300;
    } else if (viewHeight < 100) {
      viewHeight = 100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: itemHeight,
          child: Row(
            children: [
              TextView(
                widget.isEN == true ? 'Cancel' : '取消',
                color: BaseColorUtils.colorBlackLite,
                radius: 10,
                size: 17,
                fontWeight: FontWeight.normal,
                padding:
                    EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 12),
                margin: EdgeInsets.only(left: 8),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                  child: TextView(
                widget.title ??
                    (widget.isEN == true
                        ? 'SELECT'
                        : '请选择${multipleChoice == true ? '(可多选)' : ''}'),
                maxLine: 2,
                textAlign: TextAlign.center,
                alignment: Alignment.center,
                color: BaseColorUtils.colorBlack,
                size: 17,
                fontWeight: FontWeight.w600,
                margin: EdgeInsets.only(left: 16, right: 16),
              )),
              TextView(
                widget.isEN == true ? 'Cancel' : '取消',
                color: BaseColorUtils.transparent,
                radius: 10,
                size: 17,
                fontWeight: FontWeight.normal,
                padding:
                    EdgeInsets.only(left: 8, right: 8, bottom: 12, top: 12),
                margin: EdgeInsets.only(right: 12),
              )
              // TextView(
              //   widget.isEN == true ? 'Confirm' : '确定',
              //   radius: 10,
              //   color: BaseColorUtils.colorAccent,
              //   size: 15,
              //   fontWeight: FontWeight.w600,
              //   padding:
              //   EdgeInsets.only(left: 17, right: 17, bottom: 12, top: 12),
              //   margin: EdgeInsets.only(right: 6),
              //   onTap: () {
              //     widget.onConfirm?.call(widget.datas?[selectedIndexes[0]]);
              //     widget.onConfirm2?.call(
              //         selectedIndexes[0],
              //         widget.datas?[selectedIndexes[0]]);
              //     List<T> d = [];
              //     List<int> indexes = [];
              //     for (int i = 0; i < (widget.datas ?? []).length; i++) {
              //       if (selectedIndexes.contains(i)) {
              //         d.add(widget.datas![i]);
              //         indexes.add(i);
              //       }
              //     }
              //     widget.onConfirmMore?.call(indexes, d);
              //     Navigator.pop(context);
              //   },
              // ),
            ],
          ),
        ),
        Container(
          height: getVH(),
          child: Column(
            children: [
              Expanded(
                  child: Scrollbar(
                isAlwaysShown: true,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Color(0xffEBEBEB),
                      height: .5,
                    );
                  },
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.only(left: 15, right: 15),
                      selected: selectedIndexes.contains(index),
                      title: TextView(
                        widget.datas?[index]?.toString() ?? '',
                        size: 15,
                        color: selectedIndexes.contains(index)
                            ? BaseColorUtils.colorBlack
                            : BaseColorUtils.colorBlack,
                        fontWeight: selectedIndexes.contains(index)
                            ? FontWeight.w600
                            : FontWeight.w600,
                      ),
                      trailing: selectedIndexes.contains(index)
                          ? Icon(
                              Icons.radio_button_checked,
                              color: BaseColorUtils.colorAccent,
                              size: 18,
                            )
                          /*ImageView(
                      height: 17,
                      width: 17,
                      src: 'packages/kayo_package/assets/base_ic_checked.png',
                      // src: 'assets/ic_moren.png',
                    )*/
                          : Container(
                              height: 17,
                              width: 17,
                            ),
                      onTap: () {
                        setState(() {
                          if (multipleChoice == true) {
                            selectedIndexes.contains(index)
                                ? selectedIndexes.remove(index)
                                : selectedIndexes.add(index);
                          } else {
                            selectedIndexes.clear();
                            selectedIndexes.add(index);
                          }
                          // selectedIndex = index;
                          widget.onChanged?.call(widget.datas?[index]);
                        });
                      },
                    );
                  },
                  // itemExtent: itemHeight,
                  itemCount: (widget.datas?.length ?? 0),
                ),
              )),
              TextView(
                widget.isEN == true ? 'Confirm' : '确定',
                radius: 4,
                bgColor: BaseColorUtils.colorAccent,
                color: BaseColorUtils.colorWhite,
                size: 17,
                fontWeight: FontWeight.w600,
                width: double.infinity,
                textAlign: TextAlign.center,
                alignment: Alignment.center,
                height: 45,
                padding:
                    EdgeInsets.only(left: 17, right: 17, bottom: 0, top: 0),
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 5),
                onTap: () {
                  widget.onConfirm?.call(widget.datas?[selectedIndexes[0]]);
                  widget.onConfirm2?.call(
                      selectedIndexes[0], widget.datas?[selectedIndexes[0]]);
                  List<T> d = [];
                  List<int> indexes = [];
                  for (int i = 0; i < (widget.datas ?? []).length; i++) {
                    if (selectedIndexes.contains(i)) {
                      d.add(widget.datas![i]);
                      indexes.add(i);
                    }
                  }
                  widget.onConfirmMore?.call(indexes, d);
                  Navigator.pop(context);
                },
              )
            ],
          ),
        )
      ],
    ));
  }

  double getVH() {
    double h = MediaQuery.of(context).size.height;

    double b = MediaQuery.of(context).padding.bottom;
    if (b < 1) {
      b = 40;
    }
    if (h > 600) {
      if (viewHeight > 300) viewHeight = h / 2 - b;
    } else {
      if (viewHeight > 300) viewHeight = 300;
    }
    return viewHeight;
  }
}
