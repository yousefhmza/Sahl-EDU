import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahl_edu/core/services/error/failure.dart';
import 'package:sahl_edu/core/utils/globals.dart';
import 'package:sahl_edu/modules/auth/models/requests/signup_body.dart';
import 'package:sahl_edu/modules/auth/repositories/signup_repository.dart';

part 'signup_states.dart';

class SignupCubit extends Cubit<SignupStates> {
  final SignupRepository _signupRepository;

  SignupCubit(this._signupRepository) : super(SignupInitialState());

  SignupBody signupBody = SignupBody();

  Future<void> signup() async {
    emit(SignupLoadingState());
    final result = await _signupRepository.signup(signupBody);
    result.fold(
      (failure) => emit(SignupFailureState(failure)),
      (user) {
        currentUser = user;
        emit(SignupSuccessState());
      },
    );
  }
}
