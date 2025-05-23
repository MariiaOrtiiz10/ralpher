import 'package:ralpher/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  //Devuelve un objeto User si encuentra el usuario en la base de datos -->  Busca en la tabla users el usuario cuyo id coincida con el del usuario autenticado.
  //Si pongo .select('id')

  Future<UserModel?> getCurrentUserData() async {
    final user = _supabase.auth.currentUser;
    try {
      if (user != null) {
        final response =
            await _supabase.from('users').select().eq('id', user.id).single();
        print(response);
        return UserModel.fromJson(response);
      }
    } catch (e) {
      print('Error fetching user data:  $e');
    }
    return null;
  }
  // Obtener el rol del usuario desde la tabla users_school
  Future<String?> getUserRole(String userId) async {
    try {
      final response =
          await _supabase
              .from('users_school')
              .select('rool_school')
              .eq('user_id', userId)
              .single();
      return response['rool_school'] as String?;
    } catch (e) {
      print('Error fetching user role: $e');
      return null;
    }
  }
  //Function to saver user data to Supabase "users" table(no hace falta)
  Future<void> saveUserToDatabase(UserModel registerUser) async {
    try {
      await _supabase.from('users').insert(registerUser.toJson());
    } catch (e) {
      print('Error save user data to supabase users table:  $e');
    }
  }
}
