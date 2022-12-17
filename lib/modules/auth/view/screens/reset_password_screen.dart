import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_edu/config/navigation/navigation.dart';
import 'package:sahl_edu/modules/auth/cubits/password_cubit/password_cubit.dart';

import '../../../../core/resources/resources.dart';
import '../../../../core/utils/alerts.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/view/views.dart';
import '../widgets/bg_painting.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late final PasswordCubit passwordCubit;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    passwordCubit = BlocProvider.of<PasswordCubit>(context);
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
                  const CustomText(AppStrings.resetPasswordDesc),
                  const VerticalSpace(AppSize.s16),
                  CustomTextField(
                    hintText: AppStrings.email,
                    controller: emailController,
                    validator: Validators.emailValidator,
                    prefix: const CustomIcon(Icons.email_outlined),
                  ),
                  const VerticalSpace(AppSize.s16),
                  BlocConsumer<PasswordCubit, PasswordStates>(
                    listener: (context, state) {
                      if (state is ResetPasswordFailureState) Alerts.showSnackBar(context, state.failure.message);
                      if (state is ResetPasswordSuccessState) {
                        Alerts.showToast(state.message);
                        NavigationService.goBack(context);
                      }
                    },
                    builder: (context, state) => state is ResetPasswordLoadingState
                        ? const LoadingSpinner()
                        : CustomButton(
                            width: double.infinity,
                            text: AppStrings.resetPassword,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                passwordCubit.resetPassword(emailController.text.trim());
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
