import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/blocs/authentication_bloc/authenticaton_bloc_bloc.dart';
import 'package:wulflex/services/authentication/login_authorization.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/screens/aunthentication_screens/main_wrapper_widget.dart';

void main() async {
  // Ensures the bindings with native platform has done properly
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize firebase
  if (kIsWeb) {
    Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDMzuQfFMY4pScI7ihyfVFV5fsT0pcsATI",
            authDomain: "wulflex.firebaseapp.com",
            projectId: "wulflex",
            storageBucket: "wulflex.appspot.com",
            messagingSenderId: "57079492115",
            appId: "1:57079492115:web:4366c95936974dda3fd9e6"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Instance for authorisation services
    final auth = AuthService();
    return MultiBlocProvider(
      providers: [
        // Authentication Bloc
        BlocProvider<AuthenticatonBlocBloc>(
            create: (context) => AuthenticatonBlocBloc(authService: auth))
        // Next Bloc
      ],
      child: MaterialApp(
          title: 'Wulflex Shopping',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: AppColors.greenThemeColor
            )
          ),
          home: const MainWrapperWidget()),
    );
  }
}
