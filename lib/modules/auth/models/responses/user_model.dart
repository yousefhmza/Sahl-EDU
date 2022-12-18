import 'package:sahl_edu/core/enums/user_type.dart';
import 'package:sahl_edu/core/utils/constants.dart';

class UserModel {
  final String id;
  final UserType userType;
  final String name;
  final String email;

  UserModel({
    required this.id,
    required this.userType,
    required this.name,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] ?? Constants.empty,
        userType: _getUserType(json["user_type"] ?? Constants.empty),
        name: json["name"] ?? Constants.empty,
        email: json["email"] ?? Constants.empty,
      );

  static UserType _getUserType(String userType) {
    switch (userType) {
      case "admin":
        return UserType.admin;
      case "student":
        return UserType.student;
      default:
        return UserType.none;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "user_type": userType.name,
    };
  }
}
