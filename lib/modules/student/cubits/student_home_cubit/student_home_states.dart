part of 'student_home_cubit.dart';

abstract class StudentHomeStates {}

class StudentHomeInitialState extends StudentHomeStates {}

class GetExamsLoadingState extends StudentHomeStates {}

class GetExamsSuccessState extends StudentHomeStates {
  List<Exam> exams;

  GetExamsSuccessState(this.exams);
}

class GetExamsFailureState extends StudentHomeStates {
  final Failure failure;

  GetExamsFailureState(this.failure);
}
