import 'package:flutter/material.dart';

import 'package:sahl_edu/config/navigation/navigation.dart';
import '../../../../core/resources/resources.dart';
import '../../../../core/view/views.dart';
import '../../models/exam_model.dart';

class ExamItem extends StatelessWidget {
  final Exam exam;

  const ExamItem(this.exam, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => NavigationService.push(context, Routes.questionsScreen, arguments: {"exam": exam}),
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    "By : ${exam.admin.name}",
                    color: AppColors.white,
                    autoSized: true,
                    fontSize: FontSize.s12,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  CustomText(
                    exam.name,
                    color: AppColors.white,
                    autoSized: true,
                    fontWeight: FontWeightManager.bold,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
