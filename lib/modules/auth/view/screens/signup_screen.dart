import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahl_edu/config/navigation/navigation.dart';
import 'package:sahl_edu/core/utils/alerts.dart';
import 'package:sahl_edu/core/utils/globals.dart';
import 'package:sahl_edu/modules/auth/cubits/signup_cubit/signup_cubit.dart';
import '../../../../core/enums/user_type.dart';
import '../../../../core/resources/resources.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/view/views.dart';
import '../widgets/bg_painting.dart';

class SignupScreen extends StatefulWidget {
  final UserType userType;

  const SignupScreen({required this.userType, Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late final SignupCubit signupCubit;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    signupCubit = BlocProvider.of<SignupCubit>(context);
    signupCubit.signupBody.copyWith(email: "", password: "", name: "", userType: widget.userType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppbar(),
      body: CustomPaint(
        painter: BGPainting(),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpace(AppSize.s16),
                  const Center(child: SahlEDULogo()),
                  const VerticalSpace(AppSize.s16),
                  CustomTextField(
                    hintText: AppStrings.name,
                    validator: Validators.emptyValidator,
                    onChanged: (value) => signupCubit.signupBody.copyWith(name: value),
                    prefix: const CustomIcon(Icons.person),
                  ),
                  const VerticalSpace(AppSize.s16),
                  CustomTextField(
                    hintText: AppStrings.email,
                    validator: Validators.emailValidator,
                    onChanged: (value) => signupCubit.signupBody.copyWith(email: value),
                    prefix: const CustomIcon(Icons.email_outlined),
                  ),
                  const VerticalSpace(AppSize.s16),
                  CustomTextField(
                    hintText: AppStrings.password,
                    validator: Validators.passwordValidator,
                    onChanged: (value) => signupCubit.signupBody.copyWith(password: value),
                    prefix: const CustomIcon(Icons.lock_outline),
                  ),
                  const VerticalSpace(AppSize.s16),
                  BlocConsumer<SignupCubit, SignupStates>(
                    listener: (context, state) {
                      if (state is SignupFailureState) Alerts.showSnackBar(context, state.failure.message);
                      if (state is SignupSuccessState) {
                        NavigationService.pushReplacementAll(
                          context,
                          currentUser!.userType == UserType.admin
                              ? Routes.adminHomeScreen
                              : Routes.studentHomeScreen,
                        );
                      }
                    },
                    builder: (context, state) => state is SignupLoadingState
                        ? const LoadingSpinner()
                        : CustomButton(
                            width: double.infinity,
                            text: AppStrings.signup,
                            onPressed: () {
                              if (formKey.currentState!.validate()) signupCubit.signup();
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
