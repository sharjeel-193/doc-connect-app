import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DoctorTypeButton extends StatelessWidget {
  final String icon;
  final String type;
  final String link;
  final String filter;
  final String filterValue;
  final double width;

  const DoctorTypeButton(
      {Key? key,
      required this.icon,
      required this.type,
      required this.link,
      required this.filter,
      required this.filterValue,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle doctor button tap here using the provided link
      },
      child: Container(
        width: width,
        height: width,
        margin: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 4.0,
              spreadRadius: 0.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 56.0,
                width: 56.0,
                child: SvgPicture.asset(
                  icon,
                  width: 40,
                  height: 40,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                type,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
      ),
    );
  }
}
