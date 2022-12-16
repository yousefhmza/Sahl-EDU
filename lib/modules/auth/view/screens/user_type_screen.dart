import 'package:flutter/material.dart';
import 'package:sahl_edu/core/resources/resources.dart';
import 'package:sahl_edu/core/view/views.dart';
import 'package:sahl_edu/modules/auth/view/widgets/user_card.dart';

class UserTypeScreen extends StatelessWidget {
  const UserTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatusBar(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Column(
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
                        UserCard(isChosen: true, text: AppStrings.teacher, onTap: () {}, img: AppImages.teacher),
                        UserCard(isChosen: false, text: AppStrings.student, onTap: () {}, img: AppImages.student),
                      ],
                    ),
                  ),
                ),
                CustomButton(
                  text: AppStrings.next,
                  width: double.infinity,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
