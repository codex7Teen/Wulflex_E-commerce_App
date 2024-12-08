import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
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
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/shared/widgets/custom_snacbar_widget.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class ScreenAccount extends StatelessWidget {
  const ScreenAccount({super.key});

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
                      Center(
                        child: SizedBox(
                          height: 180,
                          width: 180,
                          child: imageUrl.isNotEmpty
                              ? Stack(children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Lottie.asset(
                                        'assets/lottie/profile.json'),
                                  ),
                                  Positioned(
                                      left: 36.6,
                                      top: 36,
                                      child: SizedBox(
                                        height: 180 *
                                            0.6, // 70% of the Lottie's size
                                        width: 180 * 0.6,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.network(
                                            imageUrl,
                                            fit: BoxFit.cover,
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              // show image loading indicator
                                              return Center(
                                                  child: Container(
                                                height: 180 * 0.6,
                                                width: 180 * 0.6,
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.4),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                ),
                                                child: CircularProgressIndicator(
                                                    strokeWidth: 6,
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes!
                                                        : null),
                                              ));
                                            },
                                          ),
                                        ),
                                      ))
                                ])
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Lottie.asset(
                                      'assets/lottie/profile.json'),
                                ),
                        ),
                      ),
                      Text('${getGreeting()}, ${user.name}',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: AppTextStyles.heyUserWelcomeText(context)),
                      SizedBox(height: 28),
                      Text(
                        textAlign: TextAlign.start,
                        'ACCOUNT',
                        style: AppTextStyles.mainScreenHeadings(context),
                      ),
                      SizedBox(height: 8),
                      buildButtonCards(
                          icon: Icons.shopping_bag_rounded, name: "MY ORDERS"),
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
                      Text(
                        textAlign: TextAlign.start,
                        'CONNECT',
                        style: AppTextStyles.mainScreenHeadings(context),
                      ),
                      SizedBox(height: 8),
                      buildButtonCards(
                          onTap: () async {
                            // Open instagram using the link 'https://www.instagram.com/denniz_jhnsn?igsh=MWFqdmc5b2FpcHA5'
                          },
                          icon: Icons.smartphone_rounded,
                          name: "INSTAGRAM"),
                      SizedBox(height: 28),
                      Text(
                        textAlign: TextAlign.start,
                        'APP',
                        style: AppTextStyles.mainScreenHeadings(context),
                      ),
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
                                  context, ScreenDeleteAccount()),
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
}
