import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sahl_edu/core/resources/resources.dart';
import 'package:sahl_edu/core/services/error/error_handler.dart';
import 'package:sahl_edu/core/services/error/failure.dart';
import 'package:sahl_edu/core/services/network/network_info.dart';

class PasswordRepository {
  final NetworkInfo _networkInfo;

  PasswordRepository(this._networkInfo);

  Future<Either<Failure, String>> resetPassword(String email) async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        return const Right(AppStrings.passwordEmailSent);
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }
}
