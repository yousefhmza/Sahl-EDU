import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_edu/modules/admin/cubits/add_exam_cubit/add_exam_cubit.dart';
import 'package:sahl_edu/modules/admin/cubits/admin_home_cubit/admin_home_cubit.dart';

import 'package:sahl_edu/modules/auth/cubits/login_cubit/login_cubit.dart';
import 'package:sahl_edu/modules/auth/cubits/password_cubit/password_cubit.dart';
import 'package:sahl_edu/modules/auth/cubits/signup_cubit/signup_cubit.dart';
import 'package:sahl_edu/modules/splash/cubits/splash_cubit.dart';
import 'package:sahl_edu/modules/student/cubits/questions_cubit/questions_cubit.dart';
import 'config/navigation/navigation.dart';
import 'config/theme/light_theme.dart';
import 'core/services/bloc_observer.dart';
import 'core/utils/constants.dart';
import 'di_container.dart' as di;
import 'firebase_options.dart';
import 'modules/student/cubits/student_home_cubit/student_home_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();
  Bloc.observer = MyBlocObserver();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<SplashCubit>()),
        BlocProvider(create: (_) => di.sl<LoginCubit>()),
        BlocProvider(create: (_) => di.sl<SignupCubit>()),
        BlocProvider(create: (_) => di.sl<PasswordCubit>()),
        BlocProvider(create: (_) => di.sl<StudentHomeCubit>()),
        BlocProvider(create: (_) => di.sl<QuestionsCubit>()),
        BlocProvider(create: (_) => di.sl<AdminHomeCubit>()),
        BlocProvider(create: (_) => di.sl<AddExamCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      theme: lightTheme(context),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splashScreen,
      navigatorKey: NavigationService.navigationKey,
      onGenerateRoute: RouteGenerator.onGenerateRoute,
    );
  }
}
