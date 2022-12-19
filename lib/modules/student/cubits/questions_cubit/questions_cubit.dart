import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_edu/core/resources/resources.dart';
import 'package:sahl_edu/core/services/error/failure.dart';

import '../../models/question_model.dart';
import '../../repositories/questions_repository.dart';

part 'questions_state.dart';

class QuestionsCubit extends Cubit<QuestionsStates> {
  final QuestionsRepository _questionsRepository;

  QuestionsCubit(this._questionsRepository) : super(QuestionsInitialState());

  List<Question> questions = [];
  late PageController pageController;
  int? currentQuestionIndex;
  int? selectedAnswerIndex;
  bool isCurrentQuestionAnswered = false;
  int degree = 0;

  void selectAnswer(int index) {
    selectedAnswerIndex = index;
    emit(SetQuestionState());
  }

  void answer(int correctAnswerIndex) {
    isCurrentQuestionAnswered = true;
    if (correctAnswerIndex == selectedAnswerIndex) {
      degree++;
    }
    emit(SetQuestionState());
  }

  void setQuestionIndex(int index) {
    currentQuestionIndex = index;
    emit(SetQuestionState());
  }

  void toNextQuestion() {
    selectedAnswerIndex = null;
    isCurrentQuestionAnswered = false;
    pageController.nextPage(duration: Time.t300, curve: Curves.easeInOut);
  }

  Future<void> getQuestions(String examId) async {
    emit(GetQuestionsLoadingState());
    final result = await _questionsRepository.getQuestions(examId);
    result.fold(
      (failure) => emit(GetQuestionsFailureState(failure)),
      (questions) {
        this.questions = questions;
        emit(GetQuestionsSuccessState(questions));
      },
    );
  }

  Future<void> saveScore(String examId, int totalDegree) async {
    emit(SaveScoreLoadingState());
    final result = await _questionsRepository.saveScore(examId: examId, score: degree, totalDegree: totalDegree);
    result.fold(
      (failure) => emit(SaveScoreFailureState(failure)),
      (message) => emit(SaveScoreSuccessState(message)),
    );
  }

  void resetValues() {
    questions.clear();
    pageController = PageController();
    currentQuestionIndex = 0;
    selectedAnswerIndex = null;
    degree = 0;
    isCurrentQuestionAnswered = false;
  }
}
