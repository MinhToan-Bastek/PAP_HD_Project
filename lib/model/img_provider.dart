import 'package:flutter/foundation.dart';

class ImageProviderModel with ChangeNotifier {
  List<String> _images = [];

  List<String> get images => _images;

  void addImage(String imagePath) {
    _images.add(imagePath);
    notifyListeners(); // Thông báo đến các listener về sự thay đổi
  }
   void removeImageAt(int index) {
    if (index >= 0 && index < _images.length) {
      _images.removeAt(index);
      notifyListeners(); // Thông báo đến các listener về sự thay đổi
    }
  }
}
