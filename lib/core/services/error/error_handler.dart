import 'package:firebase_core/firebase_core.dart';
import 'failure.dart';

class ErrorHandler {
  late Failure failure;

  ErrorHandler.handle(Exception error) {
    if (error is FirebaseException) {
      failure = _handleFirebaseException(error);
    } else {
      failure = ErrorType.unKnown.getFailure();
    }
  }

  Failure _handleFirebaseException(FirebaseException firebaseException) {
    switch (firebaseException.code) {
      case ResponseCode.wrongPassword:
        return ErrorType.wrongPassword.getFailure();
      case ResponseCode.invalidEmail:
        return ErrorType.invalidEmail.getFailure();
      case ResponseCode.userDisabled:
        return ErrorType.userDisabled.getFailure();
      case ResponseCode.userNotFound:
        return ErrorType.userNotFound.getFailure();
      case ResponseCode.emailAlreadyInUse:
        return ErrorType.emailAlreadyInUse.getFailure();
      case ResponseCode.operationNotAllowed:
        return ErrorType.operationNotAllowed.getFailure();
      case ResponseCode.weakPassword:
        return ErrorType.weakPassword.getFailure();
      default:
        return Failure(ResponseCode.unKnown, ResponseMessage.unKnown);
    }
  }
}

enum ErrorType {
  wrongPassword,
  invalidEmail,
  userDisabled,
  userNotFound,
  emailAlreadyInUse,
  operationNotAllowed,
  weakPassword,
  noInternetConnection,
  unKnown,
}

extension ErrorTypeException on ErrorType {
  Failure getFailure() {
    switch (this) {
      case ErrorType.wrongPassword:
        return Failure(ResponseCode.wrongPassword, ResponseMessage.wrongPassword);
      case ErrorType.invalidEmail:
        return Failure(ResponseCode.invalidEmail, ResponseMessage.invalidEmail);
      case ErrorType.userDisabled:
        return Failure(ResponseCode.userDisabled, ResponseMessage.userDisabled);
      case ErrorType.userNotFound:
        return Failure(ResponseCode.userNotFound, ResponseMessage.userNotFound);
      case ErrorType.emailAlreadyInUse:
        return Failure(ResponseCode.emailAlreadyInUse, ResponseMessage.emailAlreadyInUse);
      case ErrorType.operationNotAllowed:
        return Failure(ResponseCode.operationNotAllowed, ResponseMessage.operationNotAllowed);
      case ErrorType.weakPassword:
        return Failure(ResponseCode.weakPassword, ResponseMessage.weakPassword);
      case ErrorType.noInternetConnection:
        return Failure(ResponseCode.noInternetConnection, ResponseMessage.noInternetConnection);
      case ErrorType.unKnown:
        return Failure(ResponseCode.unKnown, ResponseMessage.unKnown);
    }
  }
}

class ResponseCode {
  static const String wrongPassword = "wrong-password";
  static const String invalidEmail = "invalid-email";
  static const String userDisabled = "user-disabled";
  static const String userNotFound = "user-not-found";
  static const String emailAlreadyInUse = "email-already-in-use";
  static const String operationNotAllowed = "operation-not-allowed";
  static const String weakPassword = "weak-password";
  static const String noInternetConnection = "no-internet";
  static const String unKnown = "unknown";
}

class ResponseMessage {
  static const String wrongPassword = "Wrong password, please try again.";
  static const String invalidEmail = "Invalid E-mail, please try again.";
  static const String userDisabled = "The user corresponding to the given email has been disabled";
  static const String userNotFound = "There is no user corresponding to the given email.";
  static const String emailAlreadyInUse = "There already exists an account with the given email address";
  static const String operationNotAllowed = "E-mail/password accounts are not enabled";
  static const String weakPassword = "The password is not strong enough";
  static const String noInternetConnection = "Please check your internet connection.";
  static const String unKnown = "Something went wrong, try again.";
}
