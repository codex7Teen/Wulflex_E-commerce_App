import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/core/config/app_constants.dart';
import 'package:wulflex/data/services/chat_services.dart';
import 'package:wulflex/data/services/order_services.dart';
import 'package:wulflex/data/services/review_services.dart';
import 'package:wulflex/features/account/bloc/chat_bloc/chat_bloc.dart';
import 'package:wulflex/features/account/bloc/review_bloc/review_bloc.dart';
import 'package:wulflex/features/cart/bloc/address_bloc/address_bloc.dart';
import 'package:wulflex/features/auth/bloc/authentication_bloc/authenticaton_bloc_bloc.dart';
import 'package:wulflex/features/cart/bloc/cart_bloc/cart_bloc.dart';
import 'package:wulflex/features/cart/bloc/order_bloc/order_bloc.dart';
import 'package:wulflex/features/cart/bloc/payment_bloc/payment_bloc.dart';
import 'package:wulflex/features/home/bloc/category_bloc/category_bloc.dart';
import 'package:wulflex/features/account/bloc/delete_account_bloc/delete_account_bloc.dart';
import 'package:wulflex/features/favorite/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:wulflex/features/home/bloc/product_bloc/product_bloc.dart';
import 'package:wulflex/core/theme/bloc/theme_bloc/theme_bloc.dart';
import 'package:wulflex/features/account/bloc/user_profile_bloc/user_profile_bloc.dart';
import 'package:wulflex/data/services/address_services.dart';
import 'package:wulflex/data/services/authentication/login_authorization.dart';
import 'package:wulflex/features/auth/presentation/widgets/main_wrapper_widget.dart';
import 'package:wulflex/data/services/cart_services.dart';
import 'package:wulflex/data/services/category_services.dart';
import 'package:wulflex/data/services/favorite_services.dart';
import 'package:wulflex/data/services/product_services.dart';
import 'package:wulflex/data/services/user_profile_services.dart';

void main() async {
  // Ensures the bindings with native platform has done properly
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize firebase
  if (kIsWeb) {
    await Firebase.initializeApp(options: FirebaseConfig.firebaseOptions);
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
    final userProfile = UserProfileServices();
    final productServices = ProductServices();
    final favoriteServices = FavoriteServices();
    final categoryServices = CategoryServices();
    final cartServices = CartServices();
    final addressServices = AddressServices();
    final orderServices = OrderServices();
    final reviewServices = ReviewServices();
    final firebaseAuth = FirebaseAuth.instance;
    final chatServices = ChatServices();
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticatonBlocBloc>(
            create: (context) => AuthenticatonBlocBloc(authService: auth)),
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(create: (context) => DeleteAccountBloc(authService: auth)),
        BlocProvider(create: (context) => UserProfileBloc(userProfile)),
        BlocProvider(create: (context) => ProductBloc(productServices)),
        BlocProvider(create: (context) => FavoriteBloc(favoriteServices)),
        BlocProvider(create: (context) => CategoryBloc(categoryServices)),
        BlocProvider(create: (context) => CartBloc(cartServices)),
        BlocProvider(create: (context) => AddressBloc(addressServices)),
        BlocProvider(create: (context) => PaymentBloc()),
        BlocProvider(create: (context) => OrderBloc(orderServices)),
        BlocProvider(
            create: (context) => ReviewBloc(reviewServices, firebaseAuth)),
        BlocProvider(create: (context) => ChatBloc(chatServices)),
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
