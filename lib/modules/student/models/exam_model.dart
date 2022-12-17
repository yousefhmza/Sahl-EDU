import 'package:sahl_edu/modules/auth/models/responses/user_model.dart';

class Exam {
  final String id;
  final String name;
  final String image;
  final UserModel admin;

  Exam({
    required this.id,
    required this.name,
    required this.image,
    required this.admin,
  });

  factory Exam.fromJson(Map<String, dynamic> json) => Exam(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        admin: UserModel.fromJson(json["admin"]),
      );
}
