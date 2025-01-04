import 'package:flutter/material.dart';
import 'package:wulflex/features/account/presentation/widgets/terms_and_conditions_screen_widgets.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TermsAndConditionsScreenWidgets.buildAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: TermsAndConditionsScreenWidgets.buildTermsAndConditionsContent(
            context),
      ),
    );
  }
}
