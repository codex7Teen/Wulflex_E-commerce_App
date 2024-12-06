import 'package:flutter/material.dart';
import 'package:wulflex/screens/main_screens/cart_screens.dart/address_screens/add_address_screen.dart';
import 'package:wulflex/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/widgets/custom_green_button_widget.dart';
import 'package:wulflex/widgets/navigation_helper_widget.dart';

class ScreenAddress extends StatelessWidget {
  const ScreenAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbarWithBackbutton(context, 'ADDRESS'),
      body: Padding(
        padding: const EdgeInsets.only(top: 14, left: 18, right: 18),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                NavigationHelper.navigateToWithoutReplacement(
                    context, ScreenAddAddress());
              },
              child: GreenButtonWidget(
                  width: 1,
                  buttonText: 'Add a new address',
                  borderRadius: 25,
                  icon: Icons.add,
                  addIcon: true),
            ),
          ],
        ),
      ),
    );
  }
}
