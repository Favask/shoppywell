import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shoppywell/src/common/themes.dart';
import 'package:shoppywell/src/presentation/bloc/cart/cart_bloc.dart';
import 'package:shoppywell/src/presentation/bloc/home/home_bloc.dart';
import 'package:shoppywell/src/presentation/bloc/product_detail/product_detail_bloc.dart';
import 'package:shoppywell/src/presentation/bloc/sign_in_form/sign_in_form_bloc.dart';
import 'package:shoppywell/src/presentation/cubit/theme/theme_cubit.dart';
import 'package:shoppywell/src/utilities/app_bloc_observer.dart';
import 'package:shoppywell/src/utilities/go_router_init.dart';
import 'package:shoppywell/src/utilities/logger.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:shoppywell/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.transformer = bloc_concurrency.sequential();

  Bloc.observer = const AppBlocObserver();
  // Set Stripe publishable key
  Stripe.publishableKey =
      '';
  await Stripe.instance.applySettings();

  dotenv.load(fileName: "assets/.env");

  /* Create sample users for testing
       final userService = UserService();
       await userService.createSampleUsers(); */

  runApp(const MyApp());

  const LogOptions();
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
        BlocProvider<ProductDetailBloc>(create: (_) => ProductDetailBloc()),
        BlocProvider<CartBloc>(create: (_) => CartBloc()),
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
