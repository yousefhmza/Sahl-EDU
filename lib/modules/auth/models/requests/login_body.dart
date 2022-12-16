import 'package:sahl_edu/core/enums/user_type.dart';

class LoginBody {
  UserType? userType;
  String email;
  String password;

  LoginBody({
    this.userType,
    this.email = "",
    this.password = "",
  });

  void copyWith({
    UserType? userType,
    String? email,
    String? password,
  }) {
    userType = userType ?? this.userType;
    email = email ?? this.email;
    password = password ?? this.password;
  }

  Map<String, dynamic> toJson() {
    return {
      "user_type": userType.toString(),
      "email": email,
      "password": password,
    };
  }
}
