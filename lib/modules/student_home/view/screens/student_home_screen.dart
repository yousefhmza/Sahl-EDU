import 'package:flutter/material.dart';
import 'package:sahl_edu/core/view/views.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const StatusBar(
      child: Scaffold(
        body: Center(child: CustomText("Student Home Screen")),
      ),
    );
  }
}
