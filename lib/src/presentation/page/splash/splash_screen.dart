import 'package:shoppywell/src/comman/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    Future.delayed(const Duration(seconds: 1), () {

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Splash Screen.',
                    style: TextStyle(
                      // color: Theme.of(context).primaryColor,
                      fontSize: 16,
                    ),
                  ),
                  OutlinedButton(
                      child: Text('Go to login'),
                      onPressed: () {
                      context.replaceNamed(AppRoutes.CHOOSE_PROD_INIT_ROUTE_NAME);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
