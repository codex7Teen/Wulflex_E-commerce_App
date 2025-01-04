import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/data/services/notification_services.dart';
import 'package:wulflex/features/account/presentation/screens/account_screen.dart';
import 'package:wulflex/features/cart/bloc/cart_bloc/cart_bloc.dart';
import 'package:wulflex/features/cart/presentation/screens/cart_screen.dart';
import 'package:wulflex/features/favorite/presentation/screens/favorite_screen.dart';
import 'package:wulflex/features/home/presentation/screens/home_screen.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

// var to track current index or (page)
var currentIndex = 0;

class _MainScreenState extends State<MainScreen> {
  static const List<Widget> screens = [
    ScreenHome(),
    ScreenFavorite(),
    ScreenCart(),
    ScreenAccount()
  ];

  static const List<String> listOfStrings = [
    'Home',
    'Favorite',
    'Cart',
    'Account'
  ];

  static const List<IconData> listOfIcons = [
    Icons.home_sharp,
    Icons.favorite_sharp,
    Icons.shopping_cart_rounded,
    Icons.manage_accounts_sharp
  ];

  @override
  void initState() {
    super.initState();
    notificationHandler();
  }

  // Method which handles notification
  void notificationHandler() {
    FirebaseMessaging.onMessage.listen((event) async {
      log(event.notification!.title.toString());
      NotificationServices().showNotification(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    context.read<CartBloc>().add(FetchCartEvent());
    double displayWidth = MediaQuery.sizeOf(context).width;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 800),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
          child: ScaleTransition(
            scale: Tween<double>(
              begin: 0.98,
              end: 1.0,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            )),
            child: child,
          ),
        );
      },
      child: Scaffold(
        key: ValueKey(
            isLightTheme(context)), // Key based on theme to trigger animation
        body: screens[currentIndex],
        backgroundColor: AppColors.scaffoldColor(context),
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(
              vertical: displayWidth * 0.044, horizontal: displayWidth * 0.04),
          height: displayWidth * .15,
          decoration: BoxDecoration(
              color: isLightTheme(context)
                  ? AppColors.appBarLightGreyThemeColor
                  : AppColors.whiteThemeColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withValues(alpha: .1),
                    blurRadius: 30,
                    offset: const Offset(0, 10))
              ],
              borderRadius: BorderRadius.circular(50)),
          child: ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
              itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      setState(() {
                        currentIndex = index;
                        HapticFeedback.heavyImpact();
                      });
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Stack(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          width: index == currentIndex
                              ? displayWidth * .32
                              : displayWidth * .18,
                          alignment: Alignment.center,
                          child: AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            height:
                                index == currentIndex ? displayWidth * .12 : 0,
                            width:
                                index == currentIndex ? displayWidth * .32 : 0,
                            decoration: BoxDecoration(
                                color: index == currentIndex
                                    ? isLightTheme(context)
                                        ? AppColors.whiteThemeColor
                                        : AppColors.blackThemeColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(50)),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          width: index == currentIndex
                              ? displayWidth * .31
                              : displayWidth * .18,
                          alignment: Alignment.center,
                          child: Stack(children: [
                            Row(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  width: index == currentIndex
                                      ? displayWidth * .13
                                      : 0,
                                ),
                                AnimatedOpacity(
                                  opacity: index == currentIndex ? 1 : 0,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  child: Text(
                                      index == currentIndex
                                          ? listOfStrings[index]
                                          : '',
                                      style:
                                          AppTextStyles.bottomNavigationBarText(
                                              context)),
                                )
                              ],
                            ),
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Row(
                                  children: [
                                    AnimatedContainer(
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      width: index == currentIndex
                                          ? displayWidth * .03
                                          : 20,
                                    ),
                                    Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Icon(
                                          listOfIcons[index],
                                          size: displayWidth * .076,
                                          color: index == currentIndex
                                              ? AppColors.greenThemeColor
                                              : AppColors.blackThemeColor,
                                        ),
                                        if (index == 2)
                                          Positioned(
                                              top: -8,
                                              right: -8,
                                              child: BlocBuilder<CartBloc,
                                                  CartState>(
                                                builder: (context, state) {
                                                  int itemCount = 0;
                                                  if (state is CartLoaded) {
                                                    itemCount =
                                                        state.products.fold(
                                                      0,
                                                      (sum, product) =>
                                                          sum +
                                                          (product.quantity),
                                                    );
                                                  }
                                                  return itemCount > 0
                                                      ? Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: currentIndex ==
                                                                        2 &&
                                                                    !isLightTheme(
                                                                        context)
                                                                ? AppColors
                                                                    .whiteThemeColor
                                                                : AppColors
                                                                    .greenThemeColor,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          constraints:
                                                              const BoxConstraints(
                                                            minWidth: 16,
                                                            minHeight: 16,
                                                          ),
                                                          child: Text(
                                                            itemCount
                                                                .toString(),
                                                            style: TextStyle(
                                                              color: currentIndex ==
                                                                          2 &&
                                                                      !isLightTheme(
                                                                          context)
                                                                  ? AppColors
                                                                      .blackThemeColor
                                                                  : AppColors
                                                                      .whiteThemeColor,
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        )
                                                      : const SizedBox.shrink();
                                                },
                                              ))
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ]),
                        ),
                      ],
                    ),
                  )),
        ),
      ),
    );
  }
}
