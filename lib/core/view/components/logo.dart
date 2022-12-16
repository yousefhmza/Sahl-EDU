import 'package:flutter/material.dart';

import 'package:sahl_edu/core/extensions/num_extensions.dart';
import '../../resources/resources.dart';

class SahlEDULogo extends StatelessWidget {
  const SahlEDULogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "Sahl",
            style: TextStyle(
              color: AppColors.black,
              fontSize: FontSize.s48.sp,
              fontFamily: FontConstants.fontFamily,
              fontWeight: FontWeightManager.bold,
            ),
          ),
          TextSpan(
            text: "EDU",
            style: TextStyle(
              color: AppColors.primary,
              fontSize: FontSize.s48.sp,
              fontFamily: FontConstants.fontFamily,
              fontWeight: FontWeightManager.bold,
            ),
          ),
        ],
      ),
    );
  }
}
