import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ViewModels extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;


  Future<File?>pickImage() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    }
    File imageFile = File(image.path);
    return imageFile;
  }  
    Future<Map<String, String>?>uploadImage(File image) async {
    try {
    final imageBytes = await image.readAsBytes();
    final imgname = '${DateTime.now().millisecondsSinceEpoch}.jpeg';
      await _supabase.storage
          .from('imageschools')
          .uploadBinary('$imgname', imageBytes);
        final imgurl = _supabase.storage.from('imageschools').getPublicUrl(imgname);
         notifyListeners(); 
        return {'imgname': imgname, 'imgurl': imgurl};
    } catch (e) {
      print('Error: $e');
    }
  } 
}
