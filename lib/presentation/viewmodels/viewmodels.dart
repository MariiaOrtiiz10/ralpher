import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ViewModels extends ChangeNotifier {
  final SupabaseClient supabase = Supabase.instance.client;
  File? _selectedImage;
  String? _imageUrl;
  String? _imageName;

  File? get selectedImage => _selectedImage;
  String? get imageUrl => _imageUrl;
  String? get imageName => _imageName;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    
    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
      _imageName = pickedFile.name;
      notifyListeners(); 
    }
  }

  Future<void> uploadImage(int schoolId) async {
    if (_selectedImage == null) return;

    try {
      _imageName = '${DateTime.now().millisecondsSinceEpoch}.jpeg';
      final String filePath = '$_imageName';
      Uint8List imageBytes = await _selectedImage!.readAsBytes();
      await supabase.storage.from('imageschools').uploadBinary(
        filePath,
        imageBytes,
        fileOptions: const FileOptions(contentType: 'image/jpeg'),
      );
      _imageUrl = supabase.storage.from('imageschools').getPublicUrl(filePath);
      notifyListeners();
      print('Imagen subida con éxito: $_imageUrl');
    } catch (e) {
      print('Error al subir la imagen: $e');
    }
  }
}
