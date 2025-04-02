import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ralpher/presentation/viewmodels/viewmodels.dart';

class SchoolProvider extends ChangeNotifier {
  // ignore: prefer_final_fields
  TextEditingController _nameSchool = TextEditingController();
  // ignore: prefer_final_fields
  Color _selectedColor = Colors.white;
  File? _selectedImage;
  ViewModels? _viewModels;

  TextEditingController get nameSchool => _nameSchool;
  Color get selectedColor => _selectedColor;
  File? get selectedImage => _selectedImage;

  Future<File?> pickImage() async {
    _selectedImage = await _viewModels!.pickImage();
    notifyListeners();
    return _selectedImage;
  }
}
