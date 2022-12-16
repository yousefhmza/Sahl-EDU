import 'package:sahl_edu/core/enums/user_type.dart';

class LoginBody {
  UserType userType;
  String email;
  String password;

  LoginBody({
    this.userType = UserType.none,
    this.email = "",
    this.password = "",
  });

  void copyWith({
    UserType? userType,
    String? email,
    String? password,
  }) {
    this.userType = userType ?? this.userType;
    this.email = email ?? this.email;
    this.password = password ?? this.password;
  }

  Map<String, dynamic> toJson() {
    return {
      "user_type": userType.name,
      "email": email.trim(),
    };
  }
}
