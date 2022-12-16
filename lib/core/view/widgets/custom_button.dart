import 'package:flutter/material.dart';

import '../views.dart';
import '../../resources/resources.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color? color;
  final Color? textColor;
  final Widget? child;
  final double? width;
  final double? height;
  final double fontSize;
  final double? textHeight;
  final double borderRadius;

  const CustomButton({
    Key? key,
    this.onPressed,
    this.text = "",
    this.color = AppColors.black,
    this.textColor,
    this.child,
    this.width,
    this.height,
    this.textHeight,
    this.fontSize = FontSize.s14,
    this.borderRadius = AppSize.s16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: BoxDecoration(
            color: onPressed != null ? color : AppColors.grey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(borderRadius),
            child: Container(
              padding: height != null ? EdgeInsets.zero : const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: text.isNotEmpty
                  ? CustomText(
                      text,
                      fontWeight: FontWeightManager.bold,
                      color: textColor ?? AppColors.white,
                      fontSize: fontSize,
                      textAlign: TextAlign.center,
                      height: textHeight,
                    )
                  : child,
            ),
          ),
        ),
      ),
    );
  }
}
