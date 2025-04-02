import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ViewModels{
  final SupabaseClient _supabase = Supabase.instance.client;

  File? selectedImage;

  Future<File?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    }
    File imageFile = File(image.path);
    selectedImage = imageFile;
    return imageFile;
  }

  Future<Map<String, String>?> uploadImage(File image) async {
    try {
      final imageBytes = await image.readAsBytes();
      final imgname = '${DateTime.now().millisecondsSinceEpoch}.jpeg';
      await _supabase.storage
          .from('imageschools')
          .uploadBinary('$imgname', imageBytes);
      final imgurl = _supabase.storage
          .from('imageschools')
          .getPublicUrl(imgname);
      return {'imgname': imgname, 'imgurl': imgurl};
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }
}
