import 'package:flutter/material.dart';
import 'package:ralpher/core/services/auth_service.dart';
import 'package:ralpher/presentation/views/login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  //get auth serviceç
  final authService = AuthService();
  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void signup() async{
    final email = _emailController.text;
    final password = _passwordController.text;
    //attempt login
    try{
      await authService.signUpWithEmailPassword(email, password);
      //para cerrar la pantalla(sigup).
      Navigator.pop(context);
    }catch(e){
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SIGN UP")),
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
            decoration: const InputDecoration(
              labelText: "Password"
            ),
          ),
          const SizedBox(height: 20),
          //button
          ElevatedButton(
            onPressed: signup, 
            child: const Text("Sign up"),
          ),

          const SizedBox(height: 15),

          GestureDetector(
            onTap: () => Navigator.push(
              context,
               MaterialPageRoute(builder: (context)=>const LoginPage(),
               )),
               child: Center(child: Text("Have an account. Sign in")),
          )
        ],
      ),
    );
  }
}