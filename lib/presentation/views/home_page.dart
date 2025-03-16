import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ralpher/data/models/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  UserModel? currentUser;
  File ? _selectedImage;
  Uint8List? _webImage;

  @override
  Widget build(BuildContext context) {
    //get usermail
    return Scaffold(
      body:
       ListView(
         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
         children: [

            const SizedBox(height: 50),
            ElevatedButton(
             onPressed: pickImageFromGallery, 
             child: const Text("Imagen Galeria"),
           ),
            const SizedBox(height: 15),

           ElevatedButton(
             onPressed: pickImageFromCamera, 
             child: const Text("Imagen camara"),
           ),
            _selectedImage != null ? Image.file(_selectedImage!) : const Text("Please selected an image")
         ]
       )          
    );
  }


  Future pickImageFromGallery() async{
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage!.path);
    });
  }


 Future pickImageFromCamera() async{
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);

    if(returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage!.path);
    });
  }

}


