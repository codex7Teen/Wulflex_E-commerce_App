import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wulflex/data/services/notification_services.dart';
import 'package:wulflex/features/onboarding/presentation/screens/main_intro_screen.dart';
import 'package:wulflex/core/navigation/bottom_navigation_screen.dart';
import 'package:wulflex/features/onboarding/presentation/screens/splash_screen_1.dart';

class MainWrapperWidget extends StatelessWidget {
  const MainWrapperWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // show circular progress indicator
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // show error
            return Center(child: Text("Error"));
          } else {
            if (snapshot.data == null) {
              // Show splash and navigate to intro screen
              return ScreenSplash1(screen: ScreenMainIntro());
            } else {
              // Upload the FCM token to firebase firestore
              NotificationServices().uploadFcmToken();
              return ScreenSplash1(screen: MainScreen());
            }
          }
        },
      ),
    );
  }
}
