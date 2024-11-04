import 'package:flutter/material.dart';
import 'package:wulflex/screens/main_screens/home_screens/widgets/home_widgets.dart';
import 'package:wulflex/utils/consts/app_colors.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.lightScaffoldColor,
          body: Padding(
            padding: const EdgeInsets.only(top: 14, left: 18, right: 18),
            child: Column(
              children: [
                //! TOP => EXPLORE & PERSON LOGO SECTION
                buildExploreTextAndLogo(),
              ],
            ),
          )),
    );
  }
}
