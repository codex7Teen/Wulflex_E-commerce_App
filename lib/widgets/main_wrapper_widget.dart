import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wulflex/screens/main_screens/home_screen/home_screen.dart';
import 'package:wulflex/screens/splash_screens/splash_screen_1.dart';

class MainWrapperWidget extends StatelessWidget {
  const MainWrapperWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot) {
         if(snapshot.connectionState == ConnectionState.waiting) {
          // show circular progress indicator
          return Center(child: CircularProgressIndicator());
         } else if(snapshot.hasError) {
          // show error
          return Center(child: Text("Error"));
         } else {
          // goto screens (success stage)
          if(snapshot.data == null) {
            return ScreenSplash();
          } else {
            return ScreenHome();
          }
         }
      },),
    );
  }
}