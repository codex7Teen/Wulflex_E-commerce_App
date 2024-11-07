import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wulflex/screens/main_screens/account_screens/sign_out_screen.dart';
import 'package:wulflex/screens/main_screens/cart_screens.dart/cart_screen.dart';
import 'package:wulflex/screens/main_screens/favorites_screens/favorite_screen.dart';
import 'package:wulflex/screens/main_screens/home_screens/home_screen.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';

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
    ScreenSignOut()
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
    double displayWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: screens[currentIndex],
      backgroundColor: AppColors.whiteThemeColor,
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(
            vertical: displayWidth * 0.044, horizontal: displayWidth * 0.04),
        height: displayWidth * .15,
        decoration: BoxDecoration(
            color: AppColors.lightGreyThemeColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  blurRadius: 30,
                  offset: Offset(0, 10))
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
                        duration: Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                        width: index == currentIndex
                            ? displayWidth * .32
                            : displayWidth * .18,
                        alignment: Alignment.center,
                        child: AnimatedContainer(
                          duration: Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          height:
                              index == currentIndex ? displayWidth * .12 : 0,
                          width: index == currentIndex ? displayWidth * .32 : 0,
                          decoration: BoxDecoration(
                              color: index == currentIndex
                                  ? AppColors.whiteThemeColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(50)),
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                        width: index == currentIndex
                            ? displayWidth * .31
                            : displayWidth * .18,
                        alignment: Alignment.center,
                        child: Stack(children: [
                          Row(
                            children: [
                              AnimatedContainer(
                                duration: Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                width: index == currentIndex
                                    ? displayWidth * .13
                                    : 0,
                              ),
                              AnimatedOpacity(
                                opacity: index == currentIndex ? 1 : 0,
                                duration: Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                child: Text(
                                    index == currentIndex
                                        ? listOfStrings[index]
                                        : '',
                                    style: AppTextStyles.bottomNavigationBarText),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              AnimatedContainer(
                                duration: Duration(seconds: 1),
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
    );
  }
}
