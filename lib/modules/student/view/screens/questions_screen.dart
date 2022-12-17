import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_edu/modules/student/cubits/questions_cubit/questions_cubit.dart';
import 'package:sahl_edu/modules/student/models/exam_model.dart';
import 'package:sahl_edu/modules/student/view/widgets/question_item.dart';

import '../../../../config/navigation/navigation_services.dart';
import '../../../../core/resources/resources.dart';
import '../../../../core/utils/alerts.dart';
import '../../../../core/view/views.dart';

class QuestionsScreen extends StatefulWidget {
  final Exam exam;

  const QuestionsScreen({required this.exam, Key? key}) : super(key: key);

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  late final QuestionsCubit questionsCubit;

  @override
  void initState() {
    questionsCubit = BlocProvider.of<QuestionsCubit>(context);
    questionsCubit.getQuestions(widget.exam.id);
    questionsCubit.resetValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final bool? pop = await Alerts.showAppDialog(
          context,
          title: AppStrings.sureQuittingExam,
          onConfirm: () => NavigationService.goBack(context, true),
          confirmText: AppStrings.confirm,
        );
        return pop ?? false;
      },
      child: Scaffold(
        appBar: CustomAppbar(
          centerTitle: true,
          title: CustomText(widget.exam.name, fontWeight: FontWeightManager.bold, fontSize: FontSize.s16),
          actions: [
            BlocBuilder<QuestionsCubit, QuestionsStates>(
              builder: (context, state) => Center(
                child: Container(
                  margin: const EdgeInsetsDirectional.only(end: AppPadding.p16),
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                  decoration: const ShapeDecoration(color: AppColors.black, shape: StadiumBorder()),
                  child: CustomText(
                    "${questionsCubit.currentQuestionIndex! + 1}/${questionsCubit.questions.length}",
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: BlocBuilder<QuestionsCubit, QuestionsStates>(
          buildWhen: (prevState, state) =>
              state is GetQuestionsLoadingState ||
              state is GetQuestionsFailureState ||
              state is GetQuestionsSuccessState,
          builder: (context, state) {
            if (state is GetQuestionsSuccessState) {
              state.questions.shuffle();
              return PageView.builder(
                itemCount: state.questions.length,
                controller: questionsCubit.pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: questionsCubit.setQuestionIndex,
                itemBuilder: (context, index) => QuestionItem(state.questions[index], state.questions.length - 1),
              );
            }
            if (state is GetQuestionsFailureState) {
              return ErrorComponent(
                message: state.failure.message,
                onRetry: () => questionsCubit.getQuestions(widget.exam.id),
              );
            }
            return const LoadingSpinner();
          },
        ),
      ),
    );
  }
}
