import 'package:flutter/material.dart';

class PatientAppointmentsScreen extends StatefulWidget {
  @override
  _PatientAppointmentsScreenState createState() =>
      _PatientAppointmentsScreenState();
}

class _PatientAppointmentsScreenState extends State<PatientAppointmentsScreen> {
  List<String> _appointments = [
    "Appointment 1",
    "Appointment 2",
    "Appointment 3",
    "Appointment 4",
    "Appointment 5"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _appointments.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_appointments[index]),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to appointment details screen
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add new appointment screen
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
