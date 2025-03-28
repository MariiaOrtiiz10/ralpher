import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ViewModels extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;


  Future<Map<String, String>?>pickImage() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    }
    File imageFile = File(image.path);
    final imageBytes = await imageFile.readAsBytes();
    final imgname = '${DateTime.now().millisecondsSinceEpoch}.jpeg';
    try {
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
