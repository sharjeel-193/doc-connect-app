import 'package:doc_connect_app/screens/patient_appointments_screen.dart';
import 'package:doc_connect_app/screens/patient_home_screen.dart';
import 'package:doc_connect_app/screens/patient_records_screen.dart';
import 'package:doc_connect_app/screens/patients_notifications_screen.dart';
import 'package:flutter/material.dart';

class PatientNavigation extends StatefulWidget {
  @override
  _PatientNavigationState createState() => _PatientNavigationState();
}

class _PatientNavigationState extends State<PatientNavigation> {
  int _currentIndex = 1;

  final List<Widget> _screens = [
    const PatientHomeScreen(),
    const PatientAppointmentsScreen(),
    PatientNotificationsScreen(),
    PatientRecordsScreen()
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(64.0),
            child: AppBar(
              backgroundColor: Colors.white,
              leading: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 4, 4, 4),
                child: Image.asset(
                  'assets/logos/logo-main.png',
                  height: 24,
                ),
              ),
              title: const Center(
                child: Text(
                  'DocConnect',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
              ),
              actions: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                    child: IconButton(
                      icon: const CircleAvatar(
                        radius: 36.0,
                        backgroundImage: AssetImage(
                          'assets/images/profile-image-1.jpeg',
                        ),
                      ),
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                    )),
              ],
              primary: true,
              elevation: 5.0,
              toolbarHeight: 64.0,
            ),
          ),
          drawer: Drawer(
            child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: const CircleAvatar(
                      radius: 50.0,
                      backgroundImage: AssetImage(
                        'images/profile-image-1.jpeg',
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('My Profile'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () {},
                ),
              ],
            ),
          ),
          body: _screens[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today_outlined),
                label: 'Appointments',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_outlined),
                label: 'Notifications',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_outlined),
                label: 'Records',
              ),
            ],
          ),
        ));
  }
}
