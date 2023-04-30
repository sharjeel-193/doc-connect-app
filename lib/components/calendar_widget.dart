import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  final ValueChanged<DateTime> onDateSelected;

  const CalendarWidget({Key? key, required this.onDateSelected})
      : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late DateTime _selectedDate;
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedDate = now;
    _focusedDay = now;
    _calendarFormat = CalendarFormat.month;
    _firstDay = DateTime(now.year, now.month, now.day);
    _lastDay = DateTime(now.year, now.month, now.day + 30);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDate = selectedDay;
      _focusedDay = focusedDay;
    });
    widget.onDateSelected?.call(selectedDay);
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        selectedDecoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.primary,
        ),
        todayDecoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
        ),
      ),
      selectedDayPredicate: (day) => isSameDay(day, _selectedDate),
      onDaySelected: _onDaySelected,
      calendarFormat: _calendarFormat,
      focusedDay: _focusedDay,
      firstDay: _firstDay,
      lastDay: _lastDay,
      headerStyle: const HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
    );
  }
}
