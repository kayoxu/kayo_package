import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';

typedef DataChangedCallback(dynamic data);
typedef DataChangedCallback2(int index, dynamic data);

const double _kDataPickerHeight = 210.0;
const double _kDataPickerTitleHeight = 44.0;
const double _kDataPickerItemHeight = 36.0;
const double _kDataPickerFontSize = 15.0;

class DataPicker {
  static void showDataPicker(BuildContext context,
      {bool showTitleActions: true,
      @required List<dynamic> datas,
      int selectedIndex: 0,
      DataChangedCallback onChanged,
      DataChangedCallback onConfirm,
      DataChangedCallback2 onConfirm2,
      String suffix: '',
      String title,
      String locale: 'zh',
      bool bottomSheet: true}) {
    if (true == bottomSheet) {
      showModalBottomSheet(
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
              onChanged: onChanged,
              onConfirm2: onConfirm2,
              title: title,
              onConfirm: onConfirm,
            );
          });
    } else {
      Navigator.push(
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
            theme: Theme.of(context, shadowThemeOnly: true),
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
    RouteSettings settings,
  }) : super(settings: settings);

  final List<dynamic> datas;
  final bool showTitleActions;
  final int initialData;
  final DataChangedCallback onChanged;
  final DataChangedCallback onConfirm;
  final DataChangedCallback2 onConfirm2;
  final ThemeData theme;
  final String locale;
  final String suffix;
  final String title;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  bool get barrierDismissible => true;

  @override
  final String barrierLabel;

  @override
  Color get barrierColor => Colors.black54;

  AnimationController _animationController;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController =
        BottomSheet.createAnimationController(navigator.overlay);
    return _animationController;
  }

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
      bottomSheet = new Theme(data: theme, child: bottomSheet);
    }
    return bottomSheet;
  }
}

class _DataPickerComponent extends StatefulWidget {
  _DataPickerComponent({
    Key key,
    @required this.route,
    this.initialData: 0,
    this.datas,
    this.onChanged,
    this.locale,
    this.suffix,
    this.title,
  });

  final DataChangedCallback onChanged;
  final int initialData;
  final List<dynamic> datas;

  final _DataPickerRoute route;

  final String locale;
  final String suffix;
  final String title;

  @override
  State<StatefulWidget> createState() => _DataPickerState(this.initialData);
}

class _DataPickerState extends State<_DataPickerComponent> {
  int _initialIndex;
  FixedExtentScrollController dataScrollCtrl;

  _DataPickerState(this._initialIndex) {
    if (this._initialIndex < 0) {
      this._initialIndex = 0;
    }
    dataScrollCtrl =
        new FixedExtentScrollController(initialItem: _initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new AnimatedBuilder(
        animation: widget.route.animation,
        builder: (BuildContext context, Widget child) {
          return new ClipRect(
            child: new CustomSingleChildLayout(
              delegate: new _BottomPickerLayout(widget.route.animation.value,
                  showTitleActions: widget.route.showTitleActions),
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
      widget.onChanged(widget.datas[_initialIndex]);
    }
  }

  Widget _renderPickerView() {
    Widget itemView = _renderItemView();
    if (widget.route.showTitleActions) {
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
            children: List.generate(widget.datas.length, (int index) {
              return Container(
                height: _kDataPickerItemHeight,
                alignment: Alignment.center,
                child: Row(
                  children: <Widget>[
                    new Expanded(
                        child: Text(
                      '${widget.datas[index]}$suffixAppend',
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
    return _renderDataPickerComponent(widget.suffix);
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
            child: FlatButton(
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
              widget.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
          ),
          Container(
            height: _kDataPickerTitleHeight,
            child: FlatButton(
              child: Text(
                '$done',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 16.0,
                ),
              ),
              onPressed: () {
                if (widget.route.onConfirm != null) {
                  widget.route.onConfirm(widget.datas[_initialIndex]);
                }
                if (widget.route.onConfirm2 != null) {
                  widget.route
                      .onConfirm2(_initialIndex, widget.datas[_initialIndex]);
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

    String lang = widget.locale.split('_').first;

    switch (lang) {
      case 'en':
        return 'Done';
        break;

      case 'zh':
        return '确定';
        break;

      default:
        return '';
        break;
    }
  }

  String _localeCancel() {
    if (widget.locale == null) {
      return '取消';
    }

    String lang = widget.locale.split('_').first;

    switch (lang) {
      case 'en':
        return 'Cancel';
        break;

      case 'zh':
        return '取消';
        break;

      default:
        return '';
        break;
    }
  }
}

class _BottomPickerLayout extends SingleChildLayoutDelegate {
  _BottomPickerLayout(this.progress, {this.itemCount, this.showTitleActions});

  final double progress;
  final int itemCount;
  final bool showTitleActions;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double maxHeight = _kDataPickerHeight;
    if (showTitleActions) {
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
    double height = size.height - childSize.height * progress;
    return new Offset(0.0, height);
  }

  @override
  bool shouldRelayout(_BottomPickerLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}

class BottomSheetSingleWidget extends StatefulWidget {
  final int selectedIndex;
  final List<dynamic> datas;
  final String title;

  final DataChangedCallback onChanged;
  final DataChangedCallback onConfirm;
  final DataChangedCallback2 onConfirm2;
  final bool isEN;

  const BottomSheetSingleWidget(
      {Key key,
      this.datas,
      this.selectedIndex,
      this.title,
      this.onChanged,
      this.onConfirm,
      this.onConfirm2,
      this.isEN})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _BottomSheetSingleState();
}

class _BottomSheetSingleState extends State<BottomSheetSingleWidget> {
  double itemHeight = 56;
  double marginBottom = 20;
  double viewHeight = 0;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;

    viewHeight = itemHeight * (widget.datas?.length ?? 0) + marginBottom;

    if (viewHeight > 300) {
      viewHeight = 300;
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
                color: BaseColorUtils.colorAccent,
                radius: 10,
                size: 15,
                fontWeight: FontWeight.w600,
                padding:
                    EdgeInsets.only(left: 17, right: 17, bottom: 12, top: 12),
                margin: EdgeInsets.only(left: 6),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                  child: TextView(
                widget.title ?? (widget.isEN == true ? 'SELECT' : '请选择'),
                maxLine: 2,
                textAlign: TextAlign.center,
                alignment: Alignment.center,
                color: BaseColorUtils.colorBlack,
                size: 17,
                fontWeight: FontWeight.w600,
                margin: EdgeInsets.only(left: 16, right: 16),
              )),
              TextView(
                widget.isEN == true ? 'Confirm' : '确定',
                radius: 10,
                color: BaseColorUtils.colorAccent,
                size: 15,
                fontWeight: FontWeight.w600,
                padding:
                    EdgeInsets.only(left: 17, right: 17, bottom: 12, top: 12),
                margin: EdgeInsets.only(right: 6),
                onTap: () {
                  widget?.onConfirm?.call(widget.datas[selectedIndex]);
                  widget?.onConfirm2
                      ?.call(selectedIndex, widget.datas[selectedIndex]);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        Container(
          height: viewHeight,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: EdgeInsets.only(left: 32, right: 32),
                title: TextView(
                  widget.datas[index].toString(),
                  size: 15,
                  color: selectedIndex == index
                      ? BaseColorUtils.colorAccent
                      : BaseColorUtils.colorBlack,
                  fontWeight: selectedIndex == index
                      ? FontWeight.w600
                      : FontWeight.normal,
                ),
                trailing: selectedIndex == index
                    ? ImageView(
                        height: 17,
                        width: 17,
                        src: 'packages/kayo_package/assets/base_ic_checked.png',
                        // src: 'assets/ic_moren.png',
                      )
                    : Container(
                        height: 17,
                        width: 17,
                      ),
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                    widget?.onChanged?.call(widget.datas[index]);
                  });
                },
              );
            },
            itemExtent: itemHeight,
            itemCount: (widget.datas?.length ?? 0),
          ),
        )
      ],
    ));
  }
}
