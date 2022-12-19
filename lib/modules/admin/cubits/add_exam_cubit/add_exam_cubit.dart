import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_edu/modules/admin/models/request/add_exam_body.dart';
import 'package:sahl_edu/modules/admin/models/request/question_body.dart';

import '../../../../core/services/error/failure.dart';
import '../../repositories/add_exam_repository.dart';

part 'add_exam_state.dart';

class AddExamCubit extends Cubit<AddExamStates> {
  final AddExamRepository _addExamRepository;

  AddExamCubit(this._addExamRepository) : super(AddExamInitialState());

  int currentStep = 0;
  AddExamBody addExamBody = AddExamBody(questions: []);

  void setCurrentStep(int index) {
    currentStep = index;
    emit(SetCurrentStepState());
  }

  void pickImage(File image) {
    addExamBody.copyWith(image: image);
    emit(SetValuesState());
  }

  void addQuestion() {
    addExamBody.questions.add(QuestionBody(answers: [""]));
    emit(SetValuesState());
  }

  void addAnswer(int questionIndex) {
    addExamBody.questions[questionIndex].answers.add("");
    emit(SetValuesState());
  }

  void resetValues() {
    addExamBody = AddExamBody(questions: []);
    currentStep = 0;
  }

  Future<void> addExam() async {
    emit(AddExamLoadingState());
    final result = await _addExamRepository.addExam(addExamBody);
    result.fold(
      (failure) => emit(AddExamFailureState(failure)),
      (message) => emit(AddExamSuccessState(message)),
    );
  }
}
