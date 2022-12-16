import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:sahl_edu/core/enums/user_type.dart';
import 'package:sahl_edu/core/services/error/error_handler.dart';
import 'package:sahl_edu/core/services/network/network_info.dart';
import 'package:sahl_edu/core/utils/constants.dart';
import 'package:sahl_edu/modules/auth/models/requests/signup_body.dart';
import 'package:sahl_edu/modules/auth/models/responses/user_model.dart';
import '../../../core/services/error/failure.dart';

class SignupRepository {
  final NetworkInfo _networkInfo;

  SignupRepository(this._networkInfo);

  Future<Either<Failure, UserModel>> signup(SignupBody signupBody) async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: signupBody.email.trim(),
          password: signupBody.password.trim(),
        );
        await FirebaseFirestore.instance
            .collection(signupBody.userType == UserType.teacher ? Constants.teachers : Constants.students)
            .doc(credential.user!.uid)
            .set(signupBody.toJson(credential.user!.uid));
        return Right(UserModel.fromJson(signupBody.toJson(credential.user!.uid)));
      } on FirebaseAuthException catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }
}
