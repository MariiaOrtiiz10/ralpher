import 'package:flutter/material.dart';
import 'home_page.dart'; 
import 'calendar_page.dart'; 
import 'settings_page.dart'; 

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int myIndex = 0;

  // Lista de páginas
  final List<Widget> pages = [
    HomePage(), 
    CalendarPage(), 
    SettingsPage(), 
  ];

  // Títulos del AppBar para cada página
  final List<String> appBarTitles = [
    "Schools",
    "Calendar",
    "Settings",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitles[myIndex]), 
      ),
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
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}