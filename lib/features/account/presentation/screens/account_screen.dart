import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wulflex/features/account/presentation/screens/customer_support_screen.dart';
import 'package:wulflex/features/account/presentation/screens/my_orders_screen.dart';
import 'package:wulflex/features/account/presentation/screens/relogin_screen.dart';
import 'package:wulflex/features/auth/bloc/authentication_bloc/authenticaton_bloc_bloc.dart';
import 'package:wulflex/features/account/bloc/user_profile_bloc/user_profile_bloc.dart';
import 'package:wulflex/features/auth/presentation/screens/login_screen.dart';
import 'package:wulflex/features/account/presentation/widgets/account_screen_widgets.dart';
import 'package:wulflex/features/account/presentation/screens/address_manage_screen.dart';
import 'package:wulflex/features/account/presentation/screens/delete_account_screen.dart';
import 'package:wulflex/features/account/presentation/screens/profile_screen.dart';
import 'package:wulflex/features/account/presentation/screens/settings_screen.dart';
import 'package:wulflex/features/account/presentation/widgets/signout_alert_widget.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/shared/widgets/custom_snacbar_widget.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class ScreenAccount extends StatelessWidget {
  const ScreenAccount({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger FetchUserProfileEvent when the screen is built
    context.read<UserProfileBloc>().add(FetchUserProfileEvent());
    return Scaffold(
      backgroundColor: isLightTheme(context)
          ? AppColors.whiteThemeColor
          : AppColors.blackThemeColor,
      body: BlocListener<AuthenticatonBlocBloc, AuthenticatonBlocState>(
        listener: (context, state) {
          if (state is LogOutSuccess) {
            CustomSnackbar.showCustomSnackBar(
                context, "Sign-out success... 🎉🎉🎉");
            Future.delayed(
              Duration(milliseconds: 500),
              () {
                if (context.mounted) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => ScreenLogin()));
                }
              },
            );
          }
        },
        child: BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, state) {
            if (state is UserProfileLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is UserProfileError) {
              // display error
            } else if (state is UserProfileLoaded) {
              final user = state.user;
              final imageUrl = user.userImage ?? '';
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 25, left: 18, right: 18, bottom: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildUserProfileImage(imageUrl),
                      buildUserGreetingText(user, getGreeting, context),
                      SizedBox(height: 28),
                      buildAccountHeading(context),
                      SizedBox(height: 8),
                      buildButtonCards(
                          onTap: () =>
                              NavigationHelper.navigateToWithoutReplacement(
                                  context, ScreenMyOrders()),
                          icon: Icons.shopping_bag_rounded,
                          name: "MY ORDERS"),
                      SizedBox(height: 14),
                      buildButtonCards(
                          onTap: () =>
                              NavigationHelper.navigateToWithoutReplacement(
                                  context, ScreenProfile()),
                          icon: Icons.person,
                          name: "MY PROFILE"),
                      SizedBox(height: 14),
                      buildButtonCards(
                          onTap: () =>
                              NavigationHelper.navigateToWithoutReplacement(
                                  context, ScreenManageAddress()),
                          icon: Icons.my_library_books,
                          name: "ADDRESS BOOK"),
                      SizedBox(height: 14),
                      buildButtonCards(
                          onTap: () {
                            NavigationHelper.navigateToWithoutReplacement(
                                context, ScreenSettings());
                          },
                          icon: Icons.settings,
                          name: "SETTINGS"),
                      SizedBox(height: 28),
                      buildConnectHeading(context),
                      SizedBox(height: 8),
                      buildButtonCards(
                          onTap: () =>
                              NavigationHelper.navigateToWithoutReplacement(
                                  context, ScreenCustomerSupport()),
                          icon: Icons.support_agent_rounded,
                          name: "CUSTOMER SUPPORT"),
                      SizedBox(height: 14),
                      buildButtonCards(
                          onTap: () async {
                            // Open instagram using the link 'https://www.instagram.com/denniz_jhnsn?igsh=MWFqdmc5b2FpcHA5'
                            try {
                              await _launchInstagram();
                            } catch (error) {
                              if (context.mounted) {
                                CustomSnackbar.showCustomSnackBar(
                                    context, "Could not open Instagram",
                                    icon: Icons.error);
                              }
                              log(error.toString());
                            }
                          },
                          icon: Icons.smartphone_rounded,
                          name: "INSTAGRAM"),
                      SizedBox(height: 28),
                      buildAppHeading(context),
                      SizedBox(height: 8),
                      buildButtonCards(
                          onTap: () {
                            showCustomSignoutWarningAlertBox(context);
                          },
                          icon: Icons.logout_rounded,
                          name: "SIGN OUT"),
                      SizedBox(height: 14),
                      buildButtonCards(
                          onTap: () =>
                              NavigationHelper.navigateToWithoutReplacement(
                                  context, ScreenRelogin()),
                          icon: Icons.person_off_rounded,
                          name: "DELETE ACCOUNT"),
                      SizedBox(height: 14),
                      buildButtonCards(
                          icon: Icons.security, name: "PRIVACY POLICY"),
                      SizedBox(height: 14),
                      buildButtonCards(
                          icon: Icons.assignment, name: "TERMS & CONDITIONS"),
                    ],
                  ),
                ),
              );
            }
            return const Center(
                child: Text('Some Unknown error have occured X.'));
          },
        ),
      ),
    );
  }

  // Helper method to determine greeting
  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  Future<void> _launchInstagram() async {
    final Uri url = Uri.parse(
        'https://www.instagram.com/denniz_jhnsn?igsh=MWFqdmc5b2FpcHA5');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
