import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahl_edu/core/services/error/failure.dart';
import 'package:sahl_edu/modules/auth/models/requests/login_body.dart';
import '../../../../core/utils/globals.dart';
import '../../repositories/login_repository.dart';

part 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  final LoginRepository _loginRepository;

  LoginCubit(this._loginRepository) : super(LoginInitialState());

  LoginBody loginBody = LoginBody();

  Future<void> login() async {
    emit(LoginLoadingState());
    final result = await _loginRepository.login(loginBody);
    result.fold(
      (failure) => emit(LoginFailureState(failure)),
      (user) {
        currentUser = user;
        emit(LoginSuccessState());
      },
    );
  }

  Future<void> logout() async {
    emit(LogoutLoadingState());
    final result = await _loginRepository.logout();
    result.fold(
      (failure) => emit(LogoutFailureState(failure)),
      (message) {
        currentUser = null;
        emit(LogoutSuccessState(message));
      },
    );
  }
}
