import 'package:sahl_edu/core/enums/user_type.dart';

class SignupBody {
  UserType userType;
  String name;
  String email;
  String password;

  SignupBody({
    this.userType = UserType.none,
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
    this.userType = userType ?? this.userType;
    this.name = name ?? this.name;
    this.email = email ?? this.email;
    this.password = password ?? this.password;
  }

  Map<String, dynamic> toJson(String id) {
    return {
      "id": id,
      "user_type": userType.name,
      "name": name.trim(),
      "email": email.trim(),
    };
  }
}
