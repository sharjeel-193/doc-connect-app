import 'package:flutter/material.dart';

class PatientAppointmentCard extends StatelessWidget {
  final String doctorName;
  final String doctorPic;
  final String appointmentDate;
  final String doctorType;
  final String appointmentTime;
  final String appointmentDay;
  final String appointmentStatus;

  const PatientAppointmentCard(
      {Key? key,
      required this.doctorName,
      required this.doctorPic,
      required this.doctorType,
      required this.appointmentDate,
      required this.appointmentTime,
      required this.appointmentDay,
      required this.appointmentStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFECEFF2),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('You have an appointment with',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    doctorPic,
                    width: 60,
                    height: 48,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                    child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctorName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          doctorType,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 12.0,
                          ),
                        ),
                      ]),
                ))
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_month,
                          color: Theme.of(context).colorScheme.primary),
                      Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          appointmentDate,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          appointmentDay,
                          style: TextStyle(fontSize: 14),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.watch_later,
                          color: Theme.of(context).colorScheme.primary),
                      Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          appointmentTime,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              //status icons
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (appointmentStatus == 'requested')
                    const Icon(Icons.access_time, color: Colors.blue, size: 28),
                  if (appointmentStatus == 'pending')
                    const Icon(Icons.timer_outlined,
                        color: Colors.blue, size: 28),
                  if (appointmentStatus == 'cancelled')
                    const Icon(
                      Icons.cancel_outlined,
                      color: Colors.redAccent,
                      size: 28,
                    ),
                  if (appointmentStatus == 'done')
                    const Icon(
                      Icons.done_all,
                      color: Colors.green,
                    ),
                  const SizedBox(width: 8),
                  Text(
                    appointmentStatus,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
