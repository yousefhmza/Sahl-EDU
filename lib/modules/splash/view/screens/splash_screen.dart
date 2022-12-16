import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahl_edu/config/navigation/navigation.dart';
import 'package:sahl_edu/core/enums/user_type.dart';
import 'package:sahl_edu/core/utils/alerts.dart';
import 'package:sahl_edu/core/utils/globals.dart';
import 'package:sahl_edu/core/view/views.dart';
import 'package:sahl_edu/modules/splash/cubits/splash_cubit.dart';

import '../../../../core/resources/resources.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final SplashCubit splashCubit;
  late final StreamSubscription<User?> authStateStreamSubscription;

  @override
  void initState() {
    super.initState();
    splashCubit = BlocProvider.of<SplashCubit>(context);
    Future.delayed(Time.t2000, () async {
      await Future.wait([
        precachePicture(ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, AppImages.student), null),
        precachePicture(ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, AppImages.teacher), null),
      ]);
      authStateStreamSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
        if (user == null) {
          NavigationService.pushReplacementAll(context, Routes.userTypeScreen);
        } else {
          splashCubit.getCurrentUser(user.uid);
        }
      });
    });
  }

  @override
  void dispose() {
    authStateStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StatusBar(
      child: Scaffold(
        body: Stack(
          children: [
            const Center(child: SahlEDULogo()),
            Align(
              alignment: Alignment.bottomCenter,
              child: BlocConsumer<SplashCubit, SplashStates>(
                listener: (context, state) {
                  if (state is GetCurrentUserFailureState) {
                    Alerts.showActionSnackBar(
                      context,
                      message: state.failure.message,
                      actionLabel: AppStrings.retry,
                      onActionPressed: () => splashCubit.getCurrentUser(FirebaseAuth.instance.currentUser!.uid),
                    );
                  }
                  if (state is GetCurrentUserSuccessState) {
                    NavigationService.pushReplacementAll(
                      context,
                      currentUser!.userType == UserType.teacher ? Routes.teacherHomeScreen : Routes.studentHomeScreen,
                    );
                  }
                },
                builder: (context, state) {
                  return state is GetCurrentUserLoadingState
                      ? const Padding(
                          padding: EdgeInsets.all(AppPadding.p16),
                          child: SizedBox(
                            width: AppSize.s24,
                            height: AppSize.s24,
                            child: CircularProgressIndicator(color: AppColors.primary, strokeWidth: AppSize.s3),
                          ),
                        )
                      : const SizedBox.shrink();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
