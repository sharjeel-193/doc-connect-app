import 'package:doc_connect_app/components/calendar_widget.dart';
import 'package:doc_connect_app/components/time_slot_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class BookAppointmentScreen extends StatefulWidget {
  final String doctorName;
  final String doctorImg;
  final String doctorType;

  const BookAppointmentScreen(
      {Key? key,
      required this.doctorName,
      required this.doctorImg,
      required this.doctorType})
      : super(key: key);

  @override
  _BookAppointmentScreenState createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  DateTime _selectedDate = DateTime.now();
  String _selectedTime = '';
  List<Map<String, dynamic>> timeSlots1 = [
    {'time': '9:00 - 9:30', 'isBooked': true},
    {'time': '9:30 - 10:00', 'isBooked': false},
    {'time': '10:00 - 10:30', 'isBooked': true},
    {'time': '10:30 - 11:00', 'isBooked': false},
    {'time': '11:00 - 11:30', 'isBooked': true},
    {'time': '11:30 - 12:00', 'isBooked': true},
    {'time': '12:00 - 12:30', 'isBooked': false},
  ];
  List<Map<String, dynamic>> timeSlots2 = [
    {'time': '11:00 - 11:30', 'isBooked': false},
    {'time': '11:30 - 12:00', 'isBooked': false},
    {'time': '12:00 - 12:30', 'isBooked': false},
    {'time': '12:30 - 01:00', 'isBooked': false},
    {'time': '01:00 - 01:30', 'isBooked': true},
    {'time': '01:30 - 02:00', 'isBooked': true},
    {'time': '02:00 - 02:30', 'isBooked': false},
  ];
  late List<Map<String, dynamic>> appointmentSlots;
  int selectedTimeSlotIndex = -1;

  @override
  void initState() {
    super.initState();
    onDateSelected(DateTime.now());
  }

  void onDateSelected(DateTime date) {
    if (date.day.isEven) {
      appointmentSlots = timeSlots1;
      print(appointmentSlots[0]);
    } else {
      appointmentSlots = timeSlots2;
      print(appointmentSlots[0]);
    }
  }

  void _onTimeSlotSelected(int index) {
    setState(() {
      if (selectedTimeSlotIndex == index) {
        selectedTimeSlotIndex = -1;
      } else {
        selectedTimeSlotIndex = index;
      }
    });
    print(appointmentSlots[selectedTimeSlotIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text('Book Appointment',
              style: TextStyle(color: Theme.of(context).colorScheme.primary)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          widget.doctorImg,
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
                                widget.doctorName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    color: Colors.white),
                              ),
                              Text(
                                widget.doctorType,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                ),
                              ),
                            ]),
                      ))
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Select date',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                //_buildCalendar
                CalendarWidget(
                  onDateSelected: (DateTime value) {
                    onDateSelected(value);
                  },
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Select time',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                // TimeSlotButton(
                //   isBooked: false,
                //   time: timeSlots1[0]['time'],
                //   isSelected: false,
                // ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: timeSlots1.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    final timeSlot = appointmentSlots[index];
                    return TimeSlotButton(
                      time: timeSlot['time'],
                      isBooked: timeSlot['isBooked'],
                      isSelected: _selectedTime == timeSlot['time'],
                      onSelected: timeSlot['isBooked']
                          ? null
                          : () {
                              setState(() {
                                _selectedTime = timeSlot['time'];
                                print(_selectedTime);
                              });
                            },
                    );
                  },
                ),

                SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () {
                    //
                  },
                  child: Text('Request Appointment'),
                ),
              ],
            ),
          ),
        ));
  }
}
