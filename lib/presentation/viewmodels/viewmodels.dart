// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:ralpher/data/models/school.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'dart:io';

// class ViewModels extends ChangeNotifier {
//   final SupabaseClient _supabase = Supabase.instance.client;
//   School? school;

//   Future<void> uploadImage(File imageFile) async {
//     final fileName = Uuid().v4();
//     final bucketName = "img";

//     try {
//       // Subir la imagen al bucket de Supabase Storage
//       await _supabase.storage
//           .from(bucketName)
//           .upload(
//             fileName,
//             imageFile,
//             fileOptions: FileOptions(contentType: 'image/jpeg'),
//           );

//       if (school?.imgname != null) {
//         await removeItemBucket(school!.imgname!, bucketName: bucketName);
//       }

//       // Actualizar la información del usuario con la nueva imagen
//       school?.imgname = fileName;
//       school?.imgurl = await getURLBucket(fileName, bucketName: bucketName);

//       // Actualizar el usuario en la base de datos
//       await updateSchool();
//     } catch (e) {
//       throw Exception("Error uploading image: $e");
//     }
//   }

//   Future<String> getURLBucket(String fileName, String bucketName) async {
//     try {
//       final url = _supabase.storage.from(bucketName).getPublicUrl(fileName);
//       return url;
//     } catch (e) {
//       throw Exception("Error getting URL: $e");
//     }
//   }

//   Future<void> removeItemBucket(
//     String fileName, {
//     required String bucketName,
//   }) async {
//     if (fileName != "userProfileBasic.png") {
//       try {
//         await _supabase.storage.from(bucketName).remove([fileName]);
//       } catch (e) {
//         throw Exception("Error removing item: $e");
//       }
//     }
//   }
// }
