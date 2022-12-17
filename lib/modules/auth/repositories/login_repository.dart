import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sahl_edu/core/resources/resources.dart';
import 'package:sahl_edu/modules/auth/models/requests/login_body.dart';

import '../../../core/services/error/error_handler.dart';
import '../../../core/services/error/failure.dart';
import '../../../core/services/network/network_info.dart';
import '../../../core/utils/constants.dart';
import '../models/responses/user_model.dart';

class LoginRepository {
  final NetworkInfo _networkInfo;

  LoginRepository(this._networkInfo);

  Future<Either<Failure, UserModel>> login(LoginBody loginBody) async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginBody.email.trim().toLowerCase(),
          password: loginBody.password.trim(),
        );
        DocumentSnapshot<Map<String, dynamic>> user;
        user = await FirebaseFirestore.instance.collection(Constants.admins).doc(credential.user!.uid).get();
        if (!user.exists) {
          user = await FirebaseFirestore.instance.collection(Constants.students).doc(credential.user!.uid).get();
        }
        return Right(UserModel.fromJson(user.data()!));
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }

  Future<Either<Failure, String>> logout() async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      try {
        await FirebaseAuth.instance.signOut();
        return const Right(AppStrings.loggedOutSuccessfully);
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }
}
