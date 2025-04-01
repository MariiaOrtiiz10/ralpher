import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ralpher/presentation/viewmodels/viewmodels.dart';

class SchoolProvider extends ChangeNotifier {
  final TextEditingController _schoolName = TextEditingController();
  Color? _selectedColor;
  File? _selectedImage;

  final ViewModels _viewModels = ViewModels();

  TextEditingController get schoolName => _schoolName;
  Color? get selectedColor => _selectedColor;
  File? get selectedImage => _selectedImage;

  void setColor(Color color) {
    _selectedColor = color;
    notifyListeners();
  }

  void setImage(File image) {
    _selectedImage = image;
    notifyListeners();
  }

  Future<void> pickImage() async {
    final image = await _viewModels.pickImage();
    
  }
}
