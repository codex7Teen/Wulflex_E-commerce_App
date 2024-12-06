import 'package:flutter/material.dart';
import 'package:wulflex/widgets/custom_appbar_with_backbutton.dart';

class ScreenOrderSummary extends StatelessWidget {
  const ScreenOrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbarWithBackbutton(context, 'ORDER SUMMARY', 0.06),
    );
  }
}
