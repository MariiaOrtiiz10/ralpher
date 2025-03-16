import 'package:flutter/material.dart';
import 'package:ralpher/core/services/auth_service.dart';
import 'package:ralpher/data/models/user_model.dart';
import 'package:ralpher/data/repositories/user_repository.dart';
class SettingsPage extends StatefulWidget {
  final UserRepository userRepository;
  const SettingsPage({super.key, required this.userRepository});
  

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final authService = AuthService();
  UserModel? currentUser;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData(); 
  }
    void logout() async{
    await authService.signOut();
  }
  Future<void> _loadUserData() async{
    try{
      final user = await widget.userRepository.getCurrentUserData();
      setState(() {
        currentUser = user;
        isLoading = false;
      });
    }catch(e){
      print('Error loading user data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userEmail = authService.getCurrentUserEmail();
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        children: [
              ElevatedButton(
             onPressed: logout, 
             child: const Text("Log out"),
           ),
            const SizedBox(height: 15),
            Text("DATOS DEL USUARIO"),
            if (isLoading)
            Center(child: CircularProgressIndicator())
          else if (currentUser == null)
            Text("No se encontraron datos del usuario.")
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Email: "),
                Text(userEmail.toString()),
                Text("Id: ${currentUser?.id ?? "null"}"),
                Text("Name: ${currentUser?.name ?? "null"}"),
                Text("Surname: ${currentUser?.surname ?? "null"}"),
                Text("Img: ${currentUser?.imgname ?? "null"}"),
                Text("Url: ${currentUser?.imgurl ?? "null"}"),
              ],
            ),
        ]
      ),
    );
  }
}