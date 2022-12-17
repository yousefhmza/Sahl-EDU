import 'package:flutter/material.dart';
import 'package:sahl_edu/config/navigation/navigation.dart';
import 'package:sahl_edu/core/enums/user_type.dart';
import 'package:sahl_edu/core/resources/resources.dart';
import 'package:sahl_edu/core/view/views.dart';
import 'package:sahl_edu/modules/auth/view/widgets/user_card.dart';

// ignore: must_be_immutable
class UserTypeScreen extends StatelessWidget {
  UserTypeScreen({Key? key}) : super(key: key);

  UserType? userType;

  @override
  Widget build(BuildContext context) {
    return StatusBar(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: StatefulBuilder(
              builder: (context, setState) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    AppStrings.continueAs,
                    fontWeight: FontWeightManager.bold,
                    fontSize: FontSize.s20,
                    textAlign: TextAlign.start,
                  ),
                  Expanded(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          UserCard(
                            isChosen: userType == UserType.admin,
                            text: AppStrings.admin,
                            onTap: () => setState(() => userType = UserType.admin),
                            img: AppImages.admin,
                          ),
                          UserCard(
                            isChosen: userType == UserType.student,
                            text: AppStrings.student,
                            onTap: () => setState(() => userType = UserType.student),
                            img: AppImages.student,
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomButton(
                    text: AppStrings.next,
                    width: double.infinity,
                    onPressed: userType == null
                        ? null
                        : () => NavigationService.push(
                              context,
                              Routes.loginScreen,
                              arguments: {"user_type": userType},
                            ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
