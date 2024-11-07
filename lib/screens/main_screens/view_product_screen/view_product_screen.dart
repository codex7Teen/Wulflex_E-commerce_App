import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wulflex/screens/main_screens/view_product_screen/widgets/view_product_widgets.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';

class ScreenViewProducts extends StatelessWidget {
  const ScreenViewProducts({super.key});

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();

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
            buildPageIndicator(pageController),
            SizedBox(height: 20),
            Container(
              height: MediaQuery.sizeOf(context).height,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  color: AppColors.whiteThemeColor),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text('LOREM IPSUM SYNTHESIS, BLACK',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.viewProductMainHeading),
                    SizedBox(height: 14),
                    Container(
                      width: 198,
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 9),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.lightGreyThemeColor),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.star_rate,
                              color: AppColors.greenThemeColor, size: 20),
                          Icon(Icons.star_rate,
                              color: AppColors.greenThemeColor, size: 20),
                          Icon(Icons.star_rate,
                              color: AppColors.greenThemeColor, size: 20),
                          Icon(Icons.star_rate,
                              color: AppColors.greenThemeColor, size: 20),
                          Icon(Icons.star_rate,
                              color: AppColors.lightGreyThemeColor, size: 20),
                          SizedBox(width: 8),
                          Text(
                            '4.0 Ratings',
                            style: AppTextStyles.viewProductratingsText,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'SIZE',
                      style: GoogleFonts.robotoCondensed(),
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
