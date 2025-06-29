import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shoppywell/src/comman/themes.dart';
import 'package:shoppywell/src/presentation/bloc/cart/cart_bloc.dart';
import 'package:shoppywell/src/presentation/bloc/home/home_bloc.dart';
import 'package:shoppywell/src/presentation/bloc/product/product_bloc.dart';
import 'package:shoppywell/src/presentation/bloc/product_detail/product_detail_bloc.dart';
import 'package:shoppywell/src/presentation/bloc/sign_in_form/sign_in_form_bloc.dart';
import 'package:shoppywell/src/presentation/bloc/wishlist/wishlist_bloc.dart';
import 'package:shoppywell/src/presentation/cubit/theme/theme_cubit.dart';
import 'package:shoppywell/src/utilities/app_bloc_observer.dart';
import 'package:shoppywell/src/utilities/fire_store_quaries.dart';
import 'package:shoppywell/src/utilities/go_router_init.dart';
import 'package:shoppywell/src/utilities/logger.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:shoppywell/firebase_options.dart';

void main() {
  logger.runLogging(
    () => runZonedGuarded(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        await Firebase.initializeApp(
           options: DefaultFirebaseOptions.currentPlatform,
        );
        Bloc.transformer = bloc_concurrency.sequential();

        Bloc.observer = const AppBlocObserver();
        // Set Stripe publishable key
        Stripe.publishableKey =
            'pk_test_51RAY7NQ2cdAtXmD9knDmqh2VR8STpisZDtXMQl0UDmurWsX9dZ9Fes1g7dKp1zOES1ugFTTiVWf7gW70xsmkBKjF0021L1xXk7';
        await Stripe.instance.applySettings();

        dotenv.load(fileName: "assets/.env");
  // Create sample users for testing
    final userService = UserService();

       await userService.createSampleUsers();
  
        runApp(const MyApp());
      },
      logger.logZoneError,
    ),
    const LogOptions(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => AuthBloc()),
        BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
        BlocProvider<ProductBloc>(create: (_) => ProductBloc()),
        BlocProvider<ProductDetailBloc>(create: (_) => ProductDetailBloc()),
        BlocProvider<CartBloc>(create: (_) => CartBloc()),
        BlocProvider<WishlistBloc>(create: (_) => WishlistBloc()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'ShoppyWell',
        theme: themeLight(context),
        darkTheme: themeDark(context),
        themeMode: ThemeMode.system,
        routerConfig: routerinit,
      ),
    );
  }
}
