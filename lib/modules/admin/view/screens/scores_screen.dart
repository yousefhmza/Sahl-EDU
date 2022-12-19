import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/resources.dart';
import '../../../../core/view/views.dart';
import '../../cubits/admin_home_cubit/admin_home_cubit.dart';

class ScoresScreen extends StatefulWidget {
  final String examId;

  const ScoresScreen({required this.examId, Key? key}) : super(key: key);

  @override
  State<ScoresScreen> createState() => _ScoresScreenState();
}

class _ScoresScreenState extends State<ScoresScreen> {
  late final AdminHomeCubit adminHomeCubit;

  @override
  void initState() {
    adminHomeCubit = BlocProvider.of<AdminHomeCubit>(context);
    adminHomeCubit.getScores(widget.examId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        centerTitle: true,
        title: CustomText(AppStrings.scores, fontWeight: FontWeightManager.bold, fontSize: FontSize.s16),
      ),
      body: BlocBuilder<AdminHomeCubit, AdminHomeStates>(
        buildWhen: (prevState, state) =>
            state is GetScoresLoadingState || state is GetScoresSuccessState || state is GetScoresFailureState,
        builder: (context, state) {
          if (state is GetScoresSuccessState) {
            return ListView.separated(
              padding: const EdgeInsets.all(AppPadding.p16),
              itemBuilder: (context, index) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CustomText(state.scores[index].student.name, fontWeight: FontWeightManager.semiBold),
                trailing: CustomText("${state.scores[index].degree}/${state.scores[index].totalDegree}"),
              ),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: state.scores.length,
            );
          }
          if (state is GetScoresFailureState) {
            return ErrorComponent(message: state.failure.message, onRetry: () => adminHomeCubit.getMyExams());
          }
          return const LoadingSpinner();
        },
      ),
    );
  }
}
