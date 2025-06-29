import 'package:flutter_svg/svg.dart';
import 'package:shoppywell/src/comman/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppywell/src/presentation/bloc/sign_in_form/sign_in_form_bloc.dart';
import 'package:shoppywell/src/presentation/bloc/sign_in_form/sign_in_form_event.dart';
import 'package:shoppywell/src/utilities/constants.dart';
import 'package:shoppywell/src/utilities/shared_prefs_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    final isFirstLaunch = await SharedPrefsHelper.checkFirstLaunch();
    if (mounted) {
      if (isFirstLaunch) {
        // Navigate to initial pages
        context.goNamed(AppRoutes.CHOOSE_PROD_INIT_ROUTE_NAME);
      } else {
        // Check for auto login
        await _checkAuth();
      }
    }
  }

  Future<void> _checkAuth() async {
    String? username = await SharedPrefsHelper.getString(Constants.username_key);
    String? password = await SharedPrefsHelper.getString(Constants.password_key);
    
    if (mounted) {
      if (username != null && password != null && username.isNotEmpty && password.isNotEmpty) {
        // Auto login with stored credentials
        context.read<AuthBloc>().add(LoginEvent(email: username, password: password));
        // Navigate to home page
        context.goNamed(AppRoutes.HOME_ROUTE_NAME);
      } else {
        // No stored credentials, go to login page
        context.goNamed(AppRoutes.LOGIN_ROUTE_NAME);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            // color: Colors.black,
            child: SvgPicture.asset("assets/vectors/logo.svg")));
  }
}
