import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyScreenWidgets {
  static PreferredSizeWidget buildAppbar() {
    return AppBar(
      title: const Text('Privacy Policy'),
      centerTitle: true,
      backgroundColor: Colors.transparent,
    );
  }

  static Widget buildPrivacyPolicyContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Privacy Policy for Wulflex',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text(
          'Effective Date: January 2, 2025',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 20),
        _buildSectionTitle('1. Information We Collect'),
        const Text(
          'When you use Wulflex, we collect the following information:\n'
          '- Personal Information: Name, email address, and profile image.\n'
          '- Address: Collected when you add an address in the Address Section.\n'
          '- Payment Information: Razorpay is used for payments. We do not store your card or banking details.\n'
          '- Communication: Chat messages sent to the admin.\n'
          '- Notifications: Order updates sent via FCM.',
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 20),
        _buildSectionTitle('2. How We Use Your Information'),
        const Text(
          '- To provide and improve our services.\n'
          '- To process payments securely through Razorpay.\n'
          '- To notify you of order updates.\n'
          '- To enable communication with the admin via chat.',
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 20),
        _buildSectionTitle('3. Data Security'),
        const Text(
          'We take appropriate measures to secure your personal information. Payment processing is handled by Razorpay, ensuring the highest level of security.',
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 20),
        _buildSectionTitle('4. Third-Party Services'),
        const Text(
          'We may use third-party services like Razorpay for payments and Firebase Cloud Messaging (FCM) for notifications. These services have their own privacy policies.',
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 20),
        _buildSectionTitle('5. Your Rights'),
        const Text(
          'You have the right to access, update, or delete your information. Please contact us at djconnect189@gmail.com for assistance.',
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 20),
        _buildSectionTitle('6. Changes to this Privacy Policy'),
        const Text(
          'We may update this Privacy Policy from time to time. Please review it periodically for changes.',
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 20),
        _buildSectionTitle('Contact Us'),
        const Text(
          'If you have any questions about this Privacy Policy, please contact us at:',
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: () async {
            final Uri emailLaunchUri = Uri(
              scheme: 'mailto',
              path: 'djconnect189@gmail.com',
            );
            if (await canLaunchUrl(emailLaunchUri)) {
              await launchUrl(emailLaunchUri);
            } else {
              throw Exception('Could not launch $emailLaunchUri');
            }
          },
          child: const Text(
            'djconnect189@gmail.com',
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}
