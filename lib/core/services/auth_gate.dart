/*
Servicio de autentificación
unauthenticated -> login page
authenticated -> profile page
*/
import 'package:flutter/material.dart';
import 'package:ralpher/presentation/views/login_page.dart';
import 'package:ralpher/presentation/views/mainhome_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      //listen to auth state changes
      stream: Supabase.instance.client.auth.onAuthStateChange, 
      //Build appropiate page based on auth state
      builder: (context, snapshot){
        //loading
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Scaffold(
            body: Center(child: CircularProgressIndicator(),),
          );
        }
        //Error
        if(snapshot.hasError){
          return const Scaffold(
            body: Center(child: Text('Error de autenticación')),
          );
        }
        
        //check if there is a valid session current
        final session = snapshot.hasData ? snapshot.data!.session : null;
          if(session != null){
            return const MainHomePage();
          }else{
            return const LoginPage();
          }

      }
      );
  }
}