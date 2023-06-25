// import 'package:flutter/material.dart';
// import 'package:kayo_package/kayo_package.dart';
// import 'package:kayo_package/utils/base_color_utils.dart';
// import 'package:kayo_package/views/widget/visible_view.dart';
// import 'package:kayo_package/views/widget/alert/flutter_cupertino_data_picker.dart';
// import 'package:kayo_package/views/widget/base/button_view.dart';
// import 'package:kayo_package/views/widget/base/clickable.dart';
// import 'package:kayo_package/views/widget/base/edit_view.dart';
// import 'package:kayo_package/views/widget/base/text_view.dart';
// import 'package:flutter/material.dart';
// import 'package:mpcore/mpcore.dart';
// ///  kayo_plugin
// ///  views.widget.alert
// ///
// ///  Created by kayoxu on 2019/2/21 9:47 AM.
// ///  Copyright © 2019 kayoxu. All rights reserved.
//
// class AlertCenter {
//   static showVisitorCheckDialog(
//     BuildContext context, {
//     Function()? onOk,
//     ValueChanged<int>? onDataChanged,
//     TextEditingController? controller,
//   }) {
//     String checkStatus = '请选择审核意见';
//
//     content(state) {
//       return Container(
//         child: Column(
//           children: <Widget>[
//             Padding(
//               padding: EdgeInsets.only(left: 32, right: 32, top: 16),
//               child: Row(
//                 children: <Widget>[
//                   TextView(
//                     '审核结果:',
//                     width: 80,
//                   ),
//                   Expanded(
//                       child: Clickable(
//                     bgColor: BaseColorUtils.white,
//                     child: TextView(
//                       checkStatus,
//                       size: 14,
//                       maxLine: 2,
//                       textAlign: TextAlign.left,
//                       color: Color(0xff727272),
//                     ),
//                     onTap: () {
//                       DataPicker.showDataPicker(context, datas: ['通过', '拒绝'],
//                           onConfirm: (data) {
//                         int? d;
//                         if (data == '通过') {
//                           d = 2;
//                         } else if (data == '拒绝') {
//                           d = 3;
//                         }
//                         onDataChanged?.call(d ?? 0);
//                         state(() {
//                           checkStatus = data;
//                         });
//                       });
//                     },
//                   )),
//                   Icon(Icons.arrow_drop_down,
//                       color: BaseColorUtils.colorGreyLiteLite)
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 32, right: 32, top: 16),
//               child: EditView(
//                 hintText: '请输入备注',
//                 maxLines: 3,
//                 padding: EdgeInsets.only(left: 16, right: 16),
//                 margin: EdgeInsets.all(0),
//                 controller: controller,
//                 showBorder: true,
//               ),
//             )
//           ],
//         ),
//       );
//     }
//   }
//
//   static showMsgDialog(BuildContext context,
//       {required String title,
//       String? message,
//       bool? showCancel,
//       String? okTitle,
//       Widget? content,
//       String? cancelTitle,
//       bool cancelable = false,
//       EdgeInsets? margin,
//       Color cancelColor = BaseColorUtils.colorBlack,
//       Color okColor = BaseColorUtils.colorBlack,
//       Function()? onOk,
//       Function()? onCancel}) {
//     showDialog(
//         context: context,
//         barrierDismissible: cancelable,
//         builder: (context) => AlertDefaultView(
//               context,
//               title: title,
//               message: message,
//               content: content,
//               showCancel: showCancel,
//               okTitle: okTitle,
//               okColor: okColor,
//               cancelColor: cancelColor,
//               cancelTitle: cancelTitle,
//               onOK: onOk,
//               onCancel: onCancel,
//               margin: margin,
//             ));
//   }
// }
//
// Widget AlertDefaultView(
//   BuildContext? context, {
//   var title,
//   var message,
//   Widget? content,
//   Function()? onOK,
//   Function()? onCancel,
//   bool? showCancel,
//   String? okTitle,
//   Color? cancelColor,
//   Color? okColor,
//   String? cancelTitle,
//   EdgeInsets? margin,
// }) {
//   return new Container(
//       margin: margin,
//       alignment: Alignment.center,
//       padding: const EdgeInsets.all(12.0),
//       child: new Material(
//           borderOnForeground: false,
//           borderRadius: BorderRadius.all(
//             Radius.circular(12.0),
//           ),
// //          type: MaterialType.transparency,
//           child: new Column(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 new Container(
//                     decoration: ShapeDecoration(
//                         color: Color(0xFFFFFFFF),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.all(
//                           Radius.circular(8.0),
//                         ))),
//                     margin: const EdgeInsets.all(0),
//                     child: Container(
//                       child: new Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: <Widget>[
//                             new TextView(
//                               title,
//                               size: 20,
//                               margin:
//                                   EdgeInsets.only(left: 20, top: 20, right: 20),
//                             ),
//                             VisibleView(
//                                 visible: null != message
//                                     ? Visible.visible
//                                     : Visible.gone,
//                                 child: TextView(
//                                   message,
//                                   size: 14,
//                                   maxLine: 20,
//                                   margin: EdgeInsets.only(left: 16, right: 16),
//                                 )),
//                             VisibleView(
//                               child: content!,
//                               visible: null != content
//                                   ? Visible.visible
//                                   : Visible.gone,
//                             ),
//                             Container(
//                               height: 60,
//                               child: new Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: buildButtonAction(context,
//                                       okColor: okColor,
//                                       cancelColor: cancelColor,
//                                       showCancel: showCancel,
//                                       okTitle: okTitle,
//                                       cancelTitle: cancelTitle,
//                                       onOk: onOK,
//                                       onCancel: onCancel)),
//                             )
//                           ]),
//                     ))
//               ])));
// }
//
// class AlertDefault extends MPWebDialogs {
//   var title;
//   var message;
//   Widget? content;
//   Function()? onOK;
//   Function()? onCancel;
//   bool? showCancel;
//   String? okTitle;
//   String? cancelTitle;
//   EdgeInsets? margin;
//
//   AlertDefault({
//     Key? key,
//     required this.title,
//     this.message,
//     this.content,
//     this.showCancel = true,
//     this.okTitle,
//     this.cancelTitle,
//     this.onOK,
//     this.onCancel,
//     this.margin,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return new Container(
//         margin: margin,
//         padding: const EdgeInsets.all(12.0),
//         child: new Material(
//             borderOnForeground: false,
//             borderRadius: BorderRadius.all(
//               Radius.circular(12.0),
//             ),
// //            type: MaterialType.transparency,
//             child: new Column(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   new Container(
//                       decoration: ShapeDecoration(
//                           color: Color(0xFFFFFFFF),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.all(
//                             Radius.circular(8.0),
//                           ))),
//                       margin: const EdgeInsets.all(0),
//                       child: Container(
//                         child: new Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: <Widget>[
//                               new TextView(
//                                 this.title,
//                                 size: 20,
//                                 margin: EdgeInsets.only(
//                                     left: 20, top: 20, right: 20),
//                               ),
//                               VisibleView(
//                                   visible: null != message
//                                       ? Visible.visible
//                                       : Visible.gone,
//                                   child: TextView(
//                                     this.message,
//                                     size: 14,
//                                     maxLine: 20,
//                                     margin:
//                                         EdgeInsets.only(left: 16, right: 16),
//                                   )),
//                               VisibleView(
//                                 child: content!,
//                                 visible: null != content
//                                     ? Visible.visible
//                                     : Visible.gone,
//                               ),
//                               Container(
//                                 height: 60,
//                                 child: new Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: buildButtonAction(context,
//                                         showCancel: this.showCancel,
//                                         okTitle: this.okTitle,
//                                         cancelTitle: this.cancelTitle,
//                                         onOk: this.onOK,
//                                         onCancel: this.onCancel)),
//                               )
//                             ]),
//                       ))
//                 ])));
//   }
// }
//
// List<Widget> buildButtonAction(context,
//     {bool? showCancel,
//     String? okTitle,
//     String? cancelTitle,
//     Function()? onOk,
//     Color? cancelColor,
//     Color? okColor,
//     Function()? onCancel}) {
//   if (null == onOk) onOk = () {};
//   if (null == onCancel) onCancel = () {};
//
//   if (null == okTitle) okTitle = '确定';
//   if (null == cancelTitle) cancelTitle = '取消';
//
//   List<Widget> widgets = [];
//
//   var ok =
//       _buttonAction(title: okTitle, left: false, onClick: onOk, color: okColor);
//
//   var cancel = _buttonAction(
//       title: cancelTitle, left: true, onClick: onCancel, color: cancelColor);
//   if (false != showCancel) widgets.add(cancel);
//   widgets.add(ok);
//
//   return widgets;
// }
//
// Widget _buttonAction(
//     {String? title,
//     Color? color,
//     Color? bgColor,
//     Function()? onClick,
//     bool? left}) {
//   return Expanded(
//       child: ButtonView(
//     text: title ?? '',
//     height: double.infinity,
//     borderRadius: BorderRadius.only(
//         bottomLeft: Radius.circular(true == left ? 8 : 0),
//         bottomRight: Radius.circular(false == left ? 8 : 0)),
//     margin: EdgeInsets.only(top: 16),
//     bgColor: bgColor ?? BaseColorUtils.white,
//     showShadow: true,
//     color: color ?? BaseColorUtils.colorBlack,
//     onPressed: onClick!,
//   ));
// }
