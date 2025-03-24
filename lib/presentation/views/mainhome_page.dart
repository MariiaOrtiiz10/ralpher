import 'package:flutter/material.dart';
import 'package:ralpher/data/repositories/user_repository.dart';
import 'home_page.dart';
import 'calendar_page.dart';
import 'settings_page.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  final _userRepository = UserRepository();
  int myIndex = 0;
  late List<Widget> pages; // Se declara sin inicializar
  final List<String> appBarTitles = ["Schools", "Calendar", "Settings"];
  // Lista de páginas
  @override
  void initState() {
    super.initState();
    pages = [
      HomePage(),
      CalendarPage(userRepository: _userRepository),
      SettingsPage(userRepository: _userRepository),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
        //title: Text(appBarTitles[myIndex]), 
      //),
      body: IndexedStack(
        index: myIndex, 
        children: pages, 
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        currentIndex: myIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
