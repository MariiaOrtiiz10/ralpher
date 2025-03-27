import 'package:flutter/material.dart';

class ReleasePage extends StatelessWidget {
  const ReleasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Release Management')),
      body: const Center(
        child: Text(
          'Página de gestión de lanzamientos\n\nAquí se mostrará la información y herramientas relacionadas con lanzamientos académicos',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
