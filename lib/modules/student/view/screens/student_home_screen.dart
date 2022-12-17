import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahl_edu/core/resources/resources.dart';
import 'package:sahl_edu/core/view/views.dart';
import '../../cubits/student_home_cubit/student_home_cubit.dart';
import '../widgets/exam_item.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({Key? key}) : super(key: key);

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  late final StudentHomeCubit studentHomeCubit;

  @override
  void initState() {
    studentHomeCubit = BlocProvider.of<StudentHomeCubit>(context);
    studentHomeCubit.getExams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        centerTitle: true,
        title: CustomText(AppStrings.exams, fontWeight: FontWeightManager.bold, fontSize: FontSize.s16),
      ),
      drawer: const HomeDrawer(),
      body: BlocBuilder<StudentHomeCubit, StudentHomeStates>(
        buildWhen: (prevState, state) =>
            state is GetExamsLoadingState || state is GetExamsSuccessState || state is GetExamsFailureState,
        builder: (context, state) {
          if (state is GetExamsSuccessState) {
            return GridView.builder(
              padding: const EdgeInsets.all(AppPadding.p8),
              itemCount: state.exams.length,
              itemBuilder: (context, index) => ExamItem(state.exams[index]),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: deviceWidth / 2,
                mainAxisSpacing: AppSize.s8,
                crossAxisSpacing: AppSize.s8,
                childAspectRatio: 0.8,
              ),
            );
          }
          if (state is GetExamsFailureState) {
            return ErrorComponent(message: state.failure.message, onRetry: () => studentHomeCubit.getExams());
          }
          return const LoadingSpinner();
        },
      ),
    );
  }
}
