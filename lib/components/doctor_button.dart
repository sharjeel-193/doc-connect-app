import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../screens/doctor_profile_screen.dart';

class DoctorButton extends StatelessWidget {
  final String image;
  final String name;
  final String type;
  final String city;
  final String rating;
  final String link;

  const DoctorButton({
    Key? key,
    required this.image,
    required this.name,
    required this.type,
    required this.city,
    required this.rating,
    required this.link,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle doctor button tap here using the provided link
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorProfileScreen(
              name: 'Dr. John Doe',
              imageUrl: 'assets/images/doctor-1.jpg',
              aboutHeading: 'About Dr. John Doe',
              aboutText:
                  'Dr. John Doe is a highly skilled physician with over 20 years of experience...',
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 71.0,
              height: 56.0,
              // height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                  // image: NetworkImage(image),
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
                child: Container(
              width: 264,
              // decoration: BoxDecoration(color: Colors.yellow),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  // const SizedBox(height: 4.0),
                  Text(
                    type,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 12.0,
                        color: Colors.redAccent,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        city,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
            const SizedBox(
              width: 24.0,
            ),
            Expanded(
              child: Container(
                // decoration: BoxDecoration(color: Colors.red),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        rating,
                        style: const TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.w600),
                      ),
                      // const SizedBox(height: 4.0),
                      const Text(
                        'Rating',
                        style: TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.w500),
                      )
                    ]),
              ),
            ),
            const SizedBox(width: 8.0),
            Icon(
              Icons.arrow_forward_ios,
              size: 24.0,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
