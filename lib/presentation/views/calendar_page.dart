import 'package:flutter/material.dart';
import 'package:ralpher/data/repositories/user_repository.dart';
import 'package:ralpher/presentation/viewmodels/event_viewmodel.dart';
import 'package:ralpher/presentation/views/createSchool.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  final UserRepository userRepository;
  const CalendarPage({super.key, required this.userRepository});

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
    _eventController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedEvents.value = _getEventsForDay(selectedDay);
      });
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  @override
  Widget calendar() {
    return Column(
      children: [
        Container(
          child: TableCalendar(
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(
                color: const Color.fromARGB(255, 1, 37, 66),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            availableGestures: AvailableGestures.all,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(0),
            lastDay: DateTime.utc(9999),
            onDaySelected: _onDaySelected,
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
                      title: Text(value[index].title),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder:
              (context) => Scaffold(
                appBar: AppBar(
                  actions: [
                    IconButton(
                      icon: Icon(
                        Icons.person,
                      ), // Icono para redirigir a CreateSchool
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => CreateSchool(
                                  userRepository:
                                      widget
                                          .userRepository, // Pasa el UserRepository
                                ), // Navega a CreateSchool.dart
                          ),
                        );
                      },
                    ),
                  ],
                ),
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
                            child: TextField(controller: _eventController),
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                if (_eventController.text.isNotEmpty) {
                                  final newEvent = Event(_eventController.text);

                                  // Verifica si ya existe un evento con el mismo nombre en el día seleccionado
                                  if (events[_selectedDay!]?.any(
                                        (event) =>
                                            event.title == newEvent.title,
                                      ) ??
                                      false) {
                                    // Muestra un mensaje de error si el evento ya existe
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Ya existe un evento con el mismo nombre en este día.",
                                        ),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  } else {
                                    // Agrega el nuevo evento
                                    setState(() {
                                      if (events[_selectedDay!] != null) {
                                        events[_selectedDay!]!.add(
                                          newEvent,
                                        ); // Agrega el evento a la lista existente
                                      } else {
                                        events[_selectedDay!] = [
                                          newEvent,
                                        ]; // Crea una nueva lista con el evento
                                      }
                                      _selectedEvents.value = _getEventsForDay(
                                        _selectedDay!,
                                      ); // Actualiza la lista de eventos
                                    });
                                  }

                                  _eventController
                                      .clear(); // Limpia el campo de texto
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Text("Submit"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Icon(Icons.add),
                ),
              ),
        );
      },
    );
  }
}
