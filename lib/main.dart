import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/core/config/app_constants.dart';
import 'package:wulflex/data/services/notification_services.dart';
import 'package:wulflex/core/theme/bloc/theme_bloc/theme_bloc.dart';
import 'package:wulflex/features/auth/presentation/widgets/main_wrapper_widget.dart';

void main() async {
  // Ensures the bindings with native platform has done properly
  WidgetsFlutterBinding.ensureInitialized();

  // Lock orientation to portrait only
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // Initialize firebase
  if (kIsWeb) {
    await Firebase.initializeApp(options: FirebaseConfig.firebaseOptions);
  } else {
    await Firebase.initializeApp();
  }

  // Request notification permission
  await NotificationServices().requestPermission();
  await NotificationServices().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      //! BLOC PROVIDERS
      providers: AppBlocProviders.providers,
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
