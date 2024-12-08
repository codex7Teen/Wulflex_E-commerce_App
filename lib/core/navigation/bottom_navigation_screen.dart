import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wulflex/features/account/presentation/screens/account_screen.dart';
import 'package:wulflex/features/cart/presentation/screens/cart_screen.dart';
import 'package:wulflex/features/favorite/presentation/screens/favorite_screen.dart';
import 'package:wulflex/features/home/presentation/screens/home_screen.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';

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
  Widget build(BuildContext context) {
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
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
        key: ValueKey(isLightTheme), // Key based on theme to trigger animation
        body: screens[currentIndex],
        backgroundColor: AppColors.scaffoldColor(context),
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(
              vertical: displayWidth * 0.044, horizontal: displayWidth * 0.04),
          height: displayWidth * .15,
          decoration: BoxDecoration(
              color: isLightTheme
                  ? AppColors.appBarLightGreyThemeColor
                  : AppColors.whiteThemeColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.1),
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
                                    ? isLightTheme
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
                            Row(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  width: index == currentIndex
                                      ? displayWidth * .03
                                      : 20,
                                ),
                                Icon(
                                  listOfIcons[index],
                                  size: displayWidth * .076,
                                  color: index == currentIndex
                                      ? AppColors.greenThemeColor
                                      : AppColors.blackThemeColor,
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
