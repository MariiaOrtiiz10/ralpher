import 'package:flutter/material.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Courses Management')),
      body: const Center(
        child: Text(
          'Página de gestión de cursos\n\nAquí se mostrará la información y herramientas relacionadas con los cursos académicos',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
