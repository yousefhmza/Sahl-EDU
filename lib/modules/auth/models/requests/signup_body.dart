import 'package:sahl_edu/core/enums/user_type.dart';

class SignupBody {
  UserType? userType;
  String name;
  String email;
  String password;

  SignupBody({
    this.userType,
    this.name = "",
    this.email = "",
    this.password = "",
  });

  void copyWith({
    UserType? userType,
    String? name,
    String? email,
    String? password,
  }) {
    userType = userType ?? this.userType;
    name = name ?? this.name;
    email = email ?? this.email;
    password = password ?? this.password;
  }

  Map<String, dynamic> toJson() {
    return {
      "user_type": userType.toString(),
      "name": name,
      "email": email,
      "password": password,
    };
  }
}
