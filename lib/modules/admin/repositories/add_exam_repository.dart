import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sahl_edu/core/services/network/network_info.dart';
import 'package:sahl_edu/modules/admin/models/request/add_exam_body.dart';

import '../../../core/resources/resources.dart';
import '../../../core/services/error/error_handler.dart';
import '../../../core/services/error/failure.dart';
import '../../../core/utils/constants.dart';

class AddExamRepository {
  final NetworkInfo _networkInfo;

  AddExamRepository(this._networkInfo);

  Future<Either<Failure, String>> addExam(AddExamBody addExamBody) async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      try {
        final imagePathParts = addExamBody.image!.path.split("/");
        final imageRef = FirebaseStorage.instance.ref("exams/${imagePathParts[imagePathParts.length - 1]}");
        await imageRef.putFile(addExamBody.image!);
        final imageUrl = await imageRef.getDownloadURL();
        final docRef = FirebaseFirestore.instance.collection(Constants.exams).doc();
        await FirebaseFirestore.instance
            .collection(Constants.exams)
            .doc(docRef.id)
            .set(addExamBody.toJson(docRef.id, imageUrl));
        for (var question in addExamBody.questions) {
          await FirebaseFirestore.instance
              .collection(Constants.exams)
              .doc(docRef.id)
              .collection(Constants.questions)
              .add(question.toJson());
        }
        return const Right(AppStrings.examAddedSuccessfully);
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }
}
