import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';
import 'package:kayo_package/utils/base_time_utils.dart';
import 'package:kayo_package/views/widget/base/button_view.dart';
import 'package:kayo_package/views/widget/base/text_view.dart';

import 'date_format.dart';
import 'date_model.dart';
import 'datetime_picker_theme.dart';
import 'i18n_model.dart';

typedef DateChangedCallback(DateTime time, {DateTime time2});
typedef ErrorCallback(String error);
typedef String StringAtIndexCallBack(int index);

//String formatType;

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
    ErrorCallback onError,
    locale: LocaleType.zh,
    DateTime currentTime,
    DateTime currentTime2,
    DatePickerTheme theme,
    String formatType = ymdw,
    bool onlyStart = false,
  }) {
    Navigator.push(
        context,
        new _DatePickerRoute(
          showTitleActions: showTitleActions,
          onChanged: onChanged,
          onChanged2: onChanged2,
          onConfirm: onConfirm,
          locale: locale,
          onError: onError,
          formatType: formatType,
          onlyStart: onlyStart,
          theme: theme,
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          pickerModel: DatePickerModel(
              currentTime: currentTime,
              maxTime: maxTime,
              minTime: minTime,
              formatType: formatType,
              locale: locale),
          pickerModel2: DatePickerModel(
              currentTime: currentTime2,
              maxTime: maxTime2,
              minTime: minTime2,
              formatType: formatType,
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
    locale: LocaleType.zh,
    DateTime currentTime,
    ErrorCallback onError,
    DateTime currentTime2,
    DatePickerTheme theme,
    String formatType = hms,
    bool onlyStart = false,
  }) {
    Navigator.push(
        context,
        new _DatePickerRoute(
          showTitleActions: showTitleActions,
          onChanged: onChanged,
          onChanged2: onChanged2,
          onConfirm: onConfirm,
          locale: locale,
          onError: onError,
          formatType: formatType,
          theme: theme,
          onlyStart: onlyStart,
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
    ErrorCallback onError,
    String formatType = ymdhmsw,
    DateTime minTime,
    DateTime maxTime,
    DateTime minTime2,
    DateTime maxTime2,
    locale: LocaleType.zh,
    DateTime currentTime,
    DateTime currentTime2,
    DatePickerTheme theme,
    bool onlyStart = false,
  }) {
    Navigator.push(
        context,
        new _DatePickerRoute(
          showTitleActions: showTitleActions,
          onChanged: onChanged,
          onChanged2: onChanged2,
          onConfirm: onConfirm,
          onError: onError,
          formatType: formatType,
          locale: locale,
          theme: theme,
          onlyStart: onlyStart,
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          pickerModel: DateTimePickerModel(
              currentTime: currentTime,
              maxTime: maxTime,
              minTime: minTime,
              locale: locale),
          pickerModel2: DateTimePickerModel(
              currentTime: currentTime2,
              maxTime: maxTime2,
              minTime: minTime2,
              locale: locale),
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
    ErrorCallback onError,
    String formatType = ymdw,
    locale: LocaleType.zh,
    BasePickerModel pickerModel,
    BasePickerModel pickerModel2,
    DatePickerTheme theme,
    bool onlyStart = false,
  }) {
    Navigator.push(
        context,
        new _DatePickerRoute(
            showTitleActions: showTitleActions,
            onChanged: onChanged,
            onChanged2: onChanged2,
            onConfirm: onConfirm,
            onError: onError,
            formatType: formatType,
            locale: locale,
            theme: theme,
            onlyStart: onlyStart,
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
    this.onError,
    this.formatType,
    this.onlyStart,
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

  final bool onlyStart;
  final bool showTitleActions;
  final DateChangedCallback onChanged;
  final DateChangedCallback onChanged2;
  final DateChangedCallback onConfirm;
  final DatePickerTheme theme;
  final LocaleType locale;
  final BasePickerModel pickerModel;
  final BasePickerModel pickerModel2;
  final ErrorCallback onError;
  final String formatType;

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
        onlyStart: onlyStart,
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
      this.onlyStart,
      this.pickerModel,
      this.pickerModel2});

  final DateChangedCallback onChanged;
  final DateChangedCallback onChanged2;

  final bool onlyStart;
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
  FixedExtentScrollController leftScrollCtrl,
      middleScrollCtrl,
      rightScrollCtrl,
      rightScrollCtrl01;
  FixedExtentScrollController leftScrollCtrl2,
      middleScrollCtrl2,
      rightScrollCtrl2,
      rightScrollCtrl201;

  @override
  void initState() {
    super.initState();
    refreshScrollOffset();
  }

  void refreshScrollOffset() {
    leftScrollCtrl = new FixedExtentScrollController(
        initialItem: widget.pickerModel.currentLeftIndex() ?? 0);
    middleScrollCtrl = new FixedExtentScrollController(
        initialItem: widget.pickerModel.currentMiddleIndex() ?? 0);
    rightScrollCtrl = new FixedExtentScrollController(
        initialItem: widget.pickerModel.currentRightIndex() ?? 0);

    rightScrollCtrl01 = new FixedExtentScrollController(
        initialItem: widget.pickerModel.currentRightIndex01() ?? 0);

    leftScrollCtrl2 = new FixedExtentScrollController(
        initialItem: widget.pickerModel2.currentLeftIndex() ?? 0);
    middleScrollCtrl2 = new FixedExtentScrollController(
        initialItem: widget.pickerModel2.currentMiddleIndex() ?? 0);
    rightScrollCtrl2 = new FixedExtentScrollController(
        initialItem: widget.pickerModel2.currentRightIndex() ?? 0);
    rightScrollCtrl201 = new FixedExtentScrollController(
        initialItem: widget.pickerModel2.currentRightIndex01() ?? 0);
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
                  showTitleActions: widget.route.showTitleActions,
                  onlystart: widget.onlyStart),
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
    var length = widget.pickerModel2.layoutProportions().length;

    String done = _localeDone();

    return Container(
      color: theme.backgroundColor ?? Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            height: theme.timeTitleHeight,
            padding: EdgeInsets.all(3),
            child: VisibleView(
              child: TextView(
                _startTime(),
                textAlign: TextAlign.center,
                radius: 20,
                border: true,
                color: Color(0xff888A8E),
                borderColor: Color(0xffE6E6E6),
                size: 13,
                padding: EdgeInsets.only(left: 8, right: 8, top: 1, bottom: 0),
              ),
              visible: widget.onlyStart ? Visible.gone : Visible.visible,
            ),
          ),
          Visibility(
            child: Container(
                height: theme.timeTimeHeight,
                padding: EdgeInsets.all(3),
                child: TextView(
                  formatDate(widget.pickerModel.finalTime(),
                      [widget.route.formatType], widget.locale),
                  color: Color(0xff1E6FF4),
                  fontWeight: FontWeight.bold,
                  size: 14,
                  padding:
                      EdgeInsets.only(left: 8, right: 8, top: 0, bottom: 0),
                )),
          ),
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
              Visibility(
                visible: length > 2,
                child: _renderColumnView(
                    ValueKey(widget.pickerModel.currentMiddleIndex() +
                        widget.pickerModel.currentLeftIndex()),
                    theme,
                    widget.pickerModel.rightStringAtIndex,
                    rightScrollCtrl,
                    widget.pickerModel.layoutProportions()[2 < length ? 2 : 0],
                    (index) {
                  widget.pickerModel.setRightIndex(index);
                  _notifyDateChanged();
                }, (index) {
                  setState(() {
                    refreshScrollOffset();
                    _notifyDateChanged();
                  });
                }),
              ),
              Text(
                widget.pickerModel.rightDivider01(),
                style: theme.itemStyle,
              ),
              Visibility(
                visible: length > 3,
                child: _renderColumnView(
                    ValueKey(widget.pickerModel.currentMiddleIndex() +
                        widget.pickerModel.currentLeftIndex()),
                    theme,
                    widget.pickerModel.rightStringAtIndex01,
                    rightScrollCtrl01,
                    widget.pickerModel.layoutProportions()[3 < length ? 3 : 0],
                    (index) {
                  widget.pickerModel.setRightIndex01(index);
                  _notifyDateChanged();
                }, (index) {
                  setState(() {
                    refreshScrollOffset();
                    _notifyDateChanged();
                  });
                }),
              )
            ],
          ),
          VisibleView(
            visible: widget.onlyStart ? Visible.gone : Visible.visible,
            child: Container(
              height: theme.timeTitleHeight,
              padding: EdgeInsets.all(3),
              margin: EdgeInsets.only(top: theme.centerLineHeight),
              child: TextView(
                _endTime(),
                textAlign: TextAlign.center,
                radius: 20,
                border: true,
                color: Color(0xff888A8E),
                borderColor: Color(0xffE6E6E6),
                size: 13,
                padding: EdgeInsets.only(left: 8, right: 8, top: 1, bottom: 0),
              ),
            ),
          ),
          Visibility(
            visible: !widget.onlyStart,
            child: Container(
                height: theme.timeTimeHeight,
                padding: EdgeInsets.all(3),
                child: TextView(
                  formatDate(widget.pickerModel2.finalTime(),
                      [widget.route.formatType], widget.locale),
                  color: Color(0xffFF9117),
                  fontWeight: FontWeight.bold,
                  size: 14,
                  padding:
                      EdgeInsets.only(left: 8, right: 8, top: 0, bottom: 0),
                )),
          ),
          VisibleView(
            visible: widget.onlyStart ? Visible.gone : Visible.visible,
            child: Row(
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
                Visibility(
                    visible: length > 2,
                    child: _renderColumnView(
                        ValueKey(widget.pickerModel2.currentMiddleIndex() +
                            widget.pickerModel2.currentLeftIndex()),
                        theme,
                        widget.pickerModel2.rightStringAtIndex,
                        rightScrollCtrl2,
                        widget.pickerModel2
                            .layoutProportions()[2 < length ? 2 : 0], (index) {
                      widget.pickerModel2.setRightIndex(index);
                      _notifyDateChanged();
                    }, (index) {
                      setState(() {
                        refreshScrollOffset();
                        _notifyDateChanged();
                      });
                    })),
                Text(
                  widget.pickerModel2.rightDivider01(),
                  style: theme.itemStyle,
                ),
                Visibility(
                  visible: length > 3,
                  child: _renderColumnView(
                      ValueKey(widget.pickerModel2.currentMiddleIndex() +
                          widget.pickerModel2.currentLeftIndex()),
                      theme,
                      widget.pickerModel2.rightStringAtIndex01,
                      rightScrollCtrl201,
                      widget.pickerModel2
                          .layoutProportions()[3 < length ? 3 : 0], (index) {
                    widget.pickerModel2.setRightIndex01(index);
                    _notifyDateChanged();
                  }, (index) {
                    setState(() {
                      refreshScrollOffset();
                      _notifyDateChanged();
                    });
                  }),
                )
              ],
            ),
          ),
          Container(
            height: theme.doneBtnHeight,
            child: ButtonView(
              width: double.infinity,
              margin: EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 17),
              text: '$done',
              bgColor: theme.doneColor,
              showShadow: false,
              color: Colors.white,
              onPressed: () {
                if (widget.pickerModel
                        .finalTime()
                        .isAfter(widget.pickerModel2.finalTime()) &&
                    !widget.onlyStart) {
                  if (null != widget.route.onError)
                    widget.route.onError(_chooseTimeError());
                  return;
                }

                Navigator.pop(context);
                if (widget.route.onConfirm != null) {
                  var finalTime = widget.pickerModel.finalTime();
                  var finalTime2 = widget.pickerModel2.finalTime();

                  var format = widget.route.formatType ?? '';

                  if (format == ym) {
                    finalTime =
                        BaseTimeUtils.getMonth(now: finalTime, start: true);
                    finalTime2 =
                        BaseTimeUtils.getMonth(now: finalTime2, start: false);
                  }

                  widget.route.onConfirm(finalTime, time2: finalTime2);
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

  // Title View
  Widget _renderTitleActionsView(DatePickerTheme theme) {
    String cancel = _localeCancel();

    return Container(
      height: theme.titleHeight,
      decoration: BoxDecoration(
          color: theme.backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 16, top: 0),
            height: theme.titleHeight,
            child: TextView(
              widget.onlyStart ? _chooseTimeOlnyStart() : _chooseTime(),
              color: Color(0xff191D2D),
              size: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            height: theme.titleHeight,
            child: CupertinoButton(
              pressedOpacity: 0.3,
              padding: EdgeInsets.only(right: 16, top: 0),
              child: Text(
                '$cancel',
                style: theme.cancelStyle,
              ),
              onPressed: () => Navigator.pop(context),
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

  String _startTime() {
    return i18nObjInLocale(widget.locale)['startTime'] as String;
  }

  String _endTime() {
    return i18nObjInLocale(widget.locale)['endTime'] as String;
  }

  String _chooseTime() {
    return i18nObjInLocale(widget.locale)['chooseTime'] as String;
  }

  String _chooseTimeOlnyStart() {
    return i18nObjInLocale(widget.locale)['chooseTimeOlnyStart'] as String;
  }

  String _chooseTimeError() {
    return i18nObjInLocale(widget.locale)['chooseTimeError'] as String;
  }
}

class _BottomPickerLayout extends SingleChildLayoutDelegate {
  _BottomPickerLayout(this.progress, this.theme,
      {this.itemCount, this.showTitleActions, this.onlystart});

  final double progress;
  final int itemCount;
  final bool showTitleActions;
  final DatePickerTheme theme;
  final bool onlystart;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double maxHeight = theme.containerHeight * 2 +
        2 * theme.timeTitleHeight +
        2 * theme.timeTimeHeight +
        theme.centerLineHeight +
        theme.doneBtnHeight;

    if (onlystart ?? false) {
      maxHeight = theme.containerHeight * 1 +
          0 * theme.timeTitleHeight +
          1 * theme.timeTimeHeight +
          theme.centerLineHeight +
          theme.doneBtnHeight;
    }

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
