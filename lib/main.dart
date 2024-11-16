import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/blocs/authentication_bloc/authenticaton_bloc_bloc.dart';
import 'package:wulflex/blocs/delete_account_bloc/delete_account_bloc.dart';
import 'package:wulflex/blocs/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:wulflex/blocs/theme_bloc/theme_bloc.dart';
import 'package:wulflex/services/authentication/login_authorization.dart';
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

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticatonBlocBloc>(
            create: (context) => AuthenticatonBlocBloc(authService: auth)),
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(create: (context) => EditProfileBloc()),
        BlocProvider(create: (context) => DeleteAccountBloc(authService: auth)),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: 'Wulflex Shopping',
            debugShowCheckedModeBanner: false,
            theme: themeState.themeData,
            home: const MainWrapperWidget(),
          );
        },
      ),
    );
  }
}
