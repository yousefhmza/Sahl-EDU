part of 'splash_cubit.dart';

abstract class SplashStates {}

class SplashInitialState extends SplashStates {}

class GetCurrentUserLoadingState extends SplashStates {}

class GetCurrentUserSuccessState extends SplashStates {}

class GetCurrentUserFailureState extends SplashStates {
  final Failure failure;

  GetCurrentUserFailureState(this.failure);
}
