import 'package:flutter/material.dart';
import 'package:sahl_edu/modules/auth/view/screens/login_screen.dart';
import 'package:sahl_edu/modules/auth/view/screens/signup_screen.dart';
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
        return platformPageRoute(UserTypeScreen());
      case Routes.teacherHomeScreen:
        return platformPageRoute(const TeacherHomeScreen());
      case Routes.loginScreen:
        final arguments = settings.arguments as Map<String, dynamic>;
        return platformPageRoute(LoginScreen(userType: arguments["user_type"]));
      case Routes.signupScreen:
        final arguments = settings.arguments as Map<String, dynamic>;
        return platformPageRoute(SignupScreen(userType: arguments["user_type"]));
      case Routes.studentHomeScreen:
        return platformPageRoute(const StudentHomeScreen());
      default:
        return platformPageRoute(const UndefinedRouteScreen());
    }
  }
}
