part of 'admin_home_cubit.dart';

abstract class AdminHomeStates {}

class AdminHomeInitialState extends AdminHomeStates {}

class GetMyExamsLoadingState extends AdminHomeStates {}

class GetMyExamsSuccessState extends AdminHomeStates {
  List<Exam> exams;

  GetMyExamsSuccessState(this.exams);
}

class GetMyExamsFailureState extends AdminHomeStates {
  final Failure failure;

  GetMyExamsFailureState(this.failure);
}

class DeleteExamLoadingState extends AdminHomeStates {
  final String examId;

  DeleteExamLoadingState(this.examId);
}

class DeleteExamSuccessState extends AdminHomeStates {
  String message;
  final String examId;

  DeleteExamSuccessState(this.message, this.examId);
}

class DeleteExamFailureState extends AdminHomeStates {
  final Failure failure;
  final String examId;

  DeleteExamFailureState(this.failure, this.examId);
}

class GetScoresLoadingState extends AdminHomeStates {}

class GetScoresSuccessState extends AdminHomeStates {
  List<ScoreModel> scores;

  GetScoresSuccessState(this.scores);
}

class GetScoresFailureState extends AdminHomeStates {
  final Failure failure;

  GetScoresFailureState(this.failure);
}
