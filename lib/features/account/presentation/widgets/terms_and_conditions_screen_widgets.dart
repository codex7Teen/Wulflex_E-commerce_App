import 'package:flutter/material.dart';

class TermsAndConditionsScreenWidgets {
  static PreferredSizeWidget buildAppbar() {
    return AppBar(
      centerTitle: true,
      title: const Text('Terms and Conditions'),
    );
  }

  static Widget buildTermsAndConditionsContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome to Wulflex!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'By using the Wulflex app, you agree to the following terms and conditions. Please read them carefully.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          _buildSectionTitle('1. User Accounts'),
          const Text(
            '- Users can log in using email and password or Google login.\n'
            '- Personal data such as your name and profile image will be collected for account management purposes.\n'
            '- Users can add, edit, and delete their addresses in the address section.',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 20),
          _buildSectionTitle('2. Orders and Payments'),
          const Text(
            '- Payments can be made using Razorpay.\n'
            '- Users will be notified of order updates via push notifications using FCM.\n'
            '- Once an ordered item is delivered, it cannot be replaced or returned.',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 20),
          _buildSectionTitle('3. Favorites, Cart, and Orders'),
          const Text(
            '- Users can favorite items, add items to their cart, and place orders.\n'
            '- Users can order an unlimited quantity of items.',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 20),
          _buildSectionTitle('4. Customer Support'),
          const Text(
            '- Users can chat with admin using the customer support feature for queries or assistance.',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 20),
          _buildSectionTitle('5. Account Deletion'),
          const Text(
            '- Users have the option to delete their account if they wish to stop using the app.',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 20),
          _buildSectionTitle('6. Themes'),
          const Text(
            '- The app supports both dark and light themes, which can be toggled in the settings.',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 20),
          _buildSectionTitle('7. Notification Settings'),
          const Text(
            '- Users can turn notifications on or off in the settings section.\n'
            '- Notifications include updates on orders, promotions, and other app-related alerts.',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 20),
          _buildSectionTitle('8. No Network Indication'),
          const Text(
            '- The app includes a no-network indication feature to alert users when their internet connection is unavailable.',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 20),
          _buildSectionTitle('9. Limitation of Liability'),
          const Text(
            '- Wulflex is not responsible for any misuse of purchased items or injuries caused by them.\n'
            '- Ensure proper usage and consult professionals where necessary.',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 20),
          const Text(
            'By continuing to use the Wulflex app, you agree to abide by these terms and conditions. Thank you for choosing Wulflex!',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('I Agree'),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}
