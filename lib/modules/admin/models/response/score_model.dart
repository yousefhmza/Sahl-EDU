import 'package:sahl_edu/modules/auth/models/responses/user_model.dart';

class ScoreModel {
  final int degree;
  final int totalDegree;
  final UserModel student;

  ScoreModel({
    required this.degree,
    required this.totalDegree,
    required this.student,
  });

  factory ScoreModel.fromJson(Map<String, dynamic> json) => ScoreModel(
        degree: json["score"] ?? 0,
        totalDegree: json["total_degree"] ?? 0,
        student: UserModel.fromJson(json["student"]),
      );
}
