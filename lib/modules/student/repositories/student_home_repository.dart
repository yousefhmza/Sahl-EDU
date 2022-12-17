import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:sahl_edu/core/services/error/error_handler.dart';
import 'package:sahl_edu/core/services/error/failure.dart';
import 'package:sahl_edu/core/utils/constants.dart';

import '../../../core/services/network/network_info.dart';
import '../../../core/models/exam_model.dart';

class StudentHomeRepository {
  final NetworkInfo _networkInfo;

  StudentHomeRepository(this._networkInfo);

  Future<Either<Failure, List<Exam>>> getExams() async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      try {
        final exams = await FirebaseFirestore.instance.collection(Constants.exams).get();
        return Right(List<Exam>.from(exams.docs.map((exam) => Exam.fromJson(exam.data()))));
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }
}
