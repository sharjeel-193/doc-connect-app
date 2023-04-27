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
        body: SafeArea(
            child: Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Appointments',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.primary),
            softWrap: true,
          ),
          const SizedBox(height: 16),
        ],
      ),
    )));
  }
}

// ListView.builder(
//         itemCount: _appointments.length,
//         itemBuilder: (BuildContext context, int index) {
//           return ListTile(
//             title: Text(_appointments[index]),
//             trailing: Icon(Icons.arrow_forward_ios),
//             onTap: () {
//               // Navigate to appointment details screen
//             },
//           );
//         },
//       ),
