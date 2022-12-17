import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_edu/core/services/error/failure.dart';

import '../../../../core/models/exam_model.dart';
import '../../repositories/student_home_repository.dart';

part 'student_home_states.dart';

class StudentHomeCubit extends Cubit<StudentHomeStates> {
  final StudentHomeRepository _studentHomeRepository;

  StudentHomeCubit(this._studentHomeRepository) : super(StudentHomeInitialState());

  Future<void> getExams() async {
    emit(GetExamsLoadingState());
    final result = await _studentHomeRepository.getExams();
    result.fold(
      (failure) => emit(GetExamsFailureState(failure)),
      (exams) => emit(GetExamsSuccessState(exams)),
    );
  }
}
