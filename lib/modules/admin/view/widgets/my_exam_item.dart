import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_edu/config/navigation/navigation.dart';

import 'package:sahl_edu/core/utils/alerts.dart';
import 'package:sahl_edu/modules/admin/cubits/admin_home_cubit/admin_home_cubit.dart';
import '../../../../core/models/exam_model.dart';
import '../../../../core/resources/resources.dart';
import '../../../../core/view/views.dart';

class MyExamItem extends StatelessWidget {
  final Exam exam;

  const MyExamItem(this.exam, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => NavigationService.push(context, Routes.scoresScreen, arguments: {"exam_id": exam.id}),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: AppSize.s0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s16)),
        child: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            CustomNetworkImage(image: exam.image, height: double.infinity, width: double.infinity),
            FractionallySizedBox(
              heightFactor: 0.5,
              widthFactor: 1,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.black.withOpacity(0.9), AppColors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: CustomText(
                exam.name,
                color: AppColors.white,
                autoSized: true,
                fontWeight: FontWeightManager.bold,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            PositionedDirectional(
              top: AppSize.s0,
              start: AppSize.s0,
              child: Container(
                padding: const EdgeInsets.all(AppPadding.p8),
                margin: const EdgeInsets.all(AppPadding.p8),
                decoration: BoxDecoration(color: AppColors.black.withOpacity(0.5), shape: BoxShape.circle),
                child: BlocConsumer<AdminHomeCubit, AdminHomeStates>(
                  listener: (context, state) {
                    if (state is DeleteExamFailureState) Alerts.showSnackBar(context, state.failure.message);
                    if (state is DeleteExamSuccessState) Alerts.showToast(state.message);
                  },
                  buildWhen: (prevState, state) =>
                      (state is DeleteExamSuccessState && state.examId == exam.id) ||
                      (state is DeleteExamFailureState && state.examId == exam.id) ||
                      (state is DeleteExamLoadingState && state.examId == exam.id),
                  builder: (context, state) => state is DeleteExamLoadingState
                      ? const LoadingSpinner(color: AppColors.red)
                      : InkWell(
                          onTap: () => Alerts.showAppDialog(
                            context,
                            title: AppStrings.sureDeletingExam,
                            onConfirm: () => BlocProvider.of<AdminHomeCubit>(context).deleteExam(exam.id),
                            confirmText: AppStrings.delete,
                          ),
                          child: const CustomIcon(Icons.delete, color: AppColors.red),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
