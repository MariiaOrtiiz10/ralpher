import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SchoolRepository {
  //conexion
  final SupabaseClient _supabase = Supabase.instance.client;
  //Create
  Future<void> createSchool(String name, String? color, String? imgname, String? imgurl, Map<String, dynamic>? schedule, Map<String, dynamic>? calendarSettings, String? location, int? students) async {
      final currentUser = Supabase.instance.client.auth.currentUser;
      try {
      if (currentUser != null) {
         await _supabase.from("schools").insert({
        'name': name,
        'color': color,
        'imgname': imgname,
        'imgurl': imgurl,
        'schedule' : schedule,
        'calendar_settings' : calendarSettings,
        'location' : location,
        'students' :students,
      });
      }
      } catch (e) {
      debugPrint('Error insert school:  $e');
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
      debugPrint('Error fetching school data:  $e');
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
      debugPrint('Error delete school:  $e');
    }
    return null;
  }
}
