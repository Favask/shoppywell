import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppywell/src/comman/themes.dart';
import 'package:shoppywell/src/presentation/bloc/sign_in_form/sign_in_form_bloc.dart';
import 'package:shoppywell/src/presentation/cubit/theme/theme_cubit.dart';
import 'package:shoppywell/src/utilities/app_bloc_observer.dart';
import 'package:shoppywell/src/utilities/go_router_init.dart';
import 'package:shoppywell/src/utilities/logger.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;


void main() {
  logger.runLogging(
        () => runZonedGuarded(
          () {
        WidgetsFlutterBinding.ensureInitialized();
        Bloc.transformer = bloc_concurrency.sequential();
        Bloc.observer = const AppBlocObserver();

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
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => ThemeCubit()),
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
