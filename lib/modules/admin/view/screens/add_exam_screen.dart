import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_edu/core/extensions/non_null_extensions.dart';

import 'package:sahl_edu/modules/admin/cubits/add_exam_cubit/add_exam_cubit.dart';
import 'package:sahl_edu/modules/admin/view/components/add_exam_step_one.dart';
import 'package:sahl_edu/modules/admin/view/components/add_exam_step_two.dart';
import '../../../../config/navigation/navigation.dart';
import '../../../../core/resources/resources.dart';
import '../../../../core/utils/alerts.dart';
import '../../../../core/view/views.dart';

class AddExamScreen extends StatelessWidget {
  const AddExamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddExamCubit addExamCubit = BlocProvider.of<AddExamCubit>(context);
    addExamCubit.resetValues();
    return WillPopScope(
      onWillPop: () async {
        bool goBack = false;
        switch (addExamCubit.currentStep) {
          case 0:
            final bool? pop = await Alerts.showAppDialog(
              context,
              title: AppStrings.surePoppingExamScreen,
              onConfirm: () => NavigationService.goBack(context, true),
              confirmText: AppStrings.goBack,
            );
            goBack = pop.orFalse;
            break;
          case 1:
            addExamCubit.setCurrentStep(0);
            goBack = false;
            break;
        }
        return goBack;
      },
      child: StatusBar(
        child: Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    BackButton(color: AppColors.black),
                    CustomText(AppStrings.addExam, fontSize: FontSize.s16, fontWeight: FontWeightManager.bold),
                  ],
                ),
                Expanded(
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: Theme.of(context).colorScheme.copyWith(
                            primary: AppColors.primary,
                            onSurface: AppColors.primary,
                          ),
                    ),
                    child: BlocSelector<AddExamCubit, AddExamStates, int>(
                      selector: (addExamStates) => addExamCubit.currentStep,
                      builder: (context, currentStep) => Stepper(
                        elevation: AppSize.s0,
                        type: StepperType.horizontal,
                        currentStep: currentStep,
                        onStepTapped: (step) {
                          if (currentStep > step) addExamCubit.setCurrentStep(step);
                        },
                        controlsBuilder: (context, _) => Container(),
                        steps: [
                          Step(
                            title: const CustomText(
                              AppStrings.exam,
                              fontSize: FontSize.s12,
                              fontWeight: FontWeightManager.bold,
                            ),
                            content: AddExamStepOne(),
                            isActive: currentStep == 0,
                            state: currentStep > 0 ? StepState.complete : StepState.indexed,
                          ),
                          Step(
                            title: const CustomText(
                              AppStrings.questions,
                              fontSize: FontSize.s12,
                              fontWeight: FontWeightManager.bold,
                            ),
                            content: const AddExamStepTwo(),
                            isActive: currentStep == 1,
                            state: currentStep > 1 ? StepState.complete : StepState.indexed,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
