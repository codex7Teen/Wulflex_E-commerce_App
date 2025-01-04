import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            //! ADD NEW ADDRESS BUTTON
            AddressManageScreenWidgets.buildaddNewAddressButton(context),
            const SizedBox(height: 20),
            //! MANADE ADDRESS TEXT HEADING
            AddressManageScreenWidgets.buildManageAddressText(context),
            const SizedBox(height: 10),
            BlocBuilder<AddressBloc, AddressState>(
              builder: (context, state) {
                if (state is AddressLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AddressLoaded) {
                  final addressList = state.address;
                  // Show addresses only if addlist is not empty and show a lottie while empty
                  if (addressList.isNotEmpty) {
                    //! ADDRESS CARDS
                    return AddressManageScreenWidgets.buildAddressCard(
                        addressList);
                  } else {
                    //! EMPTY ADDRESS DISPLAY
                    return AddressManageScreenWidgets.buildEmptyAddressDisplay(
                        context);
                  }
                }
                //! UNKNOWN ERROR
                return const Center(child: Text('Something went wrong'));
              },
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
