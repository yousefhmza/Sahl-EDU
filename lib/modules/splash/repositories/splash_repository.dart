import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:sahl_edu/core/services/error/error_handler.dart';
import 'package:sahl_edu/core/services/error/failure.dart';
import 'package:sahl_edu/core/services/network/network_info.dart';
import 'package:sahl_edu/core/utils/constants.dart';
import '../../auth/models/responses/user_model.dart';

class SplashRepository {
  final NetworkInfo _networkInfo;

  SplashRepository(this._networkInfo);

  Future<Either<Failure, UserModel>> getCurrentUser(String id) async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      try {
        DocumentSnapshot<Map<String, dynamic>> user;
        user = await FirebaseFirestore.instance.collection(Constants.admins).doc(id).get();
        if (!user.exists) user = await FirebaseFirestore.instance.collection(Constants.students).doc(id).get();
        return Right(UserModel.fromJson(user.data()!));
      } on FirebaseException catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }
}
