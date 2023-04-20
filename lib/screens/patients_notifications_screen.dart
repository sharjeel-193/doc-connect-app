import 'package:flutter/material.dart';

class PatientNotificationsScreen extends StatefulWidget {
  @override
  _PatientNotificationsScreenState createState() =>
      _PatientNotificationsScreenState();
}

class _PatientNotificationsScreenState
    extends State<PatientNotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Patient Notifications Screen'),
      ),
    );
  }
}
