import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository {
    final SupabaseClient _supabase = Supabase.instance.client;

//Devuelve un objeto User si encuentra el usuario en la base de datos -->  Busca en la tabla users el usuario cuyo email coincida con el del usuario autenticado.
//Si pongo .select('id')
  Future<User?> _getCurrentUserData() async {
    final user = _supabase.auth.currentUser;
    try{
      if(user != null){
        final response = await 
        _supabase.from('users')
        .select()
        .eq('email', user.email ?? '')
        .single();

        return User.fromJson(response);
      }
    }catch(e){
      print('Error fetching user data:  $e');
    }
    return null;

  }
}