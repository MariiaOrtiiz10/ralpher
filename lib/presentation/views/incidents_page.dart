import 'package:flutter/material.dart';

class IncidentsPage extends StatelessWidget {
  const IncidentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Incidents Management')),
      body: const Center(
        child: Text(
          'Página de gestión de incidentes\n\nAquí se mostrará la información y herramientas relacionadas con incidentes escolares',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
