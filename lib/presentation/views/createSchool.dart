
import 'package:image_picker/image_picker.dart';

class CreateSchool {

final ImagePicker _picker = ImagePicker();
  XFile? _image;

  XFile? get selectedImage => _image;

  set image(XFile? newImage) {
    _image = newImage;
  }

  ImagePicker get picker => _picker;



  // final ImagePicker _picker = ImagePicker();
  // XFile? _image;

  // // Getter para acceder a la imagen
  // XFile? get selectedImage => _image;

  // // Setter para actualizar la imagen desde otra clase
  // set image(XFile? newImage) {
  //   _image = newImage;
  // }

  // // Getter para acceder al picker
  // ImagePicker get picker => _picker;

}