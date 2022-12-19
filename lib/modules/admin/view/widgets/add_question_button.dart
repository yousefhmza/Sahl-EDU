import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_edu/core/resources/resources.dart';
import 'package:sahl_edu/core/utils/alerts.dart';
import 'package:sahl_edu/core/view/views.dart';
import 'package:sahl_edu/modules/admin/cubits/add_exam_cubit/add_exam_cubit.dart';
import 'package:sahl_edu/modules/admin/models/request/question_body.dart';

class AddQuestionButton extends StatelessWidget {
  final QuestionBody? lastQuestion;

  const AddQuestionButton({required this.lastQuestion, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppSize.s8),
      onTap: lastQuestion != null
          ? () {
              if (lastQuestion!.question.isEmpty) {
                Alerts.showToast(AppStrings.pleaseAddQuestion);
                return;
              } else if (lastQuestion!.answers.length < 2) {
                Alerts.showToast(AppStrings.pleaseAddAnswers);
                return;
              } else if (lastQuestion!.correctAnswerIndex == null ||
                  lastQuestion!.correctAnswerIndex! > lastQuestion!.answers.length - 1) {
                Alerts.showToast(AppStrings.pleaseChooseCorrectAnswer);
                return;
              }
              BlocProvider.of<AddExamCubit>(context).addQuestion();
            }
          : () => BlocProvider.of<AddExamCubit>(context).addQuestion(),
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s8),
          border: Border.all(color: AppColors.grey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CustomIcon(Icons.add_circle_outline, color: AppColors.grey),
            HorizontalSpace(AppSize.s4),
            CustomText(AppStrings.addQuestion, color: AppColors.grey),
          ],
        ),
      ),
    );
  }
}
