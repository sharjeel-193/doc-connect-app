import 'package:doc_connect_app/navigations/doctor_navigation.dart';
import 'package:doc_connect_app/screens/book_appointment_screen.dart';
import 'package:doc_connect_app/screens/login_screen.dart';
import 'package:doc_connect_app/screens/patient_records_screen.dart';
import 'package:doc_connect_app/screens/signup_screen.dart';
import 'package:doc_connect_app/screens/splash_screen.dart';
import 'package:doc_connect_app/navigations/patient_navigation.dart';
import 'package:doc_connect_app/screens/patient_appointments_screen.dart';
import 'package:doc_connect_app/screens/patient_home_screen.dart';
import 'package:doc_connect_app/screens/patients_notifications_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

// void main() {
//   runApp(MyApp());
// }

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoggedIn();
  }

  void _checkLoggedIn() async {
    User? user = _auth.currentUser;
    print(user);
    setState(() {
      _isLoggedIn = (user != null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doc Connect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: const Color(0xFF108DE9),
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
      routes: {
        '/': (context) => SplashScreen(isLoggedIn: _isLoggedIn),
        '/login': (context) => LoginScreen(isLoggedIn: _isLoggedIn),
        '/signup': (context) => SignupScreen(),
        '/patient': (context) => PatientNavigation(),
        '/patient/home': (context) => PatientHomeScreen(),
        '/patient/appointments': (context) => PatientAppointmentsScreen(),
        '/patient/notifications': (context) => PatientNotificationsScreen(),
        '/patient/records': (context) => PatientRecordsScreen(),
        '/book-appointment': (context) => const BookAppointmentScreen(
            doctorName: 'Dr. Ali',
            doctorImg: 'assets/images/doctor-2.jpg',
            doctorType: 'Cardiology'),
        '/doctor': (context) => DoctorNavigation(),
      },
      initialRoute: '/',
    );
  }
}
