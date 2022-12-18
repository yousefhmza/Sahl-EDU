import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_edu/config/navigation/navigation.dart';
import 'package:sahl_edu/modules/admin/cubits/admin_home_cubit/admin_home_cubit.dart';
import 'package:sahl_edu/modules/admin/view/widgets/my_exam_item.dart';

import '../../../../core/resources/resources.dart';
import '../../../../core/view/views.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  late final AdminHomeCubit adminHomeCubit;

  @override
  void initState() {
    adminHomeCubit = BlocProvider.of<AdminHomeCubit>(context);
    adminHomeCubit.getMyExams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        centerTitle: true,
        title: CustomText(AppStrings.myExams, fontWeight: FontWeightManager.bold, fontSize: FontSize.s16),
      ),
      drawer: const HomeDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => NavigationService.push(context, Routes.addExamScreen),
        backgroundColor: AppColors.black,
        isExtended: true,
        label: Row(
          children: const [
            CustomIcon(Icons.add_circle_outline, color: AppColors.white),
            HorizontalSpace(AppSize.s4),
            CustomText(AppStrings.addExam, color: AppColors.white),
          ],
        ),
      ),
      body: BlocBuilder<AdminHomeCubit, AdminHomeStates>(
        buildWhen: (prevState, state) =>
            state is GetMyExamsLoadingState || state is GetMyExamsSuccessState || state is GetMyExamsFailureState,
        builder: (context, state) {
          if (state is GetMyExamsSuccessState) {
            return GridView.builder(
              padding: const EdgeInsets.all(AppPadding.p8),
              itemCount: state.exams.length,
              itemBuilder: (context, index) => MyExamItem(state.exams[index]),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: deviceWidth / 2,
                mainAxisSpacing: AppSize.s8,
                crossAxisSpacing: AppSize.s8,
                childAspectRatio: 0.8,
              ),
            );
          }
          if (state is GetMyExamsFailureState) {
            return ErrorComponent(message: state.failure.message, onRetry: () => adminHomeCubit.getMyExams());
          }
          return const LoadingSpinner();
        },
      ),
    );
  }
}
