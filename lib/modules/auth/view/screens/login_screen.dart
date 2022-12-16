import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahl_edu/config/navigation/navigation.dart';
import 'package:sahl_edu/core/enums/user_type.dart';
import 'package:sahl_edu/core/resources/resources.dart';
import 'package:sahl_edu/core/utils/validators.dart';
import 'package:sahl_edu/core/view/views.dart';
import 'package:sahl_edu/modules/auth/cubits/login_cubit/login_cubit.dart';
import 'package:sahl_edu/modules/auth/view/widgets/bg_painting.dart';

class LoginScreen extends StatefulWidget {
  final UserType userType;

  const LoginScreen({required this.userType, Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LoginCubit loginCubit;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loginCubit = BlocProvider.of<LoginCubit>(context);
    loginCubit.loginBody.copyWith(email: "", password: "", userType: widget.userType);
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
                    hintText: AppStrings.email,
                    validator: Validators.emailValidator,
                    onChanged: (value) => loginCubit.loginBody.copyWith(email: value),
                    prefix: const CustomIcon(Icons.email_outlined),
                  ),
                  const VerticalSpace(AppSize.s16),
                  CustomTextField(
                    hintText: AppStrings.password,
                    validator: Validators.passwordValidator,
                    onChanged: (value) => loginCubit.loginBody.copyWith(password: value),
                    prefix: const CustomIcon(Icons.lock_outline),
                  ),
                  CustomTextButton(text: AppStrings.forgetPassword, onPressed: () {}),
                  const VerticalSpace(AppSize.s16),
                  CustomButton(
                    width: double.infinity,
                    text: AppStrings.login,
                    onPressed: () {},
                  ),
                  const VerticalSpace(AppSize.s16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomText(AppStrings.haveNoAccount),
                      CustomTextButton(
                        text: AppStrings.signup,
                        textColor: AppColors.primary,
                        onPressed: () => NavigationService.push(
                          context,
                          Routes.signupScreen,
                          arguments: {"user_type": widget.userType},
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
