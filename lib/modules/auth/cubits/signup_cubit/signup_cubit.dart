import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_edu/modules/auth/repositories/signup_repository.dart';

part 'signup_states.dart';

class SignupCubit extends Cubit<SignupStates> {
  final SignupRepository _signupRepository;

  SignupCubit(this._signupRepository) : super(SignupInitialState());
}
