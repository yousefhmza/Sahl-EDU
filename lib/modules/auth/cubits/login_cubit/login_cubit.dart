import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/login_repository.dart';

part 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  final LoginRepository _loginRepository;

  LoginCubit(this._loginRepository) : super(LoginInitialState());
}
