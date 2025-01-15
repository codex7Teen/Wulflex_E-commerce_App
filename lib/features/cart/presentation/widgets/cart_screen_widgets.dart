import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/core/network/internet_connection_wrapper.dart';
import 'package:wulflex/data/models/product_model.dart';
import 'package:wulflex/features/cart/presentation/screens/order_summary_screen.dart';
import 'package:wulflex/shared/widgets/custom_cart_card_widget.dart';
import 'package:wulflex/shared/widgets/custom_green_button_widget.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class CartWidgets {
  static PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text('CART', style: AppTextStyles.appbarTextBig(context)),
    );
  }

  static Widget buildCartItemsCard(List<ProductModel> cartItems) {
    return Padding(
      padding: const EdgeInsets.only(top: 14, left: 18, right: 18),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final product = cartItems[index];
                return buildCustomCartCard(context, product);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 15);
              },
            ),
          ),
          const SizedBox(
            height: 245,
            width: double.infinity,
          ),
        ],
      ),
    );
  }

  static Widget buildCartEmptyDisplay(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isLightTheme(context)
              ? Lottie.asset('assets/lottie/cart_empty_lottie_black.json',
                  width: 190, repeat: false)
              : Lottie.asset('assets/lottie/cart_empty_lottie_white.json',
                  width: 190, repeat: false),
          Text(
            'Your cart is empty.\nStart adding your items!',
            textAlign: TextAlign.center,
            style: AppTextStyles.emptyScreenText(context),
          ),
          const SizedBox(height: 90)
        ],
      ),
    );
  }
}

class AnimatedCartItemsPriceDetailsContainer extends StatefulWidget {
  final double subtotal;
  final double discount;
  final double total;

  const AnimatedCartItemsPriceDetailsContainer({
    super.key,
    required this.subtotal,
    required this.discount,
    required this.total,
  });

  @override
  State<AnimatedCartItemsPriceDetailsContainer> createState() =>
      _AnimatedCartItemsPriceDetailsContainerState();
}

class _AnimatedCartItemsPriceDetailsContainerState
    extends State<AnimatedCartItemsPriceDetailsContainer>
    with TickerProviderStateMixin {
  late AnimationController _priceController;
  late AnimationController _scaleController;
  late Animation<double> _totalAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> opacityAnimation;

  double _previousTotal = 0.0;
  final NumberFormat _numberFormat = NumberFormat('#,##,###.##');

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _previousTotal = widget.total;
  }

  void _initializeAnimations() {
    _priceController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _updateTotalAnimation();

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

    opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _priceController,
      curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
    ));

    // Start initial animations
    Future.delayed(const Duration(milliseconds: 300), () {
      _priceController.forward();
      _scaleController.forward();
    });
  }

  void _updateTotalAnimation() {
    _totalAnimation = Tween<double>(
      begin: _previousTotal,
      end: widget.total,
    ).animate(CurvedAnimation(
      parent: _priceController,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void didUpdateWidget(AnimatedCartItemsPriceDetailsContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.total != widget.total) {
      _previousTotal = oldWidget.total;
      _updateTotalAnimation();
      _priceController.reset();
      _scaleController.reset();
      _priceController.forward();
      _scaleController.forward();
    }
  }

  @override
  void dispose() {
    _priceController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 239,
        decoration: const BoxDecoration(
          color: AppColors.lightGreyThemeColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'PRICE DETAILS',
                    style: AppTextStyles.screenSubHeadings(context,
                        fixedBlackColor: true),
                  ),
                  const SizedBox(width: 6),
                  const Column(
                    children: [
                      Icon(Icons.wallet,
                          color: AppColors.blackThemeColor, size: 22),
                      SizedBox(height: 2.5)
                    ],
                  )
                ],
              ),
              const SizedBox(height: 5),
              // Subtotal Row
              AnimatedBuilder(
                animation:
                    Listenable.merge([_priceController, _scaleController]),
                builder: (context, child) {
                  return Row(
                    children: [
                      Text(
                        'Subtotal',
                        style: AppTextStyles.cartSubtotalAndDiscountText,
                      ),
                      const Spacer(),
                      Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Text(
                          '₹ ${_numberFormat.format(widget.subtotal)}',
                          style:
                              AppTextStyles.cartSubtotalAndDiscountAmountStyle,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 5),
              // Discount Row
              AnimatedBuilder(
                animation:
                    Listenable.merge([_priceController, _scaleController]),
                builder: (context, child) {
                  return Row(
                    children: [
                      Text(
                        'Discount',
                        style: AppTextStyles.cartSubtotalAndDiscountText,
                      ),
                      const Spacer(),
                      Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Text(
                          '₹ –${_numberFormat.format(widget.discount)}',
                          style:
                              AppTextStyles.cartSubtotalAndDiscountAmountStyle,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 5),
              const Divider(
                color: AppColors.hardLightGeryThemeColor,
                thickness: 0.3,
              ),
              const SizedBox(height: 5),
              // Total Row
              AnimatedBuilder(
                animation:
                    Listenable.merge([_priceController, _scaleController]),
                builder: (context, child) {
                  return Row(
                    children: [
                      Text(
                        'Total Amount',
                        style: AppTextStyles.cartTotalText,
                      ),
                      const Spacer(),
                      Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Text(
                          '₹ ${_numberFormat.format(_totalAnimation.value)}',
                          style: AppTextStyles.cartTotalAmountText.copyWith(
                            color: _priceController.value > 0.8
                                ? AppColors.blueThemeColor
                                : AppColors.blackThemeColor,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 10),
              GreenButtonWidget(
                onTap: () {
                  NavigationHelper.navigateToWithoutReplacement(
                    context,
                    const InternetConnectionWrapper(
                        child: ScreenOrderSummary()),
                  );
                },
                addIcon: true,
                icon: Icons.shopping_cart_checkout_rounded,
                buttonText: 'Checkout Securely',
                borderRadius: 25,
                width: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
