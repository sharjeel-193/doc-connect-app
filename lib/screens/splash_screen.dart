import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:doc_connect_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        backgroundColor: Theme.of(context).colorScheme.primary,
        nextScreen: LoginScreen(),
        splash: Image.asset(
          './assets/logos/logo-white-text.png',
          height: 200,
          width: 200,
        ),
        splashTransition: SplashTransition.scaleTransition,
        pageTransitionType: PageTransitionType.leftToRight,
      ),
    );
  }
}
