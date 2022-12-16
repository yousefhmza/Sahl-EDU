import 'package:flutter/material.dart';

import '../../core/extensions/num_extensions.dart';
import '../../core/resources/resources.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppColors.white,

    /// Progress indicator theme
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: AppColors.primary),

    /// Icon theme
    iconTheme: const IconThemeData(color: AppColors.black),

    /// Text fields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      iconColor: AppColors.black,
      hintStyle: TextStyle(
        color: AppColors.black.withOpacity(0.66),
        fontSize: FontSize.s14.sp,
        fontFamily: FontConstants.fontFamily,
      ),
      contentPadding: EdgeInsets.all(AppPadding.p10.w),
      errorStyle: TextStyle(
        fontSize: FontSize.s12.sp,
        color: AppColors.red,
        fontFamily: FontConstants.fontFamily,
      ),
      errorMaxLines: 2,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(AppSize.s100.r),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(AppSize.s100.r),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.red),
        borderRadius: BorderRadius.circular(AppSize.s100.r),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(AppSize.s100.r),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(AppSize.s100.r),
      ),
    ),
  );
}
