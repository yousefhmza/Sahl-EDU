import 'package:flutter/material.dart';

import '../../../../core/view/views.dart';

class TeacherHomeScreen extends StatelessWidget {
  const TeacherHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const StatusBar(
      child: Scaffold(
        body: Center(child: CustomText("Teacher Home Screen")),
      ),
    );
  }
}
