import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_edu/config/navigation/navigation.dart';
import 'package:sahl_edu/core/extensions/num_extensions.dart';

import 'package:sahl_edu/core/resources/resources.dart';
import 'package:sahl_edu/core/utils/alerts.dart';
import 'package:sahl_edu/core/view/views.dart';
import 'package:sahl_edu/modules/admin/cubits/admin_home_cubit/admin_home_cubit.dart';
import 'package:sahl_edu/modules/admin/view/widgets/add_question_button.dart';
import 'package:sahl_edu/modules/admin/view/widgets/question_body_item.dart';
import '../../cubits/add_exam_cubit/add_exam_cubit.dart';

class AddExamStepTwo extends StatelessWidget {
  const AddExamStepTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddExamCubit addExamCubit = BlocProvider.of<AddExamCubit>(context);
    return SizedBox(
      height: deviceHeight - AppSize.s175.h,
      child: Column(
        children: [
          BlocBuilder<AddExamCubit, AddExamStates>(
            builder: (context, state) {
              return Expanded(
                child: ListView.separated(
                  itemCount: addExamCubit.addExamBody.questions.length + 1,
                  itemBuilder: (context, index) => index == addExamCubit.addExamBody.questions.length
                      ? AddQuestionButton(
                          lastQuestion: index == 0 ? null : addExamCubit.addExamBody.questions[index - 1],
                        )
                      : QuestionBodyItem(
                          questionBody: addExamCubit.addExamBody.questions[index],
                          index: index,
                        ),
                  separatorBuilder: (context, index) => const VerticalSpace(AppSize.s8),
                ),
              );
            },
          ),
          const VerticalSpace(AppSize.s8),
          BlocConsumer<AddExamCubit, AddExamStates>(
            listener: (context, state) {
              if (state is AddExamFailureState) Alerts.showSnackBar(context, state.failure.message);
              if (state is AddExamSuccessState) {
                BlocProvider.of<AdminHomeCubit>(context).getMyExams();
                Alerts.showSnackBar(context, state.message);
                NavigationService.goBack(context);
              }
            },
            builder: (context, state) => state is AddExamLoadingState
                ? const LoadingSpinner()
                : CustomButton(
                    text: AppStrings.confirm,
                    color: AppColors.primary,
                    width: double.infinity,
                    onPressed: () {
                      if (addExamCubit.addExamBody.questions.isEmpty) {
                        Alerts.showToast(AppStrings.pleaseAddQuestions);
                        return;
                      }
                      addExamCubit.addExam();
                    },
                  ),
          )
        ],
      ),
    );
  }
}
