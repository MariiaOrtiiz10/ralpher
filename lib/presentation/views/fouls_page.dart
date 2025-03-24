import 'package:flutter/material.dart';

class FoulsPage extends StatelessWidget {
  const FoulsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fouls Management')),
      body: const Center(
        child: Text(
          'Página de gestión de faltas\n\nAquí se mostrará la información y herramientas relacionadas con las faltas de los estudiantes',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
