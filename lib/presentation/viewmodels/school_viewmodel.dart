import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ralpher/presentation/views/createSchool.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// provides a way to notify the UI when the data changes
class SchoolViewmodel extends ChangeNotifier {

//Function to pick image form gallery
File? _selectedImage;

  File? get selectedImage => _selectedImage;

  Future<void> pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;
    _selectedImage = File(returnedImage.path);
    notifyListeners();
  }

  Future<void> pickImageFromCamera() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnedImage == null) return;
    _selectedImage = File(returnedImage.path);
    notifyListeners();
  }
//Function tu upload the image 

//  Future<String?> _uploadImage(ImagePicker picker, XFile? selectedImage) async {
//     if (selectedImage == null) return null; // Verificamos que haya una imagen

//     try {
//       final supabase = Supabase.instance.client; // Instancia correcta de Supabase
//       final bytes = await selectedImage!.readAsBytes();
//       final fileExt = selectedImage!.path.split('.').last;
//       final fileName = '${DateTime.now().toIso8601String()}.$fileExt';
//       final filePath = 'uploads/$fileName';

//       final storageResponse = await supabase.storage.from('images').uploadBinary(
//             filePath,
//             bytes,
//             fileOptions: FileOptions(contentType: selectedImage!.mimeType), // Corregido
//           );

//       return storageResponse;
//     } catch (e) {
//       print('Error al subir la imagen: $e');
//       return null;
//     }
//   }
//Function to create a Schoolobjet and insert it into supabase
}


