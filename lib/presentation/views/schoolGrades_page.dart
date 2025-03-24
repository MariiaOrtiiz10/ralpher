import 'package:flutter/material.dart';

class SchoolGradesPage extends StatelessWidget {
  const SchoolGradesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('School Grades')),
      body: const Center(
        child: Text(
          'Página de calificaciones escolares\n\nAquí se mostrará la información y herramientas relacionadas con las calificaciones',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
