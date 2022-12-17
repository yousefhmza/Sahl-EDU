import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../resources/resources.dart';
import '../view/views.dart';
import '../extensions/num_extensions.dart';

class Alerts {
  static void showSnackBar(
    BuildContext context,
    String message, {
    bool forError = true,
    Duration duration = Time.t2000,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration,
        backgroundColor: forError ? AppColors.red : AppColors.dracula,
        content: CustomText(message, color: AppColors.white, fontSize: FontSize.s14),
      ),
    );
  }

  static void showActionSnackBar(
    BuildContext context, {
    required String message,
    required String actionLabel,
    required VoidCallback onActionPressed,
    Duration duration = Time.longTime,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration,
        backgroundColor: AppColors.dracula,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(AppPadding.p16.w),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s8.r)),
        action: SnackBarAction(label: actionLabel, onPressed: onActionPressed, textColor: AppColors.white),
        content: CustomText(message, color: AppColors.white, fontSize: FontSize.s14),
      ),
    );
  }

  static void showToast(
    String message, [
    Toast length = Toast.LENGTH_SHORT,
    ToastGravity toastGravity = ToastGravity.BOTTOM,
  ]) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: length,
      gravity: toastGravity,
      timeInSecForIosWeb: 3,
      fontSize: FontSize.s14,
    );
  }

  static Future<T?> showAppDialog<T>(
    BuildContext context, {
    required String title,
    required VoidCallback onConfirm,
    required String confirmText,
    String? description,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => AppDialog(
        title: title,
        description: description,
        confirmText: confirmText,
        onConfirm: onConfirm,
      ),
    );
  }

  static void showBottomSheet(BuildContext context, {required Widget child}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.s32.r)),
      ),
      constraints: BoxConstraints(maxHeight: deviceHeight * 0.8),
      builder: (context) => AppBottomSheet(child: child),
    );
  }
}
