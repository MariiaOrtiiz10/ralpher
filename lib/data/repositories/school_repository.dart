import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/school.dart';

class SchoolRepository {
  //conexion
  final SupabaseClient _supabase =  Supabase.instance.client;
  //Create
  Future<void> createSchool(String name, String? color, String? image) async {
  final school = School(name: name, color: color, image: image);
  final response=await _supabase.from("schools")
    .insert(
      school.toJson())
    .select('');
  print("Respuesta de Supabase: $response");
  }

  Future<void> saveSchoolToSchoolUser(int idSchool)async{
    final currentUserid = _supabase.auth.currentUser!.id;
    final response = await _supabase.from("users_schools")
      .insert({
        'user_id': currentUserid,
        'school_id': idSchool,
        'role': 'manager',
      })
      .select();
      
  }
  //Read
  Future getSchool() async{

    
  }


  //Update
  Future updateSchool() async{

  }

  //Delete
  Future deleteSchool() async{

  }

}