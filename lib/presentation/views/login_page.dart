import 'package:flutter/material.dart';
import 'package:ralpher/core/services/auth_service.dart';
import 'package:ralpher/presentation/views/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //get auth serviceç
  final authService = AuthService();
  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //login button pressed
  void login() async{
    final email = _emailController.text;
    final password = _passwordController.text;
    //attempt login
    try{
      await authService.signInWithEmailPassword(email, password);
    }catch(e){
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SIGN IN")),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        children: [
          //email
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: "Email"
            ),
          ),
          //pwd
          TextField(
            controller: _passwordController,
            //obscureText: true, //--> Para ocultar pwd
            decoration: const InputDecoration(
              labelText: "Password"
            ),
          ),
          const SizedBox(height: 20),
          //button
          ElevatedButton(
            onPressed: login, 
            child: const Text("Login"),
          ),
          ElevatedButton(
            onPressed: login, 
            child: const Text("Paco"),
          ),
          const SizedBox(height: 15),

          GestureDetector(
            onTap: () => Navigator.push(
              context,
               MaterialPageRoute(builder: (context)=>const SignupPage(),
               )),
               child: Center(child: Text("Don't have an account. Sign up")),
          )
        ],
      ),
    );
  }
}