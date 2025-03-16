import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today=day;
    });
  }
  @override
  Widget calendar(){
      return Column(
        children: [
          Container(
            child: TableCalendar(
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(color: const Color.fromARGB(255, 1, 37, 66),
                fontSize:20,
                fontWeight: FontWeight.bold),
              ),
              
    
              availableGestures: AvailableGestures.all,
              selectedDayPredicate:(day)=>isSameDay(day, today) ,
              focusedDay: today, 
              firstDay: DateTime.utc(0), 
              lastDay: DateTime.utc(9999),
              onDaySelected:_onDaySelected ,
              ),
          )
        ],

      );
    }
  Widget build(BuildContext context) {
    return Scaffold(
      body: calendar(),
    );
    
  }
}