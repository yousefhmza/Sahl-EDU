import 'package:flutter/material.dart';
import 'package:sahl_edu/modules/auth/view/screens/user_type_screen.dart';
import 'package:sahl_edu/modules/student_home/view/screens/student_home_screen.dart';
import 'package:sahl_edu/modules/teacher_home/view/screens/teacher_home_screen.dart';

import '../../modules/splash/view/screens/splash_screen.dart';
import '../../core/view/views.dart';
import 'navigation.dart';

class RouteGenerator {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return platformPageRoute(const SplashScreen());
      case Routes.userTypeScreen:
        return platformPageRoute(const UserTypeScreen());
      case Routes.teacherHomeScreen:
        return platformPageRoute(const TeacherHomeScreen());
      case Routes.studentHomeScreen:
        return platformPageRoute(const StudentHomeScreen());
      default:
        return platformPageRoute(const UndefinedRouteScreen());
    }
  }
}
