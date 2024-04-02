import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DocumentImagesProvider with ChangeNotifier {
  List<XFile?> _documentImages = List.filled(6, null, growable: false);
   List<String?> imageNames = List.filled(6, null);

  List<XFile?> get documentImages => _documentImages;

  // void setImage(int index, XFile? image) {
  //   if (index >= 0 && index < _documentImages.length) {
  //     _documentImages[index] = image;
  //     notifyListeners();
  //   }
  // }
   void setImage(int index, XFile? image, String imageName) {
    documentImages[index] = image;
    imageNames[index] = imageName;
    notifyListeners();
  }

  void clearImage(int index) {
    if (index >= 0 && index < _documentImages.length) {
      _documentImages[index] = null;
      notifyListeners();
    }
  }
}
