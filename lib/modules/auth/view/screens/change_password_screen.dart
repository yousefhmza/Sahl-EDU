import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_edu/core/extensions/non_null_extensions.dart';
import 'package:sahl_edu/modules/auth/cubits/password_cubit/password_cubit.dart';

import '../../../../config/navigation/navigation.dart';
import '../../../../core/resources/resources.dart';
import '../../../../core/utils/alerts.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/view/views.dart';
import '../widgets/bg_painting.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final PasswordCubit passwordCubit = BlocProvider.of<PasswordCubit>(context);
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
                  const CustomText(AppStrings.changePasswordDesc),
                  const VerticalSpace(AppSize.s16),
                  CustomTextField(
                    hintText: AppStrings.oldPassword,
                    controller: oldPasswordController,
                    validator: Validators.passwordValidator,
                    prefix: const CustomIcon(Icons.lock),
                  ),
                  const VerticalSpace(AppSize.s16),
                  BlocBuilder<PasswordCubit, PasswordStates>(
                    buildWhen: (context, state) => state is SetPasswordVisibilityState,
                    builder: (context, state) {
                      return CustomTextField(
                        obscureText: !passwordCubit.isPasswordVisible,
                        hintText: AppStrings.newPassword,
                        controller: newPasswordController,
                        validator: Validators.passwordValidator,
                        prefix: const CustomIcon(Icons.lock),
                        suffix: InkWell(
                          onTap: () => passwordCubit.setPasswordVisibility(),
                          child: CustomIcon(passwordCubit.isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                        ),
                      );
                    },
                  ),
                  const VerticalSpace(AppSize.s16),
                  BlocBuilder<PasswordCubit, PasswordStates>(
                    buildWhen: (context, state) => state is SetPasswordVisibilityState,
                    builder: (context, state) {
                      return CustomTextField(
                        obscureText: !passwordCubit.isPasswordVisible,
                        hintText: AppStrings.confirmPassword,
                        validator: (value) {
                          if (value.orEmpty.length < 8) {
                            return AppStrings.passwordValidator;
                          } else if (value.orEmpty != newPasswordController.text) {
                            return AppStrings.passwordsNotMatching;
                          }
                          return null;
                        },
                        prefix: const CustomIcon(Icons.lock),
                        suffix: InkWell(
                          onTap: () => passwordCubit.setPasswordVisibility(),
                          child: CustomIcon(passwordCubit.isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                        ),
                      );
                    },
                  ),
                  const VerticalSpace(AppSize.s16),
                  BlocConsumer<PasswordCubit, PasswordStates>(
                    listener: (context, state) {
                      if (state is UpdatePasswordFailureState) Alerts.showSnackBar(context, state.failure.message);
                      if (state is UpdatePasswordSuccessState) {
                        Alerts.showToast(state.message);
                        NavigationService.goBack(context);
                      }
                    },
                    builder: (context, state) => state is UpdatePasswordLoadingState
                        ? const LoadingSpinner()
                        : CustomButton(
                            width: double.infinity,
                            text: AppStrings.changePassword,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                passwordCubit.changePassword(
                                  oldPasswordController.text.trim(),
                                  newPasswordController.text.trim(),
                                );
                              }
                            },
                          ),
                  ),
                  const VerticalSpace(AppSize.s16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
