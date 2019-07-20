import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'date_model.dart';
import 'datetime_picker_theme.dart';
import 'i18n_model.dart';

typedef DateChangedCallback(DateTime time, {DateTime time2});
typedef String StringAtIndexCallBack(int index);

class DatePicker {
  ///
  /// Display date picker bottom sheet.
  ///
  static void showDatePicker(
    BuildContext context, {
    bool showTitleActions: true,
    DateTime minTime,
    DateTime maxTime,
    DateTime minTime2,
    DateTime maxTime2,
    DateChangedCallback onChanged,
    DateChangedCallback onChanged2,
    DateChangedCallback onConfirm,
    locale: LocaleType.zh,
    DateTime currentTime,
    DateTime currentTime2,
    DatePickerTheme theme,
  }) {
    Navigator.push(
        context,
        new _DatePickerRoute(
          showTitleActions: showTitleActions,
          onChanged: onChanged,
          onChanged2: onChanged2,
          onConfirm: onConfirm,
          locale: locale,
          theme: theme,
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          pickerModel: DatePickerModel(
              currentTime: currentTime,
              maxTime: maxTime,
              minTime: minTime,
              locale: locale),
          pickerModel2: DatePickerModel(
              currentTime: currentTime2,
              maxTime: maxTime2,
              minTime: minTime2,
              locale: locale),
        ));
  }

  ///
  /// Display time picker bottom sheet.
  ///
  static void showTimePicker(
    BuildContext context, {
    bool showTitleActions: true,
    DateChangedCallback onChanged,
    DateChangedCallback onChanged2,
    DateChangedCallback onConfirm,
    locale: LocaleType.en,
    DateTime currentTime,
    DateTime currentTime2,
    DatePickerTheme theme,
  }) {
    Navigator.push(
        context,
        new _DatePickerRoute(
          showTitleActions: showTitleActions,
          onChanged: onChanged,
          onChanged2: onChanged2,
          onConfirm: onConfirm,
          locale: locale,
          theme: theme,
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          pickerModel:
              TimePickerModel(currentTime: currentTime, locale: locale),
          pickerModel2:
              TimePickerModel(currentTime: currentTime2, locale: locale),
        ));
  }

  ///
  /// Display date&time picker bottom sheet.
  ///
  static void showDateTimePicker(
    BuildContext context, {
    bool showTitleActions: true,
    DateChangedCallback onChanged,
    DateChangedCallback onChanged2,
    DateChangedCallback onConfirm,
    locale: LocaleType.en,
    DateTime currentTime,
    DateTime currentTime2,
    DatePickerTheme theme,
  }) {
    Navigator.push(
        context,
        new _DatePickerRoute(
          showTitleActions: showTitleActions,
          onChanged: onChanged,
          onChanged2: onChanged2,
          onConfirm: onConfirm,
          locale: locale,
          theme: theme,
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          pickerModel:
              DateTimePickerModel(currentTime: currentTime, locale: locale),
          pickerModel2:
              DateTimePickerModel(currentTime: currentTime2, locale: locale),
        ));
  }

  ///
  /// Display date picker bottom sheet witch custom picker model.
  ///
  static void showPicker(
    BuildContext context, {
    bool showTitleActions: true,
    DateChangedCallback onChanged,
    DateChangedCallback onChanged2,
    DateChangedCallback onConfirm,
    locale: LocaleType.zh,
    BasePickerModel pickerModel,
    BasePickerModel pickerModel2,
    DatePickerTheme theme,
  }) {
    Navigator.push(
        context,
        new _DatePickerRoute(
            showTitleActions: showTitleActions,
            onChanged: onChanged,
            onChanged2: onChanged2,
            onConfirm: onConfirm,
            locale: locale,
            theme: theme,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            pickerModel: pickerModel,
            pickerModel2: pickerModel2));
  }
}

class _DatePickerRoute<T> extends PopupRoute<T> {
  _DatePickerRoute({
    this.showTitleActions,
    this.onChanged,
    this.onChanged2,
    this.onConfirm,
    theme,
    this.barrierLabel,
    this.locale,
    RouteSettings settings,
    pickerModel,
    pickerModel2,
  })  : this.pickerModel = pickerModel ?? DatePickerModel(),
        this.pickerModel2 = pickerModel2 ?? DatePickerModel(),
        this.theme = theme ?? DatePickerTheme(),
        super(settings: settings);

  final bool showTitleActions;
  final DateChangedCallback onChanged;
  final DateChangedCallback onChanged2;
  final DateChangedCallback onConfirm;
  final DatePickerTheme theme;
  final LocaleType locale;
  final BasePickerModel pickerModel;
  final BasePickerModel pickerModel2;

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
      child: _DatePickerComponent(
        onChanged: onChanged,
        onChanged2: onChanged2,
        locale: this.locale,
        route: this,
        pickerModel: pickerModel,
        pickerModel2: pickerModel2,
      ),
    );
    ThemeData inheritTheme = Theme.of(context, shadowThemeOnly: true);
    if (inheritTheme != null) {
      bottomSheet = new Theme(data: inheritTheme, child: bottomSheet);
    }
    return bottomSheet;
  }
}

class _DatePickerComponent extends StatefulWidget {
  _DatePickerComponent(
      {Key key,
      @required this.route,
      this.onChanged,
      this.onChanged2,
      this.locale,
      this.pickerModel,
      this.pickerModel2});

  final DateChangedCallback onChanged;
  final DateChangedCallback onChanged2;

  final _DatePickerRoute route;

  final LocaleType locale;

  final BasePickerModel pickerModel;
  final BasePickerModel pickerModel2;

  @override
  State<StatefulWidget> createState() {
    return _DatePickerState();
  }
}

class _DatePickerState extends State<_DatePickerComponent> {
  FixedExtentScrollController leftScrollCtrl, middleScrollCtrl, rightScrollCtrl;
  FixedExtentScrollController leftScrollCtrl2,
      middleScrollCtrl2,
      rightScrollCtrl2;

  @override
  void initState() {
    super.initState();
    refreshScrollOffset();
  }

  void refreshScrollOffset() {
    leftScrollCtrl = new FixedExtentScrollController(
        initialItem: widget.pickerModel.currentLeftIndex());
    middleScrollCtrl = new FixedExtentScrollController(
        initialItem: widget.pickerModel.currentMiddleIndex());
    rightScrollCtrl = new FixedExtentScrollController(
        initialItem: widget.pickerModel.currentRightIndex());

    leftScrollCtrl2 = new FixedExtentScrollController(
        initialItem: widget.pickerModel2.currentLeftIndex());
    middleScrollCtrl2 = new FixedExtentScrollController(
        initialItem: widget.pickerModel2.currentMiddleIndex());
    rightScrollCtrl2 = new FixedExtentScrollController(
        initialItem: widget.pickerModel2.currentRightIndex());
  }

  @override
  Widget build(BuildContext context) {
    DatePickerTheme theme = widget.route.theme;
    return new GestureDetector(
      child: new AnimatedBuilder(
        animation: widget.route.animation,
        builder: (BuildContext context, Widget child) {
          return new ClipRect(
            child: new CustomSingleChildLayout(
              delegate: new _BottomPickerLayout(
                  widget.route.animation.value, theme,
                  showTitleActions: widget.route.showTitleActions),
              child: new GestureDetector(
                child: Material(
                  color: Colors.transparent,
                  child: _renderPickerView(theme),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _notifyDateChanged() {
    if (widget.onChanged != null) {
      widget.onChanged(widget.pickerModel.finalTime());
    }
    if (widget.onChanged2 != null) {
      widget.onChanged2(widget.pickerModel2.finalTime());
    }
  }

  Widget _renderPickerView(DatePickerTheme theme) {
    Widget itemView = _renderItemView(theme);
    if (widget.route.showTitleActions) {
      return Column(
        children: <Widget>[
          _renderTitleActionsView(theme),
          itemView,
        ],
      );
    }
    return itemView;
  }

  Widget _renderColumnView(
      ValueKey key,
      DatePickerTheme theme,
      StringAtIndexCallBack stringAtIndexCB,
      ScrollController scrollController,
      int layoutProportion,
      ValueChanged<int> selectedChangedWhenScrolling,
      ValueChanged<int> selectedChangedWhenScrollEnd) {
    return Expanded(
      flex: layoutProportion,
      child: Container(
          padding: EdgeInsets.all(8.0),
          height: theme.containerHeight,
          decoration:
              BoxDecoration(color: theme.backgroundColor ?? Colors.white),
          child: NotificationListener(
              onNotification: (ScrollNotification notification) {
                if (notification.depth == 0 &&
                    selectedChangedWhenScrollEnd != null &&
                    notification is ScrollEndNotification &&
                    notification.metrics is FixedExtentMetrics) {
                  final FixedExtentMetrics metrics = notification.metrics;
                  final int currentItemIndex = metrics.itemIndex;
                  selectedChangedWhenScrollEnd(currentItemIndex);
                }
                return false;
              },
              child: CupertinoPicker.builder(
                  key: key,
                  backgroundColor: theme.backgroundColor ?? Colors.white,
                  scrollController: scrollController,
                  itemExtent: theme.itemHeight,
                  onSelectedItemChanged: (int index) {
                    selectedChangedWhenScrolling(index);
                  },
                  useMagnifier: true,
                  itemBuilder: (BuildContext context, int index) {
                    final content = stringAtIndexCB(index);
                    if (content == null) {
                      return null;
                    }
                    return Container(
                      height: theme.itemHeight,
                      alignment: Alignment.center,
                      child: Text(
                        content,
                        style: theme.itemStyle,
                        textAlign: TextAlign.start,
                      ),
                    );
                  }))),
    );
  }

  Widget _renderItemView(DatePickerTheme theme) {
    return Container(
      color: theme.backgroundColor ?? Colors.white,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _renderColumnView(
                  ValueKey(widget.pickerModel.currentLeftIndex()),
                  theme,
                  widget.pickerModel.leftStringAtIndex,
                  leftScrollCtrl,
                  widget.pickerModel.layoutProportions()[0], (index) {
                widget.pickerModel.setLeftIndex(index);
              }, (index) {
                setState(() {
                  refreshScrollOffset();
                  _notifyDateChanged();
                });
              }),
              Text(
                widget.pickerModel.leftDivider(),
                style: theme.itemStyle,
              ),
              _renderColumnView(
                  ValueKey(widget.pickerModel.currentLeftIndex()),
                  theme,
                  widget.pickerModel.middleStringAtIndex,
                  middleScrollCtrl,
                  widget.pickerModel.layoutProportions()[1], (index) {
                widget.pickerModel.setMiddleIndex(index);
              }, (index) {
                setState(() {
                  refreshScrollOffset();
                  _notifyDateChanged();
                });
              }),
              Text(
                widget.pickerModel.rightDivider(),
                style: theme.itemStyle,
              ),
              _renderColumnView(
                  ValueKey(widget.pickerModel.currentMiddleIndex() +
                      widget.pickerModel.currentLeftIndex()),
                  theme,
                  widget.pickerModel.rightStringAtIndex,
                  rightScrollCtrl,
                  widget.pickerModel.layoutProportions()[2], (index) {
                widget.pickerModel.setRightIndex(index);
                _notifyDateChanged();
              }, null),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _renderColumnView(
                  ValueKey(widget.pickerModel2.currentLeftIndex()),
                  theme,
                  widget.pickerModel2.leftStringAtIndex,
                  leftScrollCtrl2,
                  widget.pickerModel2.layoutProportions()[0], (index) {
                widget.pickerModel2.setLeftIndex(index);
              }, (index) {
                setState(() {
                  refreshScrollOffset();
                  _notifyDateChanged();
                });
              }),
              Text(
                widget.pickerModel2.leftDivider(),
                style: theme.itemStyle,
              ),
              _renderColumnView(
                  ValueKey(widget.pickerModel2.currentLeftIndex()),
                  theme,
                  widget.pickerModel2.middleStringAtIndex,
                  middleScrollCtrl2,
                  widget.pickerModel2.layoutProportions()[1], (index) {
                widget.pickerModel2.setMiddleIndex(index);
              }, (index) {
                setState(() {
                  refreshScrollOffset();
                  _notifyDateChanged();
                });
              }),
              Text(
                widget.pickerModel2.rightDivider(),
                style: theme.itemStyle,
              ),
              _renderColumnView(
                  ValueKey(widget.pickerModel2.currentMiddleIndex() +
                      widget.pickerModel2.currentLeftIndex()),
                  theme,
                  widget.pickerModel2.rightStringAtIndex,
                  rightScrollCtrl2,
                  widget.pickerModel2.layoutProportions()[2], (index) {
                widget.pickerModel2.setRightIndex(index);
                _notifyDateChanged();
              }, null),
            ],
          )
        ],
      ),
    );
  }

  // Title View
  Widget _renderTitleActionsView(DatePickerTheme theme) {
    String done = _localeDone();
    String cancel = _localeCancel();

    return Container(
      height: theme.titleHeight,
      decoration: BoxDecoration(color: theme.backgroundColor ?? Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: theme.titleHeight,
            child: CupertinoButton(
              pressedOpacity: 0.3,
              padding: EdgeInsets.only(left: 16, top: 0),
              child: Text(
                '$cancel',
                style: theme.cancelStyle,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Container(
            height: theme.titleHeight,
            child: CupertinoButton(
              pressedOpacity: 0.3,
              padding: EdgeInsets.only(right: 16, top: 0),
              child: Text(
                '$done',
                style: theme.doneStyle,
              ),
              onPressed: () {
                Navigator.pop(context);
                if (widget.route.onConfirm != null) {
                  widget.route.onConfirm(widget.pickerModel.finalTime(),
                      time2: widget.pickerModel2.finalTime()); //todo

                  print(
                      '🌶️，${widget.pickerModel.finalTime()} ----- ${widget.pickerModel2.finalTime()}');
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  String _localeDone() {
    return i18nObjInLocale(widget.locale)['done'];
  }

  String _localeCancel() {
    return i18nObjInLocale(widget.locale)['cancel'];
  }
}

class _BottomPickerLayout extends SingleChildLayoutDelegate {
  _BottomPickerLayout(this.progress, this.theme,
      {this.itemCount, this.showTitleActions});

  final double progress;
  final int itemCount;
  final bool showTitleActions;
  final DatePickerTheme theme;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double maxHeight = theme.containerHeight * 2;
    if (showTitleActions) {
      maxHeight += theme.titleHeight;
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
