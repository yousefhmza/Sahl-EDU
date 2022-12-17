import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_edu/core/view/views.dart';
import 'package:sahl_edu/modules/student/cubits/questions_cubit/questions_cubit.dart';

class ResultsScreen extends StatelessWidget {
  final int totalDegree;

  const ResultsScreen({required this.totalDegree, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatusBar(
      child: Scaffold(
        body: Center(
          child: CustomText("${BlocProvider.of<QuestionsCubit>(context).degree}/${totalDegree}"),
        ),
      ),
    );
  }
}
