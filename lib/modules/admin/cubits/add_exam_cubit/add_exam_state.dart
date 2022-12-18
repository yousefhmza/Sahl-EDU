part of 'add_exam_cubit.dart';

abstract class AddExamStates {}

class AddExamInitialState extends AddExamStates {}

class SetCurrentStepState extends AddExamStates {}

class SetValuesState extends AddExamStates {}

class AddExamLoadingState extends AddExamStates {}

class AddExamSuccessState extends AddExamStates {
  final String message;

  AddExamSuccessState(this.message);
}

class AddExamFailureState extends AddExamStates {
  final Failure failure;

  AddExamFailureState(this.failure);
}
