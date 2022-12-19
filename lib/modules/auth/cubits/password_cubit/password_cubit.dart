import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahl_edu/core/services/error/failure.dart';
import 'package:sahl_edu/modules/auth/repositories/password_repository.dart';

part 'password_states.dart';

class PasswordCubit extends Cubit<PasswordStates> {
  final PasswordRepository _passwordRepository;

  PasswordCubit(this._passwordRepository) : super(PasswordInitialState());

  bool isPasswordVisible = false;

  void setPasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(SetPasswordVisibilityState());
  }

  Future<void> resetPassword(String email) async {
    emit(ResetPasswordLoadingState());
    final result = await _passwordRepository.resetPassword(email);
    result.fold(
      (failure) => emit(ResetPasswordFailureState(failure)),
      (message) => emit(ResetPasswordSuccessState(message)),
    );
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    emit(UpdatePasswordLoadingState());
    final result = await _passwordRepository.updatePassword(oldPassword, newPassword);
    result.fold(
      (failure) => emit(UpdatePasswordFailureState(failure)),
      (message) => emit(UpdatePasswordSuccessState(message)),
    );
  }
}
