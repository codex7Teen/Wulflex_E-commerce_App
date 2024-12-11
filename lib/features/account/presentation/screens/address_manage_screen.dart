import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/features/account/presentation/widgets/address_manage_screen_widgets.dart';
import 'package:wulflex/features/cart/bloc/address_bloc/address_bloc.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/shared/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class ScreenManageAddress extends StatelessWidget {
  const ScreenManageAddress({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AddressBloc>().add(FetchAddressEvent());
    return Scaffold(
      backgroundColor: isLightTheme(context)
          ? AppColors.whiteThemeColor
          : AppColors.blackThemeColor,
      appBar: customAppbarWithBackbutton(context, 'ADDRESS'),
      body: Padding(
        padding: const EdgeInsets.only(top: 14, left: 18, right: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildaddNewAddressButton(context),
            SizedBox(height: 20),
            buildManageAddressText(context),
            SizedBox(height: 10),
            BlocBuilder<AddressBloc, AddressState>(
              builder: (context, state) {
                if (state is AddressLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is AddressLoaded) {
                  final addressList = state.address;
                  // Show addresses only if addlist is not empty and show a lottie while empty
                  if (addressList.isNotEmpty) {
                    return buildAddressCard(addressList);
                  } else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 90),
                          isLightTheme(context)
                              ? Lottie.asset(
                                  'assets/lottie/empty_address_black.json',
                                  width: 190,
                                  repeat: true)
                              : Lottie.asset(
                                  'assets/lottie/empty_address_white.json',
                                  width: 190,
                                  repeat: true),
                          Text(
                            'Save your address for a better shopping\nexperience!',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.emptyScreenText(context),
                          ),
                          SizedBox(height: 90)
                        ],
                      ),
                    );
                  }
                }
                return Center(child: Text('Something went wrong'));
              },
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
