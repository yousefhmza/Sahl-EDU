part of 'questions_cubit.dart';

abstract class QuestionsStates {}

class QuestionsInitialState extends QuestionsStates {}

class SetQuestionState extends QuestionsStates {}

class GetQuestionsLoadingState extends QuestionsStates {}

class GetQuestionsFailureState extends QuestionsStates {
  final Failure failure;

  GetQuestionsFailureState(this.failure);
}

class GetQuestionsSuccessState extends QuestionsStates {
  final List<Question> questions;

  GetQuestionsSuccessState(this.questions);
}

class SaveScoreLoadingState extends QuestionsStates {}

class SaveScoreFailureState extends QuestionsStates {
  final Failure failure;

  SaveScoreFailureState(this.failure);
}

class SaveScoreSuccessState extends QuestionsStates {}
