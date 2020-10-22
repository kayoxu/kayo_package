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
  static Future showDatePicker(BuildContext context,
      {bool showTitleActions: true,
      DateTime minTime,
      DateTime maxTime,
      DateTime minTime2,
      DateTime maxTime2,
      DateChangedCallback onChanged,
      DateChangedCallback onChanged2,
      DateChangedCallback onConfirm,
      Function onCancel,
      ErrorCallback onError,
      locale: LocaleType.zh,
      DateTime currentTime,
      DateTime currentTime2,
      DatePickerTheme theme,
      String formatType = ymdw,
      bool onlyStart = false,
      bool showWeek = false}) {
    return Navigator.push(
            context,
            new _DatePickerRoute(
              showTitleActions: showTitleActions,
              onChanged: onChanged,
              onChanged2: onChanged2,
              onConfirm: onConfirm,
              onCancel: onCancel,
              locale: locale,
              onError: onError,
              formatType: formatType,
              onlyStart: onlyStart,
              showWeek: showWeek,
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
            ))
//        .then((data) {if (null != onCancel) onCancel();})
        ;
  }

  ///
  /// Display time picker bottom sheet.
  ///
  static Future showTimePicker(
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
    bool showWeek = false,
    String title,
    String startTitle,
    String endTitle,
  }) {
    return Navigator.push(
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
          showWeek: showWeek,
          title: title,
          startTitle: startTitle,
          endTitle: endTitle,
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
  static Future showDateTimePicker(
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
    bool showWeek = false,
    String title,
    String startTitle,
    String endTitle,
  }) {
    return Navigator.push(
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
          showWeek: showWeek,
          title: title,
          startTitle: startTitle,
          endTitle: endTitle,
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
  static Future showPicker(BuildContext context,
      {bool showTitleActions: true,
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
      bool showWeek = false}) {
    return Navigator.push(
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
            showWeek: showWeek,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            pickerModel: pickerModel,
            pickerModel2: pickerModel2));
  }
}

class _DatePickerRoute<T> extends PopupRoute<T> {
  _DatePickerRoute(
      {this.showTitleActions,
      this.onChanged,
      this.onChanged2,
      this.onConfirm,
      this.onCancel,
      this.onError,
      this.formatType,
      this.onlyStart,
      this.showWeek,
      theme,
      this.barrierLabel,
      this.locale,
      RouteSettings settings,
      pickerModel,
      pickerModel2,
      this.title,
      this.startTitle,
      this.endTitle})
      : this.pickerModel = pickerModel ?? DatePickerModel(),
        this.pickerModel2 = pickerModel2 ?? DatePickerModel(),
        this.theme = theme ?? DatePickerTheme(),
        super(settings: settings);

  final bool onlyStart;
  final bool showWeek;
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
  final String title;
  final String startTitle;
  final String endTitle;
  final Function onCancel;

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
          showWeek: showWeek,
          locale: this.locale,
          route: this,
          pickerModel: pickerModel,
          pickerModel2: pickerModel2,
          formatType: formatType,
          title: title,
          startTitle: startTitle,
          endTitle: endTitle),
    );
    ThemeData inheritTheme = Theme.of(context, shadowThemeOnly: true);
    if (inheritTheme != null) {
      bottomSheet = new Theme(data: inheritTheme, child: bottomSheet);
    }
    return bottomSheet;
  }
}

class _DatePickerComponent extends StatefulWidget {
  _DatePickerComponent({
    Key key,
    @required this.route,
    this.onChanged,
    this.onCancel,
    this.onChanged2,
    this.locale,
    this.onlyStart,
    this.showWeek,
    this.formatType,
    this.pickerModel,
    this.pickerModel2,
    this.title,
    this.startTitle,
    this.endTitle,
  });

  final DateChangedCallback onChanged;
  final DateChangedCallback onChanged2;
  final Function onCancel;

  final bool onlyStart;
  final bool showWeek;
  final String formatType;
  final _DatePickerRoute route;

  final LocaleType locale;

  final BasePickerModel pickerModel;
  final BasePickerModel pickerModel2;
  final String title;
  final String startTitle;
  final String endTitle;

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
                  onlystart: widget.onlyStart,
                  showWeek: widget.showWeek),
              child: new GestureDetector(
                child: Material(
                  color: Colors.transparent,
                  child: _renderPickerView(theme, widget.formatType,
                      widget.title, widget.startTitle, widget.endTitle),
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

  Widget _renderPickerView(DatePickerTheme theme, String formatType,
      String title, String startTitle, String endTitle) {
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
                widget.startTitle ?? _startTime(),
                textAlign: TextAlign.center,
                radius: 20,
                border: false,
                color: Color(0xff333333),
                borderColor: Color(0xffE6E6E6),
                size: 15,
                padding: EdgeInsets.only(left: 8, right: 8, top: 1, bottom: 0),
              ),
              visible: widget.onlyStart &&
                      (widget.startTitle == null || widget.startTitle == '')
                  ? Visible.gone
                  : Visible.visible,
            ),
          ),
          Visibility(
            visible: widget.showWeek,
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
              Visibility(
                visible: (length > 1 && widget.formatType.contains('m')),
                child: _renderColumnView(
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
              ),
              Text(
                widget.pickerModel.rightDivider(),
                style: theme.itemStyle,
              ),
              Visibility(
                visible: length > 2 &&
                    (widget.formatType.contains('hm') ||
                        widget.formatType.contains('d')),
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
                visible: length > 3 && widget.formatType.contains('s'),
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
                widget.endTitle ?? _endTime(),
                textAlign: TextAlign.center,
                radius: 20,
                border: false,
                color: Color(0xff333333),
                borderColor: Color(0xffE6E6E6),
                size: 15,
                padding: EdgeInsets.only(left: 8, right: 8, top: 1, bottom: 0),
              ),
            ),
          ),
          Visibility(
            visible: !widget.onlyStart && widget.showWeek,
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
                    visible: length > 2 &&
                        (widget.formatType.contains('hm') ||
                            widget.formatType.contains('d')),
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
                  visible: length > 3 && widget.formatType.contains('s'),
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
              radius: 32,
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

                Navigator.pop(context, "data");
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
              widget.title ??
                  (widget.onlyStart ? _chooseTimeOlnyStart() : _chooseTime()),
              color: Color(0xff191D2D),
              size: 18,
              fontWeight: FontWeight.w600,
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
              onPressed: () {
                Navigator.pop(context);
                if (null != widget.onCancel) widget.onCancel();
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
      {this.itemCount, this.showTitleActions, this.onlystart, this.showWeek});

  final double progress;
  final int itemCount;
  final bool showTitleActions;
  final DatePickerTheme theme;
  final bool onlystart;
  final bool showWeek;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    int timeSize = showWeek ?? true ? 2 : 0;
    double maxHeight = theme.containerHeight * 2 +
        2 * theme.timeTitleHeight +
        timeSize * theme.timeTimeHeight +
        theme.centerLineHeight +
        theme.doneBtnHeight;

    if (onlystart ?? false) {
      int timeSize = showWeek ?? true ? 1 : 0;
      maxHeight = theme.containerHeight * 1 +
          0 * theme.timeTitleHeight +
          timeSize * theme.timeTimeHeight +
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
