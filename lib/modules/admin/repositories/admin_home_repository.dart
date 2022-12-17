import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:sahl_edu/core/resources/resources.dart';

import 'package:sahl_edu/core/services/network/network_info.dart';
import 'package:sahl_edu/core/utils/globals.dart';
import '../../../core/models/exam_model.dart';
import '../../../core/services/error/error_handler.dart';
import '../../../core/services/error/failure.dart';
import '../../../core/utils/constants.dart';

class AdminHomeRepository {
  final NetworkInfo _networkInfo;

  AdminHomeRepository(this._networkInfo);

  Future<Either<Failure, List<Exam>>> getMyExams() async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      try {
        final exams = await FirebaseFirestore.instance
            .collection(Constants.exams)
            .where("admin.id", isEqualTo: currentUser!.id)
            .get();
        return Right(List<Exam>.from(exams.docs.map((exam) => Exam.fromJson(exam.data()))));
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }

  Future<Either<Failure, String>> deleteExam(String id) async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      try {
        await FirebaseFirestore.instance.collection(Constants.exams).doc(id).delete();
        return const Right(AppStrings.examDeletedSuccessfully);
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }
}
