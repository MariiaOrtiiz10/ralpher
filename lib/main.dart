import 'package:flutter/material.dart';
import 'package:ralpher/core/services/auth_gate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  await Supabase.initialize(
    url: "https://xvkymhtcipdbdanikzpq.supabase.co", 
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh2a3ltaHRjaXBkYmRhbmlrenBxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM4NTU1MjksImV4cCI6MjA0OTQzMTUyOX0.sYVHSRdm1cEv4Vydp2lsmngmD3aBG-bBOW61raBnhe4",
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AuthGate(
        
      ),
    );
  }
}
