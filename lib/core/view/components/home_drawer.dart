import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_edu/config/navigation/navigation.dart';
import 'package:sahl_edu/core/extensions/num_extensions.dart';
import 'package:sahl_edu/core/resources/resources.dart';
import 'package:sahl_edu/core/utils/alerts.dart';
import 'package:sahl_edu/core/utils/globals.dart';
import 'package:sahl_edu/core/view/views.dart';
import 'package:sahl_edu/modules/auth/cubits/login_cubit/login_cubit.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: deviceWidth * 0.75,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Column(
            children: [
              ClipOval(
                child: CustomNetworkImage(
                  image:
                      "https://st.depositphotos.com/2218212/2938/i/600/depositphotos_29387653-stock-photo-facebook-profile.jpg",
                  width: AppSize.s100.w,
                  height: AppSize.s100.w,
                ),
              ),
              const VerticalSpace(AppSize.s8),
              CustomText(
                currentUser!.name,
                textAlign: TextAlign.center,
                fontWeight: FontWeightManager.semiBold,
                fontSize: FontSize.s16,
              ),
              const VerticalSpace(AppSize.s8),
              const Divider(),
              const VerticalSpace(AppSize.s8),
              ListTile(
                onTap: () => BlocProvider.of<LoginCubit>(context).logout(),
                contentPadding: EdgeInsets.zero,
                horizontalTitleGap: AppSize.s0,
                leading: const CustomIcon(Icons.person),
                title: const CustomText(AppStrings.profile),
              ),
              ListTile(
                onTap: () => BlocProvider.of<LoginCubit>(context).logout(),
                contentPadding: EdgeInsets.zero,
                horizontalTitleGap: AppSize.s0,
                leading: const CustomIcon(Icons.logout),
                title: const CustomText(AppStrings.logout),
              ),
              const VerticalSpace(AppSize.s16),
              BlocConsumer<LoginCubit, LoginStates>(
                listener: (context, state) {
                  if (state is LogoutSuccessState) {
                    Alerts.showToast(state.message);
                    NavigationService.pushReplacementAll(context, Routes.userTypeScreen);
                  }
                  if (state is LogoutFailureState) Alerts.showToast(state.failure.message);
                },
                builder: (context, state) =>
                    state is LogoutLoadingState ? const LoadingSpinner() : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
