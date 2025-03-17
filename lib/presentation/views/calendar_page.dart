import 'package:flutter/material.dart';
import 'package:ralpher/presentation/viewmodels/event_viewmodel.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Event>> events = {};
  late final ValueNotifier<List<Event>> _selectedEvents;
  TextEditingController _eventController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_focusedDay));
  }
  
  @override
void dispose() {
  super.dispose();
}

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay=selectedDay;
        _focusedDay=focusedDay;
      });
    }
    
  }

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
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
              selectedDayPredicate:(day)=>isSameDay(_selectedDay, day) ,
              focusedDay: _focusedDay, 
              firstDay: DateTime.utc(0), 
              lastDay: DateTime.utc(9999),
              onDaySelected:_onDaySelected,
              eventLoader: _getEventsForDay,
              ),
          ),
          SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents, 
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length, 
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        onTap: () => print(""),
                        title: Text('${value[index]}'),
                      ),
                    );
                });
              }),
          )
        ],

      );
    }
  Widget build(BuildContext context) {
    return Scaffold(
      body: calendar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context, 
            builder: (context) {
              return AlertDialog(
                scrollable: true,
                title: Text("Event Name"),
                content: Padding(
                  padding: EdgeInsets.all(8),
                  child: TextField(
                    controller: _eventController,
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      events.addAll({
                        _focusedDay!: [Event(_eventController.text)]
                      });
                      Navigator.of(context).pop();
                      _selectedEvents.value = _getEventsForDay(_selectedDay!);
                    }, 
                    child: Text("Submit"),
                  )
                ],
              );
            });
        },
        child: Icon(Icons.add),
      ),

    );
    
  }
}