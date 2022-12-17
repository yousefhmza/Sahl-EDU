part of 'login_cubit.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {}

class LoginFailureState extends LoginStates {
  final Failure failure;

  LoginFailureState(this.failure);
}

class LogoutLoadingState extends LoginStates {}

class LogoutSuccessState extends LoginStates {
  final String message;

  LogoutSuccessState(this.message);
}

class LogoutFailureState extends LoginStates {
  final Failure failure;

  LogoutFailureState(this.failure);
}
