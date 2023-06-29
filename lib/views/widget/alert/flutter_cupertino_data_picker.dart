import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayo_package/kayo_package.dart';
import 'package:mpcore/mpcore.dart';

typedef DataChangedCallback(dynamic data);
typedef DataChangedCallbackMore<T>(List<int> indexes, List<T> data);
typedef DataChangedCallback2(int index, dynamic data);

class DataPickerLocale {
  static const String en_us = 'en';

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

    return showMPDialog(
        context: context,
        builder: (BuildContext context) {
          return BottomSheetSingleWidgetNew(
            datas: datas,
            showTitleActions: showTitleActions,
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
  }
}

class BottomSheetSingleWidgetNew<T> extends StatefulWidget {
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
  final bool? showTitleActions;

  const BottomSheetSingleWidgetNew(
      {Key? key,
      this.datas,
      this.selectedIndex,
      this.selectedIndexes,
      this.showTitleActions,
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

class _BottomSheetSingleState<T> extends State<BottomSheetSingleWidgetNew<T>> {
  double itemHeight = 56;
  double marginBottom = 10;

  late List<int> selectedIndexes;
  bool multipleChoice = false;

  @override
  void initState() {
    super.initState();
    // selectedIndex = widget.selectedIndex ?? 0;
    selectedIndexes = widget.selectedIndexes ?? [widget.selectedIndex ?? 0];
    multipleChoice = widget.multipleChoice ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return ToolBar(
      backgroundColor: BaseColorUtils.colorWhite,
      title: widget.showTitleActions == false
          ? ''
          : widget.title.defaultStr(data: '请选择') +
              '${'${multipleChoice == true ? '(可多选)' : ''}'}',
      // leadingIcon: MPIcon(MaterialIcons.close),
      noBack: true,
      child: SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: itemHeight,
            child: Row(
              children: [
                GestureDetector(
                  child: Container(
                    height: 40,
                    padding: EdgeInsets.only(left: 16),
                    alignment: Alignment.centerLeft,
                    width: 100,
                    child: MPIcon(
                      MaterialIcons.close,
                      color: BaseColorUtils.darkBlackLiteLite(context: context),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(child: Container()),
                Container(
                  width: 100,
                  alignment: Alignment.centerRight,
                  child: TextView(
                    widget.isEN == true ? 'Done' : '确定',
                    radius: 10,
                    color: BaseColorUtils.darkPrimary2(context: context),
                    size: 15,
                    fontWeight: FontWeight.w600,
                    padding: EdgeInsets.only(
                        left: 17, right: 17, bottom: 12, top: 12),
                    margin: EdgeInsets.only(right: 6),
                    onTap: () {
                      widget.onConfirm?.call(widget.datas?[selectedIndexes[0]]);
                      widget.onConfirm2?.call(selectedIndexes[0],
                          widget.datas?[selectedIndexes[0]]);
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
                  ),
                ),
              ],
            ),
          ),
          LineView(
            height: .5,
            color: BaseColorUtils.darkWindow(context: context).dark,
          ),
          Expanded(
              child: ListView.separated(
            separatorBuilder: (context, index) {
              return LineView(
                color: BaseColorUtils.darkPrimary2(context: context)
                    .withOpacity(.1),
                height: .5,
              );
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                child: Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextView(
                          widget.datas?[index]?.toString() ?? '',
                          size: 14,
                          color: selectedIndexes.contains(index)
                              ? BaseColorUtils.darkBlack(context: context)
                              : BaseColorUtils.darkBlack(context: context),
                          fontWeight: selectedIndexes.contains(index)
                              ? FontWeight.w600
                              : FontWeight.w600,
                        ),
                      ),
                      selectedIndexes.contains(index)
                          ? MPIcon(
                              MaterialIcons.check,
                              color:
                                  BaseColorUtils.darkPrimary2(context: context),
                              size: 18,
                            )
                          : Container(
                              height: 17,
                              width: 17,
                            )
                    ],
                  ),
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
          ))
        ],
      )),
    );
  }
}
