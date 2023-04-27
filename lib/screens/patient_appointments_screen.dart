import 'package:doc_connect_app/components/patient_appointment_card.dart';
import 'package:flutter/material.dart';

class PatientAppointmentsScreen extends StatefulWidget {
  const PatientAppointmentsScreen({super.key});

  @override
  _PatientAppointmentsScreenState createState() =>
      _PatientAppointmentsScreenState();
}

class _PatientAppointmentsScreenState extends State<PatientAppointmentsScreen>
    with SingleTickerProviderStateMixin {
  List<Map<String, String>> appointments = [
    {
      'doctorName': 'Dr. John Doe',
      'doctorPic': 'assets/images/doctor-1.jpg',
      'doctorType': 'Cardioogist',
      'appointmentDate': '2023-04-27',
      'appointmentTime': '11:00 AM',
      'appointmentDay': 'Today',
      'appointmentStatus': 'cancelled'
    },
    {
      'doctorName': 'Dr. Jane Smith',
      'doctorPic': 'assets/images/doctor-2.jpg',
      'doctorType': 'Dentist',
      'appointmentDate': '2023-04-27',
      'appointmentTime': '2:00 PM',
      'appointmentDay': 'Today',
      'appointmentStatus': 'pending'
    },
    {
      'doctorName': 'Dr. Noha Robert',
      'doctorPic': 'assets/images/doctor-1.jpg',
      'doctorType': 'General Physicial',
      'appointmentDate': '2023-04-27',
      'appointmentTime': '2:00 PM',
      'appointmentDay': 'Today',
      'appointmentStatus': 'requested'
    },
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, initialIndex: 1, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Future'),
              Tab(text: 'Today'),
              Tab(text: 'Past'),
            ],
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
              color: Colors.black, // set the color of the selected tab text
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
              color: Colors.grey, // set the color of the unselected tab text
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                  itemCount: appointments.length,
                  itemBuilder: (BuildContext context, int index) {
                    final appointment = appointments[index];
                    return PatientAppointmentCard(
                        doctorName: appointment['doctorName']!,
                        doctorPic: appointment['doctorPic']!,
                        doctorType: appointment['doctorType']!,
                        appointmentDate: appointment['appointmentDate']!,
                        appointmentTime: appointment['appointmentTime']!,
                        appointmentDay: appointment['appointmentDay']!,
                        appointmentStatus: appointment['appointmentStatus']!);
                  },
                ),
                ListView.builder(
                  itemCount: appointments.length,
                  itemBuilder: (BuildContext context, int index) {
                    final appointment = appointments[index];
                    return PatientAppointmentCard(
                        doctorName: appointment['doctorName']!,
                        doctorPic: appointment['doctorPic']!,
                        doctorType: appointment['doctorType']!,
                        appointmentDate: appointment['appointmentDate']!,
                        appointmentTime: appointment['appointmentTime']!,
                        appointmentDay: appointment['appointmentDay']!,
                        appointmentStatus: appointment['appointmentStatus']!);
                  },
                ),
                ListView.builder(
                  itemCount: appointments.length,
                  itemBuilder: (BuildContext context, int index) {
                    final appointment = appointments[index];
                    return PatientAppointmentCard(
                        doctorName: appointment['doctorName']!,
                        doctorPic: appointment['doctorPic']!,
                        doctorType: appointment['doctorType']!,
                        appointmentDate: appointment['appointmentDate']!,
                        appointmentTime: appointment['appointmentTime']!,
                        appointmentDay: appointment['appointmentDay']!,
                        appointmentStatus: appointment['appointmentStatus']!);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    )));
  }
}
