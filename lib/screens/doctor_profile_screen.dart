import 'package:doc_connect_app/screens/book_appointment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DoctorProfileScreen extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String aboutHeading;
  final String aboutText;

  DoctorProfileScreen(
      {required this.name,
      required this.imageUrl,
      required this.aboutHeading,
      this.aboutText = 'ABC'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Image.asset(
                imageUrl,
                height: 208,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        DoctorProfileDetailsCard(
                            icon: Icons.time_to_leave, text: '9:00 - 5:00'),
                        DoctorProfileDetailsCard(
                            icon: Icons.money, text: '3000/hr'),
                        DoctorProfileDetailsCard(
                            icon: Icons.location_city, text: 'Islamabad')
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      aboutHeading,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      aboutText,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(height: 16),
                    const Text(
                      'Location',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x1C000000),
                            offset: Offset(0, 4),
                            blurRadius: 8,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: GoogleMap(
                          initialCameraPosition: const CameraPosition(
                            target: LatLng(37.4221, -122.0841),
                            zoom: 15,
                          ),
                          markers: {
                            const Marker(
                              markerId: MarkerId('Clinic'),
                              position: LatLng(37.4221, -122.0841),
                            ),
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Reviews',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RatingBar.builder(
                              initialRating: 4.5,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 24,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              '(50)',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 4),
                    _buildReviewCard(
                      'John Smith',
                      'assets/images/user-2.jpg',
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam eu tellus sed ante dapibus efficitur.',
                      4,
                    ),
                    SizedBox(height: 4),
                    _buildReviewCard(
                      'Jane Doe',
                      'assets/images/user-1.jpg',
                      'Vestibulum vulputate orci eget enim efficitur dignissim. Sed non ante eu ante dapibus suscipit in sed nunc.',
                      5,
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookAppointmentScreen(
                                doctorImg: 'assets/images/doctor-1.jpg',
                                doctorName: 'Dr. Muzammil Malik',
                                doctorType: 'Dentist',
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Book Appointment',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class DoctorProfileDetailsCard extends StatelessWidget {
  final IconData icon;
  final String text;

  const DoctorProfileDetailsCard({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      width: 96,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildReviewCard(
    String userName, String userProfileImage, String reviewText, int rating) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(userProfileImage),
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  RatingBar.builder(
                    initialRating: rating.toDouble(),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 16.0,
                    itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Text(
                reviewText,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
