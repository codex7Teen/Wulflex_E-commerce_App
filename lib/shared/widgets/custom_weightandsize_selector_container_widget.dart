import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wulflex/core/config/app_colors.dart';

class CustomWeightandsizeSelectorContainerWidget extends StatefulWidget {
  final String weightOrSize;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomWeightandsizeSelectorContainerWidget({
    super.key,
    required this.weightOrSize,
    required this.isSelected,
    required this.onTap,
  });

  @override
  CustomWeightandsizeSelectorContainerWidgetState createState() =>
      CustomWeightandsizeSelectorContainerWidgetState();
}

class CustomWeightandsizeSelectorContainerWidgetState
    extends State<CustomWeightandsizeSelectorContainerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200), // Increased duration
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 0.9).animate(_controller); // More pronounced scale
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onContainerTapped() {
    _controller.forward().then((_) {
      _controller.reverse();
    });
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    return ScaleTransition(
      scale: _animation,
      child: GestureDetector(
        onTap: _onContainerTapped,
        child: Container(
          width: 58,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: widget.isSelected
                ? AppColors.greenThemeColor
                : isLightTheme ? AppColors.lightGreyThemeColor : AppColors.whiteThemeColor,
          ),
          child: Center(
            child: Text(
              widget.weightOrSize,
              style: GoogleFonts.robotoCondensed(
      fontSize: 14,
      color: Colors.black,
      letterSpacing: 0.4,
      fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}
