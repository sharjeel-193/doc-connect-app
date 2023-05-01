import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:doc_connect_app/navigations/patient_navigation.dart';
import 'package:doc_connect_app/screens/login_screen.dart';
import 'package:doc_connect_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  final bool isLoggedIn;

  const SplashScreen({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        backgroundColor: Theme.of(context).colorScheme.primary,
        nextScreen: widget.isLoggedIn
            ? PatientNavigation()
            : LoginScreen(
                isLoggedIn: widget.isLoggedIn,
              ),
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
