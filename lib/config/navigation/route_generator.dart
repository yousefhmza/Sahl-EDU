import 'package:flutter/material.dart';
import 'package:sahl_edu/modules/admin/view/screens/add_exam_screen.dart';
import 'package:sahl_edu/modules/admin/view/screens/scores_screen.dart';
import 'package:sahl_edu/modules/auth/view/screens/change_password_screen.dart';

import 'package:sahl_edu/modules/auth/view/screens/login_screen.dart';
import 'package:sahl_edu/modules/auth/view/screens/reset_password_screen.dart';
import 'package:sahl_edu/modules/auth/view/screens/signup_screen.dart';
import 'package:sahl_edu/modules/auth/view/screens/user_type_screen.dart';
import 'package:sahl_edu/modules/student/view/screens/results_screen.dart';
import '../../modules/admin/view/screens/admin_home_screen.dart';
import '../../modules/splash/view/screens/splash_screen.dart';
import '../../core/view/views.dart';
import '../../modules/student/view/screens/questions_screen.dart';
import '../../modules/student/view/screens/student_home_screen.dart';
import 'navigation.dart';

class RouteGenerator {
  static Route onGenerateRoute(RouteSettings settings) {
    final arguments = settings.arguments as Map<String, dynamic>?;
    switch (settings.name) {
      case Routes.splashScreen:
        return platformPageRoute(const SplashScreen());
      case Routes.userTypeScreen:
        return platformPageRoute(UserTypeScreen());
      case Routes.adminHomeScreen:
        return platformPageRoute(const AdminHomeScreen());
      case Routes.loginScreen:
        return platformPageRoute(LoginScreen(userType: arguments!["user_type"]));
      case Routes.signupScreen:
        return platformPageRoute(SignupScreen(userType: arguments!["user_type"]));
      case Routes.resetPasswordScreen:
        return platformPageRoute(const ResetPasswordScreen());
      case Routes.studentHomeScreen:
        return platformPageRoute(const StudentHomeScreen());
      case Routes.questionsScreen:
        return platformPageRoute(QuestionsScreen(exam: arguments!["exam"]));
      case Routes.resultsScreen:
        return platformPageRoute(ResultsScreen(totalDegree: arguments!["total_degree"], examId: arguments["exam_id"]));
      case Routes.addExamScreen:
        return platformPageRoute(const AddExamScreen());
      case Routes.changePasswordScreen:
        return platformPageRoute( ChangePasswordScreen());
      case Routes.scoresScreen:
        return platformPageRoute(ScoresScreen(examId: arguments!["exam_id"]));
      default:
        return platformPageRoute(const UndefinedRouteScreen());
    }
  }
}
