import 'package:flutter/material.dart';
import 'package:sahl_edu/core/view/views.dart';

import '../../../config/navigation/navigation.dart';
import '../../resources/resources.dart';

class PickImageSheetComponent extends StatelessWidget {
  final Future<void> Function() onGallery;
  final Future<void> Function() onCamera;

  const PickImageSheetComponent({required this.onGallery, required this.onCamera, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: () async {
            await onGallery();
            // ignore: use_build_context_synchronously
            NavigationService.goBack(context);
          },
          horizontalTitleGap: AppSize.s0,
          leading: const CustomIcon(Icons.image, color: AppColors.black),
          title: const CustomText(AppStrings.gallery),
        ),
        ListTile(
          onTap: () async {
            await onCamera();
            // ignore: use_build_context_synchronously
            NavigationService.goBack(context);
          },
          horizontalTitleGap: AppSize.s0,
          leading: const CustomIcon(Icons.camera_alt, color: AppColors.black),
          title: const CustomText(AppStrings.camera),
        ),
        ListTile(
          onTap: () => NavigationService.goBack(context),
          horizontalTitleGap: AppSize.s0,
          leading: const CustomIcon(Icons.cancel, color: AppColors.black),
          title: const CustomText(AppStrings.cancel),
        ),
      ],
    );
  }
}
