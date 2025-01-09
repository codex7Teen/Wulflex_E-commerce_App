import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/core/theme/bloc/theme_bloc/theme_bloc.dart';
import 'package:wulflex/data/services/address_services.dart';
import 'package:wulflex/data/services/authentication/login_authorization.dart';
import 'package:wulflex/data/services/cart_services.dart';
import 'package:wulflex/data/services/category_services.dart';
import 'package:wulflex/data/services/chat_services.dart';
import 'package:wulflex/data/services/favorite_services.dart';
import 'package:wulflex/data/services/notification_services.dart';
import 'package:wulflex/data/services/order_services.dart';
import 'package:wulflex/data/services/product_services.dart';
import 'package:wulflex/data/services/review_services.dart';
import 'package:wulflex/data/services/user_profile_services.dart';
import 'package:wulflex/features/account/bloc/chat_bloc/chat_bloc.dart';
import 'package:wulflex/features/account/bloc/delete_account_bloc/delete_account_bloc.dart';
import 'package:wulflex/features/account/bloc/notification_bloc/notification_bloc_bloc.dart';
import 'package:wulflex/features/account/bloc/relogin_bloc/relogin_bloc.dart';
import 'package:wulflex/features/account/bloc/review_bloc/review_bloc.dart';
import 'package:wulflex/features/account/bloc/user_profile_bloc/user_profile_bloc.dart';
import 'package:wulflex/features/auth/bloc/authentication_bloc/authenticaton_bloc_bloc.dart';
import 'package:wulflex/features/cart/bloc/address_bloc/address_bloc.dart';
import 'package:wulflex/features/cart/bloc/cart_bloc/cart_bloc.dart';
import 'package:wulflex/features/cart/bloc/order_bloc/order_bloc.dart';
import 'package:wulflex/features/cart/bloc/payment_bloc/payment_bloc.dart';
import 'package:wulflex/features/favorite/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:wulflex/features/home/bloc/category_bloc/category_bloc.dart';
import 'package:wulflex/features/home/bloc/product_bloc/product_bloc.dart';

//! FIREBASE STORAGE BUCKET NAME
const String bucket = 'wulflex.firebasestorage.app';
const String razorpayApiKey = 'rzp_test_jIotm3SaZbXO9x';

//! FIREBASE OPTIONS
class FirebaseConfig {
  static const String bucket = 'wulflex.firebasestorage.app';
  static const String apiKey = "AIzaSyDMzuQfFMY4pScI7ihyfVFV5fsT0pcsATI";
  static const String authDomain = "wulflex.firebaseapp.com";
  static const String projectId = "wulflex";
  static const String storageBucket = "wulflex.appspot.com";
  static const String messagingSenderId = "57079492115";
  static const String appId = "1:57079492115:web:4366c95936974dda3fd9e6";

  static FirebaseOptions get firebaseOptions => const FirebaseOptions(
        apiKey: apiKey,
        authDomain: authDomain,
        projectId: projectId,
        storageBucket: storageBucket,
        messagingSenderId: messagingSenderId,
        appId: appId,
      );
}

//! BLOC PROVIDERS
class AppBlocProviders {
  static List<BlocProvider> providers = [
    // Authentication & User Related
    BlocProvider<AuthenticatonBlocBloc>(
      create: (context) => AuthenticatonBlocBloc(
        authService: AuthService(),
      ),
    ),
    BlocProvider<DeleteAccountBloc>(
      create: (context) => DeleteAccountBloc(
        authService: AuthService(),
      ),
    ),
    BlocProvider<UserProfileBloc>(
      create: (context) => UserProfileBloc(
        UserProfileServices(),
      ),
    ),
    BlocProvider<ReloginBloc>(
      create: (context) => ReloginBloc(
        AuthService(),
      ),
    ),

    // Theme
    BlocProvider<ThemeBloc>(
      create: (context) => ThemeBloc(),
    ),

    // Product & Category Related
    BlocProvider<ProductBloc>(
      create: (context) => ProductBloc(
        ProductServices(),
      ),
    ),
    BlocProvider<CategoryBloc>(
      create: (context) => CategoryBloc(
        CategoryServices(),
      ),
    ),

    // Shopping Related
    BlocProvider<FavoriteBloc>(
      create: (context) => FavoriteBloc(
        FavoriteServices(),
      ),
    ),
    BlocProvider<CartBloc>(
      create: (context) => CartBloc(
        CartServices(),
      ),
    ),
    BlocProvider<OrderBloc>(
      create: (context) => OrderBloc(
        OrderServices(),
      ),
    ),

    // Address & Payment
    BlocProvider<AddressBloc>(
      create: (context) => AddressBloc(
        AddressServices(),
      ),
    ),
    BlocProvider<PaymentBloc>(
      create: (context) => PaymentBloc(),
    ),

    // Reviews & Chat
    BlocProvider<ReviewBloc>(
      create: (context) => ReviewBloc(
        ReviewServices(),
        FirebaseAuth.instance,
      ),
    ),
    BlocProvider<ChatBloc>(
      create: (context) => ChatBloc(
        ChatServices(),
      ),
    ),
    BlocProvider<NotificationBlocBloc>(
      create: (context) => NotificationBlocBloc(NotificationServices()),
    )
  ];
}
