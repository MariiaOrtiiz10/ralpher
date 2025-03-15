import 'package:flutter/material.dart';
import 'package:ralpher/core/services/auth_service.dart';
import 'package:ralpher/data/models/user.dart';
import 'package:ralpher/data/repositories/user_repository.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authService = AuthService();
  final userRepository = UserRepository();

  //User? currentUser = userRepository().getCurrentUserData();

  void logout() async{
    await authService.signOut();
  }
 

  @override
  Widget build(BuildContext context) {
    //get usermail
    final userEmail = authService.getCurrentUserEmail();
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body:ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        children: [
          ElevatedButton(
            onPressed: logout, 
            child: const Text("Log out"),
          ),
           const SizedBox(height: 15),
           Text("Email: "),
           Text(userEmail.toString())
           
        ]
      )
      
      

    );
  }
}