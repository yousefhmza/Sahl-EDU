import 'dart:io';

import 'package:sahl_edu/core/utils/globals.dart';

class AddExamBody {
  String name;
  File? image;

  AddExamBody({this.name = "", this.image});

  void copyWith({
    String? name,
    File? image,
  }) {
    this.name = name ?? this.name;
    this.image = image ?? this.image;
  }

  Map<String, dynamic> toJson(String id, String image) {
    return {
      "id": id,
      "image": image,
      "name": name,
      "admin": currentUser!.toJson(),
    };
  }
}
