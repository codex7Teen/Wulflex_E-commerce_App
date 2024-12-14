import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/data/models/order_model.dart';
import 'package:wulflex/data/models/product_model.dart';
import 'package:wulflex/features/account/bloc/user_profile_bloc/user_profile_bloc.dart';
import 'package:wulflex/shared/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class ScreenOrderDetails extends StatelessWidget {
  final OrderModel order;
  final ProductModel product;
  const ScreenOrderDetails(
      {super.key, required this.order, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isLightTheme(context)
          ? AppColors.whiteThemeColor
          : AppColors.blackThemeColor,
      appBar: customAppbarWithBackbutton(context, 'ORDER DETAILS', 0.09),
      body: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          if (state is UserProfileLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserProfileLoaded) {
            final user = state.user;
            return Padding(
              padding: const EdgeInsets.only(
                  left: 18, right: 18, top: 18, bottom: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order ID - ${order.id.toUpperCase()}",
                    style: AppTextStyles.myOrdersScreenMiniText(context),
                  ),
                  SizedBox(height: 18),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 11, horizontal: 18),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: isLightTheme(context)
                            ? AppColors.lightGreyThemeColor
                            : AppColors.whiteThemeColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'ACCOUNT INFORMATION',
                              style: AppTextStyles.screenSubHeadings(context,
                                  fixedBlackColor: true),
                            ),
                            SizedBox(width: 6),
                            Column(
                              children: [
                                Icon(Icons.person,
                                    color: AppColors.blackThemeColor, size: 22),
                                SizedBox(height: 2)
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 3),
                        Text(
                          user.name,
                          style: AppTextStyles.screenSubTitles,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 18),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 11, horizontal: 18),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: isLightTheme(context)
                            ? AppColors.lightGreyThemeColor
                            : AppColors.whiteThemeColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'PAYMENT METHOD',
                              style: AppTextStyles.screenSubHeadings(context,
                                  fixedBlackColor: true),
                            ),
                            SizedBox(width: 6),
                            Column(
                              children: [
                                Icon(Icons.wallet,
                                    color: AppColors.blackThemeColor, size: 22),
                                SizedBox(height: 2)
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 3),
                        Text(
                          order.paymentMode,
                          style: AppTextStyles.screenSubTitles,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 18),
                  Container(
                    padding: EdgeInsets.all(13),
                    width: MediaQuery.of(context).size.width, // Full width
                    decoration: BoxDecoration(
                      color: AppColors.lightGreyThemeColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        // Product Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.brandName,
                                style: AppTextStyles.itemCardBrandText,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                product.name,
                                style: AppTextStyles.itemCardNameText,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 13),
                              Row(
                                children: [
                                  Text(
                                    "₹${product.retailPrice.round()}",
                                    style: AppTextStyles
                                        .itemCardSecondSubTitleText,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "₹${product.offerPrice.round()}",
                                    style: AppTextStyles.itemCardSubTitleText,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 14),
                        // Product Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            height: 84, // Fixed height
                            width: MediaQuery.of(context).size.width * 0.21,
                            child: Image.network(
                              product.imageUrls[0],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset('assets/wulflex_logo_nobg.png'),
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: SizedBox(
                                    width: 26,
                                    height: 26,
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                      'ORDER STATUS',
                      style: AppTextStyles.screenSubHeadings(context),
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(child: Text('Something went wrong'));
        },
      ),
    );
  }
}
