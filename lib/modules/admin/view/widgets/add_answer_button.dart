import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_edu/core/resources/resources.dart';
import 'package:sahl_edu/core/utils/alerts.dart';
import 'package:sahl_edu/core/view/views.dart';
import 'package:sahl_edu/modules/admin/cubits/add_exam_cubit/add_exam_cubit.dart';
import 'package:sahl_edu/modules/admin/models/request/question_body.dart';

class AddAnswerButton extends StatelessWidget {
  final int questionIndex;
  final QuestionBody questionBody;

  const AddAnswerButton({required this.questionIndex, required this.questionBody, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppSize.s8),
      onTap: () {
        if (questionBody.answers[questionBody.answers.length - 1].isEmpty) {
          Alerts.showToast(AppStrings.pleaseAddAnswer);
          return;
        }
        BlocProvider.of<AddExamCubit>(context).addAnswer(questionIndex);
      },
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
            CustomText(AppStrings.addAnswer, color: AppColors.grey),
          ],
        ),
      ),
    );
  }
}
