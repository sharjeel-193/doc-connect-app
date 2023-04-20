import 'package:flutter/material.dart';

class PatientProfileScreen extends StatelessWidget {
  final String email;
  final String name;

  const PatientProfileScreen({
    Key? key,
    required this.email,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: $name',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Email: $email',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement sign out functionality
              },
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
