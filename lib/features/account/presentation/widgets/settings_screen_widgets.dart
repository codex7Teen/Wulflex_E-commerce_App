import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/features/account/bloc/notification_bloc/notification_bloc_bloc.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';
import 'package:wulflex/shared/widgets/theme_toggle_widget.dart';

class SettingsScreenWidgets {
  static Widget buildAppthemeToggler(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 18, right: 18),
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.lightGreyThemeColor,
          borderRadius: BorderRadius.circular(18)),
      child: Row(
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.brightness_6_rounded,
                size: 24,
                color: AppColors.blackThemeColor,
              ),
              SizedBox(height: 3)
            ],
          ),
          const SizedBox(width: 8),
          Text(
            'APP THEME',
            style: AppTextStyles.buttonCardsText,
          ),
          const Spacer(),
          Container(
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                  color: AppColors.greenThemeColor,
                  borderRadius: BorderRadius.circular(18)),
              child:
                  ThemeToggleSwitchWidget(isLightTheme: isLightTheme(context))),
        ],
      ),
    );
  }

  static Widget buildNotificationToggeler() {
    return BlocBuilder<NotificationBlocBloc, NotificationBlocState>(
              builder: (context, state) {
                return Container(
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.lightGreyThemeColor,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.notifications,
                            size: 24,
                            color: AppColors.blackThemeColor,
                          ),
                          SizedBox(height: 3)
                        ],
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'NOTIFICATIONS',
                        style: AppTextStyles.buttonCardsText,
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: AppColors.greenThemeColor,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            HapticFeedback.mediumImpact();
                            context.read<NotificationBlocBloc>().add(
                                ToggleNotification(
                                    !state.isNotificationEnabled));
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: 60,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: state.isNotificationEnabled
                                  ? AppColors.greenThemeColor
                                  : AppColors.lightGreyThemeColor,
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 8,
                                  top: 6,
                                  child: state.isNotificationEnabled
                                      ? const Text(
                                          'On',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        )
                                      : const SizedBox(),
                                ),
                                Positioned(
                                  right: 8,
                                  top: 6,
                                  child: !state.isNotificationEnabled
                                      ? const Text(
                                          'Off',
                                          style: TextStyle(
                                            color: AppColors.blackThemeColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        )
                                      : const SizedBox(),
                                ),
                                AnimatedPositioned(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  left:
                                      state.isNotificationEnabled ? 32.0 : 2.0,
                                  top: 2.0,
                                  child: Container(
                                    width: 26,
                                    height: 26,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: state.isNotificationEnabled
                                          ? Colors.white
                                          : AppColors.blackThemeColor,
                                    ),
                                    child: Icon(
                                      state.isNotificationEnabled
                                          ? Icons.notifications_active
                                          : Icons.notifications_off_rounded,
                                      color: state.isNotificationEnabled
                                          ? AppColors.greenThemeColor
                                          : Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
  }
}
