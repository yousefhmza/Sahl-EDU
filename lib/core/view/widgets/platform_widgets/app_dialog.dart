import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../views.dart';
import '../../../resources/resources.dart';
import '../../../../config/navigation/navigation.dart';

class AppDialog extends BasePlatformWidget<AlertDialog, CupertinoAlertDialog> {
  final String title;
  final VoidCallback onConfirm;
  final String confirmText;
  final String? description;

  const AppDialog({
    required this.title,
    required this.onConfirm,
    required this.confirmText,
    this.description,
    Key? key,
  }) : super(key: key);

  @override
  CupertinoAlertDialog createCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: CustomText(title, fontWeight: FontWeightManager.medium, fontSize: FontSize.s16),
      content: description != null ? CustomText(description!) : null,
      actions: [
        CustomTextButton(
          text: AppStrings.cancel,
          textColor: AppColors.primary,
          onPressed: () => NavigationService.goBack(context),
        ),
        CustomTextButton(
          text: confirmText,
          onPressed: () {
            NavigationService.goBack(context);
            onConfirm();
          },
        ),
      ],
    );
  }

  @override
  AlertDialog createMaterialWidget(BuildContext context) {
    return AlertDialog(
      title: CustomText(title, fontWeight: FontWeightManager.medium, fontSize: FontSize.s16),
      content: description != null ? CustomText(description!) : null,
      actions: [
        CustomTextButton(
          text: AppStrings.cancel,
          textColor: AppColors.primary,
          onPressed: () => NavigationService.goBack(context),
        ),
        CustomTextButton(
          text: confirmText,
          onPressed: () {
            NavigationService.goBack(context);
            onConfirm();
          },
        ),
      ],
    );
  }
}
