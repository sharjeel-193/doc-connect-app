import 'package:doc_connect_app/components/doctor_button.dart';
import 'package:doc_connect_app/components/doctor_type_button.dart';
import 'package:doc_connect_app/components/service_button.dart';
import 'package:flutter/material.dart';

class PatientHomeScreen extends StatelessWidget {
  const PatientHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Welcome Back, Sharjeel',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.primary),
              softWrap: true,
            ),
            const SizedBox(height: 16),
            const Text(
              'Our services',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
                height: 100.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    ServiceButton(
                      icon: Icons.add,
                      label: 'Schedule a Visit',
                      link: '/schedule',
                      isDark: true,
                    ),
                    ServiceButton(
                      icon: Icons.biotech,
                      label: 'Lab Tests',
                      link: '/lab-tests',
                      isDark: false,
                    ),
                    ServiceButton(
                      icon: Icons.coronavirus,
                      label: 'COVID Reports',
                      link: '/covid-reports',
                      isDark: false,
                    ),
                    ServiceButton(
                      icon: Icons.medication_outlined,
                      label: 'Medicines',
                      link: '/medicines',
                      isDark: false,
                    ),
                  ],
                )),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Doctors near you',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('See All')
              ],
            ),
            const SizedBox(height: 8),
            const DoctorButton(
              image: 'assets/images/profile-image-1.jpeg',
              name: 'Dr. John Doe',
              type: 'Cardiologist',
              city: 'New York',
              rating: '4.5',
              link: 'doctor/john-doe',
            ),
            const DoctorButton(
              image: 'assets/images/profile-image-1.jpeg',
              name: 'Dr. John Doe',
              type: 'Cardiologist',
              city: 'New York',
              rating: '4.5',
              link: 'doctor/john-doe',
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16.0),
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Specialities',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Wrap(
                      children: const [
                        DoctorTypeButton(
                            icon: 'assets/svgs/cardiology-icon.svg',
                            type: 'Cardiology',
                            link: 'Cardiology',
                            filter: 'Cardiology',
                            filterValue: 'Cardiology',
                            width: 144),
                        DoctorTypeButton(
                            icon: 'assets/svgs/general-icon.svg',
                            type: 'General Physician',
                            link: 'Cardiology',
                            filter: 'Cardiology',
                            filterValue: 'Cardiology',
                            width: 144),
                        DoctorTypeButton(
                            icon: 'assets/svgs/neurology-icon.svg',
                            type: 'Neurology',
                            link: 'Cardiology',
                            filter: 'Cardiology',
                            filterValue: 'Cardiology',
                            width: 144),
                        DoctorTypeButton(
                            icon: 'assets/svgs/dentist-icon.svg',
                            type: 'Dentist',
                            link: 'Cardiology',
                            filter: 'Cardiology',
                            filterValue: 'Cardiology',
                            width: 144),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            // ElevatedButton(
            //   child: const Text('View Appointments'),
            //   onPressed: () {
            //     Navigator.pushNamed(context, '/patient/appointments');
            //   },
            // ),
          ],
        ),
      ),
    )));
  }
}
