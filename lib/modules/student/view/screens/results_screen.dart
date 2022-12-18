import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sahl_edu/config/navigation/navigation.dart';
import 'package:sahl_edu/core/view/views.dart';
import 'package:sahl_edu/modules/student/cubits/questions_cubit/questions_cubit.dart';

import '../../../../core/resources/resources.dart';

class ResultsScreen extends StatelessWidget {
  final int totalDegree;

  const ResultsScreen({required this.totalDegree, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatusBar(
      child: Scaffold(
        appBar: const CustomAppbar(
          centerTitle: true,
          title: CustomText(AppStrings.results, fontWeight: FontWeightManager.bold, fontSize: FontSize.s16),
        ),
        body: Column(
          children: [
            Lottie.asset(AppJson.result, width: deviceWidth * 0.8, repeat: false),
            const VerticalSpace(AppSize.s56),
            const CustomText(AppStrings.yourScore, fontSize: FontSize.s20),
            const VerticalSpace(AppSize.s8),
            CustomText(
              "${BlocProvider.of<QuestionsCubit>(context).degree}/$totalDegree",
              fontSize: FontSize.s24,
              fontWeight: FontWeightManager.semiBold,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(AppPadding.p16),
              child: CustomButton(
                width: double.infinity,
                onPressed: () => NavigationService.goBack(context),
                text: AppStrings.goHome,
              ),
            )
          ],
        ),
      ),
    );
  }
}
