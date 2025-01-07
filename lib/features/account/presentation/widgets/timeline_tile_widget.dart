import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:wulflex/core/config/app_colors.dart';

class TimelineTileWidget extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final bool isCancelled;
  final Widget endChild;
  const TimelineTileWidget(
      {super.key,
      required this.isFirst,
      required this.isLast,
      required this.isPast,
      required this.endChild,
      required this.isCancelled});

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
            color: isCancelled
                ? AppColors.redThemeColor
                : isPast
                    ? AppColors.greenThemeColor
                    : AppColors.appBarLightGreyThemeColor,
            iconStyle: IconStyle(
                iconData: Icons.done, color: AppColors.whiteThemeColor)),
        endChild: FadeInLeft(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: endChild,
          ),
        ),
      ),
    );
  }
}
