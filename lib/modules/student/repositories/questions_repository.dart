import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:sahl_edu/core/resources/app_strings.dart';

import 'package:sahl_edu/core/services/network/network_info.dart';
import 'package:sahl_edu/core/utils/globals.dart';
import 'package:sahl_edu/modules/student/models/question_model.dart';
import '../../../core/services/error/error_handler.dart';
import '../../../core/services/error/failure.dart';
import '../../../core/utils/constants.dart';

class QuestionsRepository {
  final NetworkInfo _networkInfo;

  QuestionsRepository(this._networkInfo);

  Future<Either<Failure, List<Question>>> getQuestions(String examId) async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      try {
        final questions = await FirebaseFirestore.instance
            .collection(Constants.exams)
            .doc(examId)
            .collection(Constants.questions)
            .get();
        return Right(List<Question>.from(questions.docs.map((question) => Question.fromJson(question.data()))));
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }

  Future<Either<Failure, String>> saveScore({
    required String examId,
    required int score,
    required int totalDegree,
  }) async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      try {
        await FirebaseFirestore.instance
            .collection(Constants.exams)
            .doc(examId)
            .collection(Constants.scores)
            .doc(currentUser!.id)
            .set({"score": score, "total_degree": totalDegree, "student": currentUser!.toJson()});
        return const Right(AppStrings.scoreSaved);
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }
}
