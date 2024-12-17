import 'package:flutter/material.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/shared/widgets/custom_appbar_with_backbutton.dart';

class ScreenSizeChart extends StatelessWidget {
  const ScreenSizeChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbarWithBackbutton(context, 'SIZE CHART', 0.14),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text("FIND YOUR PERFECT FIT",
                  style: AppTextStyles.screenSubTitles.copyWith(fontSize: 17)),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSizeChartTable(context, 'Footwear', [
                      ['Size', 'S', 'M', 'L', 'XL'],
                      ['US', '6-7', '8-9', '10-11', '12-13'],
                      ['UK', '5-6', '7-8', '9-10', '11-12'],
                      ['EU', '39-40', '41-42', '43-44', '45-46'],
                    ]),
                    SizedBox(height: 30),
                    _buildSizeChartTable(context, 'Apparel', [
                      ['Size', 'S', 'M', 'L', 'XL'],
                      ['Chest (in)', '36-38', '39-41', '42-44', '45-47'],
                      ['Waist (in)', '28-30', '31-33', '34-36', '37-39'],
                    ]),
                    SizedBox(height: 20),
                    Divider(color: AppColors.greenThemeColor),
                    Center(
                      child: Text(
                        "Measure before you buy!",
                        style: AppTextStyles.readmoreAndreadLessText(context)
                            .copyWith(color: AppColors.greenThemeColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSizeChartTable(
      BuildContext context, String title, List<List<String>> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.viewProductTitleText(context)),
        SizedBox(height: 10),
        Table(
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(2),
            3: FlexColumnWidth(2),
            4: FlexColumnWidth(2),
          },
          border: TableBorder.all(color: Colors.grey.shade300, width: 1),
          children: data.map((row) {
            return TableRow(
              decoration: BoxDecoration(
                  color: row[0] == 'Size' ? Colors.grey.shade200 : null),
              children: row.map((cell) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    cell,
                    textAlign: TextAlign.center,
                    style: row[0] == 'Size'
                        ? AppTextStyles.viewProductTitleText(context)
                        : AppTextStyles.descriptionText(context),
                  ),
                );
              }).toList(),
            );
          }).toList(),
        ),
      ],
    );
  }
}
