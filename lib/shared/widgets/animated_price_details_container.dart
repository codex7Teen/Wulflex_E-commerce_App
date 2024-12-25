import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/data/models/product_model.dart';

class AnimatedPriceContainer extends StatefulWidget {
  final ProductModel product;

  const AnimatedPriceContainer({
    super.key,
    required this.product,
  });

  @override
  State<AnimatedPriceContainer> createState() => _AnimatedPriceContainerState();
}

class _AnimatedPriceContainerState extends State<AnimatedPriceContainer>
    with TickerProviderStateMixin {
  late AnimationController _priceController;
  late AnimationController _scaleController;
  late Animation<double> _priceAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  final NumberFormat _numberFormat = NumberFormat("#,##0");

  @override
  void initState() {
    super.initState();

    // Setup price animation controller
    _priceController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Setup scale animation controller
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Price transition animation
    _priceAnimation = Tween<double>(
      begin: widget.product.retailPrice,
      end: widget.product.offerPrice,
    ).animate(CurvedAnimation(
      parent: _priceController,
      curve: Curves.easeOutCubic,
    ));

    // Scale animation for the "bang" effect
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.15),
        weight: 30.0,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.15, end: 1.0),
        weight: 70.0,
      ),
    ]).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeInOut,
    ));

    // Opacity animation
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _priceController,
      curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
    ));

    // Start animations
    Future.delayed(const Duration(milliseconds: 300), () async {
      await _priceController.forward();
      _scaleController.forward();
    });
  }

  @override
  void dispose() {
    _priceController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final discountPercentage =
        ((widget.product.retailPrice - widget.product.offerPrice) /
                widget.product.retailPrice) *
            100;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isLightTheme
            ? AppColors.lightGreyThemeColor
            : AppColors.whiteThemeColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Offer Price Section
          AnimatedBuilder(
            animation: Listenable.merge([_priceController, _scaleController]),
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Text(
                  "₹ ${_numberFormat.format(_priceAnimation.value)}",
                  style: AppTextStyles.offerPriceHeadingText.copyWith(
                    color: _priceController.value > 0.8
                        ? AppColors.blueThemeColor
                        : AppColors.blackThemeColor,
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 8), // Spacer between offer and retail prices
          // Retail Price Section
          FadeTransition(
            opacity: _opacityAnimation,
            child: Text(
              "₹ ${_numberFormat.format(widget.product.retailPrice)}",
              style: AppTextStyles.originalPriceText.copyWith(
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ),
          // Discount Percentage
          Spacer(),
          FadeTransition(
            opacity: _opacityAnimation,
            child: Text(
              "${discountPercentage.toStringAsFixed(0)}% OFF",
              style: AppTextStyles.offerPercentageText,
            ),
          ),
          const SizedBox(width: 18),
          // Info Icon
          const Icon(
            Icons.info,
            color: AppColors.darkishGrey,
          ),
        ],
      ),
    );
  }
}
