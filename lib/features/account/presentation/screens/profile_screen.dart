import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/features/account/bloc/user_profile_bloc/user_profile_bloc.dart';
import 'package:wulflex/features/account/presentation/widgets/profile_screen_widgets.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/shared/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final lightTheme = isLightTheme(context);
    // Trigger FetchUserProfileEvent when the screen is built
    context.read<UserProfileBloc>().add(FetchUserProfileEvent());

    return Scaffold(
        backgroundColor:
            lightTheme ? AppColors.whiteThemeColor : AppColors.blackThemeColor,
        appBar: customAppbarWithBackbutton(context, 'PROFILE'),
        body: BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, state) {
            if (state is UserProfileLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is UserProfileError) {
              // display error
            } else if (state is UserProfileLoaded) {
              final user = state.user;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 18, right: 18, bottom: 18),
                  child: Column(
                    children: [
                      ProfileScreenWidgets.buildProfilePicture(
                          context, user.userImage ?? ''),
                      ProfileScreenWidgets.buildWelcomeText(context, user.name),
                      SizedBox(height: 15),
                      ProfileScreenWidgets.buildName(user.name),
                      SizedBox(height: 15),
                      ProfileScreenWidgets.buildAccountInfo(user.email),
                      SizedBox(height: 15),
                      ProfileScreenWidgets.buildPhoneNumber(
                          user.phoneNumber ?? ''),
                      SizedBox(height: 15),
                      ProfileScreenWidgets.buildDob(user.dob ?? ''),
                      SizedBox(height: 28),
                      ProfileScreenWidgets.buildEditButton(context, user.name,
                          user.phoneNumber ?? '', user.dob ?? ''),
                      SizedBox(height: 20),
                      ProfileScreenWidgets.buildDeleteButton(context)
                    ],
                  ),
                ),
              );
            }
            return const Center(
                child: Text('Some Unknown error have occured.'));
          },
        ));
  }
}