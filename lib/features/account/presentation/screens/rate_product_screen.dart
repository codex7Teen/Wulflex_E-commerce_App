import 'package:flutter/material.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/shared/widgets/custom_appbar_with_backbutton.dart';

class ScreenRateProduct extends StatelessWidget {
  const ScreenRateProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbarWithBackbutton(context, "FEEDBACK", 0.16),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        child: Column(
          children: [
            Text(
              'RATE THE PRODUCT',
              style: AppTextStyles.screenSubHeadings(context),
            ),
          ],
        ),
      ),
    );
  }
}
