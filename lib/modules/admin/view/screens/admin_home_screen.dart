import 'package:flutter/material.dart';

import '../../../../core/resources/resources.dart';
import '../../../../core/view/components/home_drawer.dart';
import '../../../../core/view/views.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        centerTitle: true,
        title: CustomText(AppStrings.admin, fontWeight: FontWeightManager.bold, fontSize: FontSize.s16),
      ),
      drawer: const HomeDrawer(),
      body: Center(child: CustomText("Admin Home Screen")),
    );
  }
}
