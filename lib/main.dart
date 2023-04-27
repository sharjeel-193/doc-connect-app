import 'package:doc_connect_app/screens/login_screen.dart';
import 'package:doc_connect_app/screens/patient_records_screen.dart';
import 'package:doc_connect_app/screens/splash_screen.dart';
import 'package:doc_connect_app/navigations/patient_navigation.dart';
import 'package:doc_connect_app/screens/patient_appointments_screen.dart';
import 'package:doc_connect_app/screens/patient_home_screen.dart';
import 'package:doc_connect_app/screens/patient_profile_screen.dart';
import 'package:doc_connect_app/screens/patients_notifications_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/login',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/patient': (context) => PatientNavigation(),
        '/patient/home': (context) => PatientHomeScreen(),
        '/patient/appointments': (context) => PatientAppointmentsScreen(),
        '/patient/notifications': (context) => PatientNotificationsScreen(),
        '/patient/records': (context) => PatientRecordsScreen(),
      },
      theme: ThemeData(
          primaryColor: const Color(0xFF8C52FF),
          fontFamily: 'Roboto',
          colorScheme: const ColorScheme(
              brightness: Brightness.light,
              primary: Color(0xFF108DE9),
              onPrimary: Color.fromARGB(255, 13, 57, 93),
              secondary: Color(0x33108DE9),
              onSecondary: Color.fromARGB(255, 77, 76, 76),
              error: Colors.redAccent,
              onError: Color(0xFF9C4343),
              background: Colors.white,
              onBackground: Colors.white,
              surface: Colors.white,
              onSurface: Colors.white)),
      // home: const SplashScreen(),
    );
  }
}
