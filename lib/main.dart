import 'package:flutter/material.dart';
import 'package:ralpher/core/services/auth_gate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: "https://xvkymhtcipdbdanikzpq.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh2a3ltaHRjaXBkYmRhbmlrenBxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM4NTU1MjksImV4cCI6MjA0OTQzMTUyOX0.sYVHSRdm1cEv4Vydp2lsmngmD3aBG-bBOW61raBnhe4",
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Desactiva el debug banner
      home: AuthGate(),
    );
  }
}                                                                         

//La Vista
// En el método build antes de agregar el ListView deberíamos agregar los widgets de ChangeNotifierProvider y Consumer,con el primero le damos contexto a la vista de 
// quien puede realizar modificaciones sobre ella, con el segundo especificamos qué partes son las que se verán afectadas durante cada update