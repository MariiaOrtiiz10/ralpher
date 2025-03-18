import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/school.dart';

class SchoolRepository {
  //conexion
  final SupabaseClient _supabase = Supabase.instance.client;
  //Create
  Future<void> createSchool(String name, String? color, String? image) async {
      final currentUser = Supabase.instance.client.auth.currentUser;
      try {
      if (currentUser != null) {
         await _supabase.from("schools").insert({
        'name': name,
        'color': color,
        'image': image,
      });
      }
      } catch (e) {
      print('Error insert school:  $e');
    }
  }

  //Read
  Future getSchoolFromUser() async {
    final currentUser = _supabase.auth.currentUser;
    try {
      if (currentUser != null) {
        final response = await _supabase.from('schools').select();
        return response;
      }
    } catch (e) {
      print('Error fetching school data:  $e');
    }
    return null;
  }

  //Update
  Future updateSchool() async {

  }

  //Delete
  Future deleteSchool(int schoolid) async {
    final currentUser = _supabase.auth.currentUser;
    try {
      if (currentUser != null) {
         await _supabase.from('schools').delete().eq('id', schoolid);
      }
    } catch (e) {
      print('Error delete school:  $e');
    }
    return null;
  }
}
