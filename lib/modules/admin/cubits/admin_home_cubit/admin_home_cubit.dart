import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/exam_model.dart';
import '../../../../core/services/error/failure.dart';
import '../../repositories/admin_home_repository.dart';

part 'admin_home_state.dart';

class AdminHomeCubit extends Cubit<AdminHomeStates> {
  final AdminHomeRepository _adminHomeRepository;

  AdminHomeCubit(this._adminHomeRepository) : super(AdminHomeInitialState());

  Future<void> getMyExams() async {
    emit(GetMyExamsLoadingState());
    final result = await _adminHomeRepository.getMyExams();
    result.fold(
      (failure) => emit(GetMyExamsFailureState(failure)),
      (exams) => emit(GetMyExamsSuccessState(exams)),
    );
  }

  Future<void> deleteExam(String id) async {
    emit(DeleteExamLoadingState(id));
    final result = await _adminHomeRepository.deleteExam(id);
    result.fold(
      (failure) => emit(DeleteExamFailureState(failure, id)),
      (message) {
        getMyExams();
        emit(DeleteExamSuccessState(message, id));
      },
    );
  }
}
