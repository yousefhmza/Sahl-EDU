import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../extensions/num_extensions.dart';
import '../../resources/resources.dart';

class CustomAppbar extends StatelessWidget with PreferredSizeWidget {
  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color? bgColor;
  final double? titleSpacing;
  final Widget? flexibleSpace;

  const CustomAppbar({
    this.leading,
    this.title,
    this.actions,
    this.bgColor,
    this.titleSpacing,
    this.flexibleSpace,
    this.centerTitle = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: titleSpacing,
      leading: leading,
      title: title,
      actions: actions,
      backgroundColor: bgColor,
      elevation: AppSize.s0,
      centerTitle: centerTitle,
      flexibleSpace: flexibleSpace,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.h);
}
