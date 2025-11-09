import 'package:shoppywell/src/common/routes.dart';
import 'package:shoppywell/src/presentation/page/auth/sign_in_screen.dart';
import 'package:shoppywell/src/presentation/page/auth/sign_up_screen.dart';
import 'package:shoppywell/src/presentation/page/dashboard/main_dashboard.dart';
import 'package:shoppywell/src/presentation/page/error/error_screen.dart';
import 'package:shoppywell/src/presentation/page/initial_page/initial_page_view.dart';
import 'package:shoppywell/src/presentation/page/product/product_detail.dart';
import 'package:shoppywell/src/presentation/page/profile/progile.dart';
import 'package:shoppywell/src/presentation/page/splash/splash_screen.dart';
import 'package:shoppywell/src/utilities/logger.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter routerinit = GoRouter(
  routes: <RouteBase>[
    ///  =================================================================
    ///  ********************** Splash Route *****************************
    /// ==================================================================
    GoRoute(
      name: AppRoutes.SPLASH_ROUTE_NAME,
      path: AppRoutes.SPLASH_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),

    ///  =================================================================
    /// ********************** Authentication Routes ********************
    /// ==================================================================
    GoRoute(
      name: AppRoutes.LOGIN_ROUTE_NAME,
      path: AppRoutes.LOGIN_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const SignInPage();
      },
    ),
    GoRoute(
      name: AppRoutes.SIGNUP_ROUTE_NAME,
      path: AppRoutes.SIGNUP_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const SignUpScreen();
      },
    ),


    ///  =================================================================
    /// ********************** Initial pages Route ******************************
    /// ==================================================================
    GoRoute(
      name: AppRoutes.CHOOSE_PROD_INIT_ROUTE_NAME,
      path: AppRoutes.CHOOSE_PROD_INIT_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const OnboardingScreen();
      },

    ),
    ///  =================================================================
    /// ********************** Main Dashboard Route ******************************
    /// ==================================================================
    GoRoute(
      name: AppRoutes.HOME_ROUTE_NAME,
      path: AppRoutes.HOME_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const MainDashboard();
      },

    ),

    ///  =================================================================
    /// ********************** Product related pages Route ******************************
    /// ==================================================================

    GoRoute(
      name: AppRoutes.PROD_DTL_ROUTE_NAME,
      path: AppRoutes.PROD_DTL_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
          final productId = state.uri.queryParameters['productId'];
        return  ProductDetailPage(productId: productId);
      },

    ),
    // GoRoute(
    //   name: AppRoutes.COMPREHENSIVE_PROD_DTL_ROUTE_NAME,
    //   path: AppRoutes.COMPREHENSIVE_PROD_DTL_ROUTE_PATH,
    //   builder: (BuildContext context, GoRouterState state) {
    //       final productId = state.uri.queryParameters['productId'];
    //     return  ComprehensiveProductDetailPage(productId: productId);
    //   },

    // ),
    ///  =================================================================
    /// ********************** Profile pages Route ******************************
    /// ==================================================================
    GoRoute(
      name: AppRoutes.PROFILE_ROUTE_NAME,
      path: AppRoutes.PROFILE_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return   const ProfilePage();
      },

    ),

  ],
  errorPageBuilder: (context, state) {
    return const MaterialPage(child: ErrorScreen());
  },
  redirect: (context, state) {
    logger.info('redirect: ${state.uri}');
    return null;
  },
);
