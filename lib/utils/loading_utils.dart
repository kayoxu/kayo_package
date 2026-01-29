import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kayo_package/kayo_package.dart';

///
///  kayo_package
///  loading_utils.dart
///
///  Created by kayoxu on 2021/8/4 at 10:58 上午
///  Copyright © 2021 kayoxu. All rights reserved.
///

class LoadingUtils {
  // Simplified singleton pattern
  static final LoadingUtils _instance = LoadingUtils._();
  static LoadingUtils get share => _instance;

  LoadingUtils._();

  Timer? _timer;
  CancelFunc? _loadingCancel;

  static TransitionBuilder? init(
      {TransitionBuilder? builder,
      Color? toastBgColor,
      Color? toastTextColor}) {
    final botToastBuilder = BotToastInit();
    return (BuildContext context, Widget? child) {
      BotToast.defaultOption.notification.animationDuration =
          const Duration(seconds: 1);

      if (builder != null) {
        return botToastBuilder(context, builder(context, child));
      } else {
        return botToastBuilder(context, child);
      }
    };
  }

  static show({String? data, bool dismissOnTap = false, int timeOut = 60}) {
    share._timer?.cancel();
    share._loadingCancel?.call();

    share._timer = Timer(Duration(seconds: timeOut), () {
      dismiss();
      share._timer = null;
    });

    share._loadingCancel = BotToast.showCustomLoading(
      toastBuilder: (cancelFunc) {
        return _buildLoadingWidget(data);
      },
      clickClose: dismissOnTap,
      backButtonBehavior: BackButtonBehavior.ignore,
      align: Alignment.center,
      backgroundColor: Colors.black12,
    );
  }

  static Widget _buildLoadingWidget(String? message) {
    return Builder(builder: (context) {
      final isDark = context.isDark;
      return Container(
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xFF333333).withValues(alpha: 0.9)
              : Colors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (PlatformUtils.isIOS || PlatformUtils.isMacOS)
              CupertinoActivityIndicator(
                  radius: 14, color: isDark ? Colors.white : null)
            else
              SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            if (message != null && message.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                message,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : Colors.black87,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ],
        ),
      );
    });
  }

  static showProgress({required double progress, String? data}) {
    // For now, map progress to normal loading with data
    show(data: '${data ?? ''} ${(progress * 100).toInt()}%');
  }

  static showSuccess({String? data, int? seconds = 2}) {
    _showNotification(data,
        icon: Icons.check_circle,
        color: Colors.green,
        defaultMessageBuilder: (context) =>
            KayoPackageLocalizations.of(context)?.success ?? '成功');
  }

  static showError({String? data, int? seconds = 2}) {
    _showNotification(data,
        icon: Icons.error_outline,
        color: Colors.redAccent,
        defaultMessageBuilder: (context) =>
            KayoPackageLocalizations.of(context)?.error ?? '失败');
  }

  static showInfo({String? data, int? seconds = 2}) {
    _showNotification(data,
        icon: Icons.info_outline,
        color: Colors.blueAccent,
        defaultMessageBuilder: (context) =>
            KayoPackageLocalizations.of(context)?.info ?? '提示');
  }

  static void _showNotification(String? message,
      {required IconData icon,
      required Color color,
      required String Function(BuildContext) defaultMessageBuilder}) {
    BotToast.showCustomNotification(
      toastBuilder: (cancelFunc) {
        return Builder(builder: (context) {
          final isDark = context.isDark;
          return Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF333333) : Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  offset: const Offset(0, 4),
                  blurRadius: 16,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color, size: 22),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    message ?? defaultMessageBuilder(context),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black87,
                      decoration: TextDecoration.none,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 4),
              ],
            ),
          );
        });
      },
      duration: const Duration(seconds: 2),
      align: Alignment.topCenter,
      onlyOne: true,
    );
  }

  static showToast(
      {String? data,
      int timeInSecForIosWeb = 2,
      ToastGravity gravity = ToastGravity.BOTTOM}) {
    if (data == null || data.isEmpty) return;

    // Use the same notification style for toasts, but maybe bottom aligned if requested?
    // For consistency with modern apps, top-pill is usually better, but let's respect gravity roughly
    Alignment align = Alignment.bottomCenter;
    if (gravity == ToastGravity.TOP) align = Alignment.topCenter;
    if (gravity == ToastGravity.CENTER) align = Alignment.center;

    BotToast.showText(
      text: data,
      align: align,
      textStyle: const TextStyle(fontSize: 14, color: Colors.white),
      borderRadius: BorderRadius.circular(8),
      contentColor: Colors.black87,
      duration: Duration(seconds: timeInSecForIosWeb),
    );
  }

  static dismiss() {
    share._timer?.cancel();
    share._timer = null;
    share._loadingCancel?.call();
    share._loadingCancel = null;
    BotToast.closeAllLoading();
  }
}

/// Extension on BuildContext for more elegant loading/toast API.
///
/// Usage:
/// ```dart
/// context.showLoading(message: 'Loading...');
/// context.dismissLoading();
/// context.showSuccess('Operation completed');
/// context.showError('Something went wrong');
/// context.showInfo('FYI');
/// context.showToast('Quick message');
/// ```
extension LoadingContext on BuildContext {
  /// Show a loading indicator with optional message.
  void showLoading(
      {String? message, bool dismissOnTap = false, int timeOut = 60}) {
    LoadingUtils.show(
        data: message, dismissOnTap: dismissOnTap, timeOut: timeOut);
  }

  /// Dismiss the current loading indicator.
  void dismissLoading() => LoadingUtils.dismiss();

  /// Show a success notification.
  void showSuccess(String? message, {int seconds = 2}) {
    LoadingUtils.showSuccess(data: message, seconds: seconds);
  }

  /// Show an error notification.
  void showError(String? message, {int seconds = 2}) {
    LoadingUtils.showError(data: message, seconds: seconds);
  }

  /// Show an info notification.
  void showInfo(String? message, {int seconds = 2}) {
    LoadingUtils.showInfo(data: message, seconds: seconds);
  }

  /// Show a toast message.
  void showToast(
    String message, {
    int duration = 2,
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) {
    LoadingUtils.showToast(
      data: message,
      timeInSecForIosWeb: duration,
      gravity: gravity,
    );
  }
}
