import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/resources/resources.dart';
import '../../../../core/view/views.dart';

class UserCard extends StatelessWidget {
  final bool isChosen;
  final String text;
  final VoidCallback onTap;
  final String img;

  const UserCard({
    required this.isChosen,
    required this.text,
    required this.onTap,
    required this.img,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Time.t150,
        height: isChosen ? deviceHeight * 0.37 : deviceHeight * 0.35,
        width: isChosen ? deviceWidth * 0.42 : deviceWidth * 0.4,
        clipBehavior: Clip.antiAlias,
        foregroundDecoration: BoxDecoration(
          border: Border.all(color: isChosen ? AppColors.primary : AppColors.black, width: AppSize.s1),
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: isChosen ? AppColors.primary : AppColors.black, width: AppSize.s1),
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
        child: Column(
          children: [
            Expanded(child: SvgPicture.asset(img)),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppPadding.p8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isChosen ? AppColors.primary : AppColors.black,
              ),
              child: CustomText(text, fontSize: FontSize.s16, color: AppColors.white),
            )
          ],
        ),
      ),
    );
  }
}
