import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahl_edu/core/resources/resources.dart';
import 'package:sahl_edu/core/utils/alerts.dart';
import 'package:sahl_edu/core/view/views.dart';

import '../../../../core/utils/pickers.dart';
import '../../cubits/add_exam_cubit/add_exam_cubit.dart';

class AddExamStepOne extends StatelessWidget {
  AddExamStepOne({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AddExamCubit addExamCubit = BlocProvider.of<AddExamCubit>(context);
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(AppStrings.enterExamName, fontWeight: FontWeightManager.bold),
            const VerticalSpace(AppSize.s8),
            CustomTextField(
              hintText: AppStrings.examName,
              initialValue: addExamCubit.addExamBody.name,
              onSaved: (value) => addExamCubit.addExamBody.copyWith(name: value),
              prefix: const CustomIcon(Icons.document_scanner),
            ),
            const VerticalSpace(AppSize.s24),
            const CustomText(AppStrings.uploadExamImage, fontWeight: FontWeightManager.bold),
            const VerticalSpace(AppSize.s8),
            InkWell(
              borderRadius: BorderRadius.circular(AppSize.s16),
              onTap: () => Alerts.showBottomSheet(
                context,
                child: PickImageSheetComponent(
                  onGallery: () async {
                    final File? image = await Pickers.pickImage(ImageSource.gallery);
                    if (image != null) addExamCubit.pickImage(image);
                  },
                  onCamera: () async {
                    final File? image = await Pickers.pickImage(ImageSource.camera);
                    if (image != null) addExamCubit.pickImage(image);
                  },
                ),
              ),
              child: BlocBuilder<AddExamCubit, AddExamStates>(
                builder: (context, state) => addExamCubit.addExamBody.image == null
                    ? Container(
                        width: deviceWidth * 0.6,
                        height: deviceWidth * 0.6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s16),
                          border: Border.all(color: AppColors.grey),
                        ),
                        child: const Center(
                          child: CustomIcon(Icons.image, size: AppSize.s100),
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(AppSize.s16),
                        child: Image.file(
                          addExamCubit.addExamBody.image!,
                          width: deviceWidth * 0.6,
                          height: deviceWidth * 0.6,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
            const VerticalSpace(AppSize.s32),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: CustomButton(
                text: AppStrings.next,
                color: AppColors.primary,
                width: deviceWidth * 0.3,
                onPressed: () {
                  formKey.currentState!.save();
                  if (addExamCubit.addExamBody.name.isEmpty || addExamCubit.addExamBody.image == null) {
                    Alerts.showToast(AppStrings.stepOneValidator);
                    return;
                  }
                  addExamCubit.setCurrentStep(1);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
