import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wulflex/screens/main_screens/view_product_screen/widgets/view_product_widgets.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';

class ScreenViewProducts extends StatefulWidget {
  const ScreenViewProducts({super.key});

  @override
  State<ScreenViewProducts> createState() => _ScreenViewProductsState();
}

class _ScreenViewProductsState extends State<ScreenViewProducts> {
  // Track selected weights
  Set<String> selectedWeights = {};

  void updateSelectedWeights(String weight) {
    setState(() {
      if (selectedWeights.contains(weight)) {
        selectedWeights.remove(weight);
      } else {
        selectedWeights.add(weight);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();

    final isLightTheme = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      backgroundColor: AppColors.lightGreyThemeColor,
      //! A P P - B A R
      appBar: buildAppBarWithIcons(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //! ITEM IMAGE WITH SLIDER (PAGEVIEW)
            buildItemImageSlider(context, pageController),
            SizedBox(height: 4),
            buildPageIndicator(pageController, context),
            SizedBox(height: 20),
            Container(
              height: MediaQuery.sizeOf(context).height,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  color: isLightTheme
                      ? AppColors.whiteThemeColor
                      : AppColors.blackThemeColor),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    buildProductHeadingText(context),
                    SizedBox(height: 14),
                    buildRatingsContainer(),
                    SizedBox(height: 20),
                    buildSizeAndSizeChartText(),
                    SizedBox(height: 8),
                    buildWeightAndSizeSelectors(
                        selectedWeights,
                        () => updateSelectedWeights('S'),
                        () => updateSelectedWeights('M'),
                        () => updateSelectedWeights('L')),
                    SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: isLightTheme ? AppColors.lightGreyThemeColor : AppColors.whiteThemeColor),
                      child: Row(
                        children: [
                          Text(
                            "₹ 1099.00",
                            style: AppTextStyles.offerPriceHeadingText,
                          ),
                          SizedBox(width: 14),
                          Text(
                            "₹ 3499.00",
                            style: GoogleFonts.bebasNeue(
                                fontSize: 16,
                                color: AppColors.darkishGrey,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: isLightTheme
                                    ? AppColors.darkishGrey
                                    : AppColors.darkishGrey,
                                decorationThickness: 1),
                          ),
                          SizedBox(width: 16),
                          Text(
                            "46% OFF",
                            style: GoogleFonts.bebasNeue(
                              fontSize: 18,
                              color: AppColors.greenThemeColor,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 16),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
