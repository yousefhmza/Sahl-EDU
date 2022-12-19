import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_edu/config/navigation/navigation.dart';

import 'package:sahl_edu/core/resources/resources.dart';
import 'package:sahl_edu/core/view/views.dart';
import 'package:sahl_edu/modules/student/cubits/questions_cubit/questions_cubit.dart';
import 'package:sahl_edu/modules/student/models/question_model.dart';

class QuestionItem extends StatelessWidget {
  final Question question;
  final int lastIndex;
  final String examId;

  const QuestionItem(this.question, this.lastIndex, this.examId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final QuestionsCubit questionsCubit = BlocProvider.of<QuestionsCubit>(context);
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Column(
        children: [
          CustomText(
            question.question,
            fontWeight: FontWeightManager.semiBold,
            fontSize: FontSize.s16,
            textAlign: TextAlign.center,
          ),
          const VerticalSpace(AppSize.s16),
          Expanded(
            child: BlocBuilder<QuestionsCubit, QuestionsStates>(
              builder: (context, state) => SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    question.answers.length,
                    (index) => RadioListTile<int>(
                      value: index,
                      activeColor: AppColors.primary,
                      title: CustomText(question.answers[index]),
                      groupValue: questionsCubit.selectedAnswerIndex,
                      onChanged: questionsCubit.isCurrentQuestionAnswered
                          ? null
                          : (value) => questionsCubit.selectAnswer(value!),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const VerticalSpace(AppSize.s16),
          BlocBuilder<QuestionsCubit, QuestionsStates>(
            builder: (context, state) {
              if (questionsCubit.isCurrentQuestionAnswered &&
                  questionsCubit.selectedAnswerIndex == question.correctAnswerIndex) {
                return Row(
                  children: const [
                    CustomIcon(Icons.check_circle_outline, color: AppColors.green),
                    HorizontalSpace(AppSize.s8),
                    CustomText(AppStrings.correctAnswer, color: AppColors.green),
                  ],
                );
              } else if (questionsCubit.isCurrentQuestionAnswered &&
                  questionsCubit.selectedAnswerIndex != question.correctAnswerIndex) {
                return Row(
                  children: const [
                    CustomIcon(Icons.info_outline, color: AppColors.red),
                    HorizontalSpace(AppSize.s8),
                    CustomText(AppStrings.wrongAnswer, color: AppColors.red),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          const VerticalSpace(AppSize.s16),
          BlocBuilder<QuestionsCubit, QuestionsStates>(
            builder: (context, state) =>
                questionsCubit.isCurrentQuestionAnswered && questionsCubit.currentQuestionIndex == lastIndex
                    ? CustomButton(
                        text: AppStrings.seeResults,
                        color: AppColors.primary,
                        width: double.infinity,
                        onPressed: () => NavigationService.pushReplacement(
                          context,
                          Routes.resultsScreen,
                          arguments: {"total_degree": lastIndex + 1, "exam_id": examId},
                        ),
                      )
                    : Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: CustomButton(
                              text: AppStrings.answer,
                              color: AppColors.primary,
                              onPressed:
                                  questionsCubit.selectedAnswerIndex == null || questionsCubit.isCurrentQuestionAnswered
                                      ? null
                                      : () => questionsCubit.answer(question.correctAnswerIndex),
                            ),
                          ),
                          const HorizontalSpace(AppSize.s8),
                          Expanded(
                            flex: 1,
                            child: CustomButton(
                              onPressed: !questionsCubit.isCurrentQuestionAnswered
                                  ? null
                                  : () => questionsCubit.toNextQuestion(),
                              child: const CustomIcon(Icons.arrow_forward, color: AppColors.white),
                            ),
                          ),
                        ],
                      ),
          ),
        ],
      ),
    );
  }
}
