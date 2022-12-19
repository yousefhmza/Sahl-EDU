part of 'password_cubit.dart';

abstract class PasswordStates {}

class PasswordInitialState extends PasswordStates {}

class SetPasswordVisibilityState extends PasswordStates {}

class ResetPasswordLoadingState extends PasswordStates {}

class ResetPasswordSuccessState extends PasswordStates {
  final String message;

  ResetPasswordSuccessState(this.message);
}

class ResetPasswordFailureState extends PasswordStates {
  final Failure failure;

  ResetPasswordFailureState(this.failure);
}

class UpdatePasswordLoadingState extends PasswordStates {}

class UpdatePasswordSuccessState extends PasswordStates {
  final String message;

  UpdatePasswordSuccessState(this.message);
}

class UpdatePasswordFailureState extends PasswordStates {
  final Failure failure;

  UpdatePasswordFailureState(this.failure);
}
