import 'dart:developer';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/core/network/internet_connection_wrapper.dart';
import 'package:wulflex/features/account/presentation/screens/customer_support_screen.dart';
import 'package:wulflex/features/account/presentation/screens/my_orders_screen.dart';
import 'package:wulflex/features/account/presentation/screens/privacy_policy_screen.dart';
import 'package:wulflex/features/account/presentation/screens/relogin_screen.dart';
import 'package:wulflex/features/account/presentation/screens/terms_and_conditions_screen.dart';
import 'package:wulflex/features/auth/bloc/authentication_bloc/authenticaton_bloc_bloc.dart';
import 'package:wulflex/features/account/bloc/user_profile_bloc/user_profile_bloc.dart';
import 'package:wulflex/features/auth/presentation/screens/login_screen.dart';
import 'package:wulflex/features/account/presentation/widgets/account_screen_widgets.dart';
import 'package:wulflex/features/account/presentation/screens/address_manage_screen.dart';
import 'package:wulflex/features/account/presentation/screens/profile_screen.dart';
import 'package:wulflex/features/account/presentation/screens/settings_screen.dart';
import 'package:wulflex/features/account/presentation/widgets/signout_alert_widget.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/shared/widgets/custom_snacbar_widget.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';

class ScreenAccount extends StatelessWidget {
  const ScreenAccount({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger FetchUserProfileEvent when the screen is built
    context.read<UserProfileBloc>().add(FetchUserProfileEvent());
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor(context),
      body: BlocListener<AuthenticatonBlocBloc, AuthenticatonBlocState>(
        listener: (context, state) {
          if (state is LogOutSuccess) {
            CustomSnackbar.showCustomSnackBar(
                context, "Sign-out success... 🎉🎉🎉");
            Future.delayed(
              const Duration(milliseconds: 500),
              () {
                if (context.mounted) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const ScreenLogin()));
                }
              },
            );
          }
        },
        child: BlocBuilder<UserProfileBloc, UserProfileState>(
          buildWhen: (previous, current) {
            return current is UserProfileLoading ||
                current is UserProfileError ||
                current is UserProfileLoaded;
          },
          builder: (context, state) {
            if (state is UserProfileLoading) {
              return const Center(child: CircularProgressIndicator());
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
                      //! USER PROFILE IMAGE
                      ZoomIn(
                          child: AccountScreenWidgets.buildUserProfileImage(
                              imageUrl)),
                      //! GREETING TEXT
                      FadeInLeft(
                        child: AccountScreenWidgets.buildUserGreetingText(
                            user, AccountScreenWidgets.getGreeting, context),
                      ),
                      const SizedBox(height: 28),
                      //! ACCOUNT HEADING
                      FadeIn(
                          duration: const Duration(milliseconds: 100),
                          child: AccountScreenWidgets.buildAccountHeading(
                              context)),
                      const SizedBox(height: 8),
                      //! MY ORDERS
                      FadeIn(
                        duration: const Duration(milliseconds: 200),
                        child: AccountScreenWidgets.buildButtonCards(
                            onTap: () =>
                                NavigationHelper.navigateToWithoutReplacement(
                                    context,
                                    const InternetConnectionWrapper(
                                        child: ScreenMyOrders())),
                            icon: Icons.shopping_bag_rounded,
                            name: "MY ORDERS"),
                      ),
                      const SizedBox(height: 14),
                      //! MY PROFILE
                      FadeIn(
                        duration: const Duration(milliseconds: 300),
                        child: AccountScreenWidgets.buildButtonCards(
                            onTap: () =>
                                NavigationHelper.navigateToWithoutReplacement(
                                    context,
                                    const InternetConnectionWrapper(
                                        child: ScreenProfile())),
                            icon: Icons.person,
                            name: "MY PROFILE"),
                      ),
                      const SizedBox(height: 14),
                      //! ADDRESS BOOK
                      FadeIn(
                        duration: const Duration(milliseconds: 400),
                        child: AccountScreenWidgets.buildButtonCards(
                            onTap: () =>
                                NavigationHelper.navigateToWithoutReplacement(
                                    context,
                                    const InternetConnectionWrapper(
                                        child: ScreenManageAddress())),
                            icon: Icons.my_library_books,
                            name: "ADDRESS BOOK"),
                      ),
                      const SizedBox(height: 14),
                      //! SETTINGS
                      FadeIn(
                        duration: const Duration(milliseconds: 500),
                        child: AccountScreenWidgets.buildButtonCards(
                            onTap: () {
                              NavigationHelper.navigateToWithoutReplacement(
                                  context,
                                  const InternetConnectionWrapper(
                                      child: ScreenSettings()),
                                  transitionDuration: 150);
                            },
                            icon: Icons.settings,
                            name: "SETTINGS"),
                      ),
                      const SizedBox(height: 28),
                      //! CONNECT HEADING
                      FadeIn(
                          duration: const Duration(milliseconds: 600),
                          child: AccountScreenWidgets.buildConnectHeading(
                              context)),
                      const SizedBox(height: 8),
                      //! CUSTOMER SUPPORT
                      FadeIn(
                        duration: const Duration(milliseconds: 700),
                        child: AccountScreenWidgets.buildButtonCards(
                            onTap: () =>
                                NavigationHelper.navigateToWithoutReplacement(
                                    context,
                                    const InternetConnectionWrapper(
                                        child: ScreenCustomerSupport())),
                            icon: Icons.support_agent_rounded,
                            name: "CUSTOMER SUPPORT"),
                      ),
                      const SizedBox(height: 14),
                      //! SOCIAL MEDIA ACCOUNT
                      FadeIn(
                        duration: const Duration(milliseconds: 800),
                        child: AccountScreenWidgets.buildButtonCards(
                            onTap: () async {
                              try {
                                await AccountScreenWidgets.launchInstagram();
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
                      ),
                      const SizedBox(height: 28),
                      //! SIGN OUT
                      FadeIn(
                          duration: const Duration(milliseconds: 900),
                          child: AccountScreenWidgets.buildAppHeading(context)),
                      const SizedBox(height: 8),
                      FadeIn(
                        duration: const Duration(milliseconds: 1000),
                        child: AccountScreenWidgets.buildButtonCards(
                            onTap: () {
                              showCustomSignoutWarningAlertBox(context);
                            },
                            icon: Icons.logout_rounded,
                            name: "SIGN OUT"),
                      ),
                      const SizedBox(height: 14),
                      //! DELETE ACCOUNT
                      FadeIn(
                        duration: const Duration(milliseconds: 1100),
                        child: AccountScreenWidgets.buildButtonCards(
                            onTap: () =>
                                NavigationHelper.navigateToWithoutReplacement(
                                    context, const ScreenRelogin()),
                            icon: Icons.person_off_rounded,
                            name: "DELETE ACCOUNT"),
                      ),
                      const SizedBox(height: 14),
                      //! PRIVACY POLICY
                      FadeIn(
                        duration: const Duration(milliseconds: 1200),
                        child: AccountScreenWidgets.buildButtonCards(
                            onTap: () =>
                                NavigationHelper.navigateToWithoutReplacement(
                                    context, const PrivacyPolicyScreen(),
                                    transitionDuration: 150),
                            icon: Icons.security,
                            name: "PRIVACY POLICY"),
                      ),
                      const SizedBox(height: 14),
                      //! TERMS AND CONDITIONS
                      FadeIn(
                        duration: const Duration(milliseconds: 1300),
                        child: AccountScreenWidgets.buildButtonCards(
                            onTap: () =>
                                NavigationHelper.navigateToWithoutReplacement(
                                    context, const TermsAndConditionsScreen(),
                                    transitionDuration: 150),
                            icon: Icons.assignment,
                            name: "TERMS & CONDITIONS"),
                      ),
                      const SizedBox(height: 28),
                      //! APP LOGO & VERSION
                      AccountScreenWidgets.buildAppLogo(context),
                      const SizedBox(height: 2),
                      AccountScreenWidgets.buildAppVersion(context),
                    ],
                  ),
                ),
              );
            }
            //! UNKNOWN ERROR
            return const Center(
                child: Text('Some Unknown error have occured X.'));
          },
        ),
      ),
    );
  }
}
