import 'package:flutter/material.dart';
import 'package:horizontal_calendar/horizontal_calendar.dart';
class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDate = DateTime.now();
  Color _selectedColor = Colors.orange;

  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          HorizontalCalendar(
            date: DateTime.now(),
            textColor: Colors.black45,
            backgroundColor: Colors.white,
            selectedColor: Colors.blue,
            showMonth:true,
            locale: Localizations.localeOf(context),
            onDateSelected: (date) {
              print(date.toString());
            },
          ),

          SizedBox(height: 20),
          Text(
            'Selected Date: ${_selectedDate.toLocal()}',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          // Add your time-related widgets here
          // For example, you can use a TimePicker or build your own time selection UI
        ],
      );
  }

  List<DateTime> _generateDates() {
    // Generate a list of dates for the calendar
    // You can customize this based on your needs
    DateTime currentDate = DateTime.now();
    List<DateTime> dates = [];
    for (int i = -15; i <= 15; i++) {
      dates.add(currentDate.add(Duration(days: i)));
    }
    return dates;
  }
}