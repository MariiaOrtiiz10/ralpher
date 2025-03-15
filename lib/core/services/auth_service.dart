import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  //sign up with email and password
  Future<AuthResponse>signUpWithEmailPassword(String email, String password) async {
    return await _supabase.auth.signUp(
      email: email,
      password: password,
    );
  }
  
  //Sign in with email and password
  Future<AuthResponse>signInWithEmailPassword(String email, String password) async{
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }
  //sign out
  Future<void> signOut() async{
    await _supabase.auth.signOut();
  }

  //get user email
  String? getCurrentUserEmail(){
    final session = _supabase.auth.currentSession;
    if (session != null && session.user != null) {
      final user = session.user;
      return user.email;
  }
  return null;
    
  }
}