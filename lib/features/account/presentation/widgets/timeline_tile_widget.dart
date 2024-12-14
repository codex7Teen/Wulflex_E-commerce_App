import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:wulflex/core/config/app_colors.dart';

class TimelineTileWidget extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final Widget endChild;
  const TimelineTileWidget(
      {super.key,
      required this.isFirst,
      required this.isLast,
      required this.isPast,
      required this.endChild});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Gap between the events
      height: 55,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        // decorate the lines
        beforeLineStyle: LineStyle(
            thickness: 2,
            color: isPast
                ? AppColors.greenThemeColor
                : AppColors.appBarLightGreyThemeColor),
        indicatorStyle: IndicatorStyle(
            width: 18,
            color: isPast
                ? AppColors.greenThemeColor
                : AppColors.appBarLightGreyThemeColor,
            iconStyle: IconStyle(
                iconData: Icons.done, color: AppColors.whiteThemeColor)),
        endChild: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: endChild,
        ),
      ),
    );
  }
}
