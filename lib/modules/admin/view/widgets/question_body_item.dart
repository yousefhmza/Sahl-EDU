import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_edu/core/utils/alerts.dart';
import 'package:sahl_edu/modules/admin/cubits/add_exam_cubit/add_exam_cubit.dart';
import 'package:sahl_edu/modules/admin/models/request/question_body.dart';
import 'package:sahl_edu/modules/admin/view/widgets/add_answer_button.dart';

import '../../../../core/resources/resources.dart';
import '../../../../core/view/views.dart';

class QuestionBodyItem extends StatelessWidget {
  final QuestionBody questionBody;
  final int index;

  const QuestionBodyItem({required this.questionBody, required this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s16),
        border: Border.all(color: AppColors.grey),
      ),
      child: Column(
        children: [
          CustomTextField(
            hintText: AppStrings.typeQuestion,
            initialValue: questionBody.question,
            minLines: 1,
            maxLines: 10,
            fillColor: AppColors.white,
            onChanged: (value) => questionBody.copyWith(question: value),
          ),
          const Divider(),
          const CustomText(AppStrings.answers),
          const VerticalSpace(AppSize.s8),
          BlocBuilder<AddExamCubit, AddExamStates>(
            builder: (context, state) {
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, i) => i == questionBody.answers.length
                    ? AddAnswerButton(questionIndex: index, questionBody: questionBody)
                    : Row(
                        children: [
                          CustomText("${i + 1}."),
                          const HorizontalSpace(AppSize.s4),
                          Expanded(
                            child: CustomTextField(
                              key: ValueKey(i),
                              onChanged: (value) => questionBody.answers[i] = value,
                              suffix: InkWell(
                                onTap: () {
                                  if (questionBody.answers.length < 3) {
                                    Alerts.showToast(AppStrings.cantDeleteAnswer);
                                    return;
                                  }
                                  BlocProvider.of<AddExamCubit>(context).removeAnswer(index, i);
                                },
                                child: const CustomIcon(Icons.delete),
                              ),
                            ),
                          ),
                        ],
                      ),
                separatorBuilder: (context, index) => const VerticalSpace(AppSize.s8),
                itemCount:
                    questionBody.answers.length == 5 ? questionBody.answers.length : questionBody.answers.length + 1,
              );
            },
          ),
          const Divider(),
          Row(
            children: [
              const CustomText(AppStrings.correctAnswerNumber),
              Expanded(
                child: CustomTextField(
                  initialValue: questionBody.correctAnswerIndex?.toString() ?? "",
                  keyBoardType: TextInputType.number,
                  formatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(1)],
                  onChanged: (value) => questionBody.copyWith(
                    correctAnswerIndex: int.tryParse(value) != null ? int.parse(value) - 1 : null,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
