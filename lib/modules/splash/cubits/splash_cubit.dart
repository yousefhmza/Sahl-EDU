import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahl_edu/core/services/error/failure.dart';
import 'package:sahl_edu/core/utils/globals.dart';
import '../repositories/splash_repository.dart';

part 'splash_states.dart';

class SplashCubit extends Cubit<SplashStates> {
  final SplashRepository _splashRepository;

  SplashCubit(this._splashRepository) : super(SplashInitialState());

  Future<void> getCurrentUser(String id) async {
    emit(GetCurrentUserLoadingState());
    final result = await _splashRepository.getCurrentUser(id);
    result.fold(
      (failure) => emit(GetCurrentUserFailureState(failure)),
      (user) {
        currentUser = user;
        emit(GetCurrentUserSuccessState());
      },
    );
  }
}
