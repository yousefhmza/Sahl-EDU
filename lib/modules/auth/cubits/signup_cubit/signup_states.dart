part of 'signup_cubit.dart';

abstract class SignupStates {}

class SignupInitialState extends SignupStates {}

class SignupLoadingState extends SignupStates {}

class SignupSuccessState extends SignupStates {}

class SignupFailureState extends SignupStates {
  final Failure failure;

  SignupFailureState(this.failure);
}
