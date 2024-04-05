import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// class DocumentImagesProvider with ChangeNotifier {
//   List<XFile?> _documentImages = List.filled(6, null, growable: false);
//    List<String?> imageNames = List.filled(6, null);

//   List<XFile?> get documentImages => _documentImages;

//    void setImage(int index, XFile? image, String imageName) {
//     documentImages[index] = image;
//     imageNames[index] = imageName;
//     notifyListeners();
//   }

//   void clearImage(int index) {
//     if (index >= 0 && index < _documentImages.length) {
//       _documentImages[index] = null;
//       notifyListeners();
//     }
//   }
//    void reset() {
//     // Clear danh sách hình ảnh
//     documentImages.clear();
//     notifyListeners(); // Thông báo để cập nhật UI
//   }
// }

class DocumentImagesProvider with ChangeNotifier {
  // Sử dụng List.empty(growable: true) để đảm bảo rằng danh sách có thể mở rộng.
  List<XFile?> _documentImages = List.empty(growable: true);
  List<String?> imageNames = List.empty(growable: true);

  List<XFile?> get documentImages => _documentImages;

  void setImage(int index, XFile? image, String imageName) {
    // Đảm bảo index không vượt quá chiều dài của danh sách
    // và thêm các phần tử nếu cần.
    if (index >= _documentImages.length) {
      // Mở rộng danh sách để chứa phần tử mới.
      _documentImages.length = index + 1;
      imageNames.length = index + 1;
    }
    _documentImages[index] = image;
    imageNames[index] = imageName;
    notifyListeners();
  }

  void clearImage(int index) {
    if (index >= 0 && index < _documentImages.length) {
      _documentImages[index] = null;
      imageNames[index] = null;
      notifyListeners();
    }
  }

  void reset() {
    // Clear danh sách hình ảnh
    _documentImages = List.empty(growable: true); // Sử dụng List.empty(growable: true) để reset danh sách
    imageNames = List.empty(growable: true); // Tương tự như trên
    notifyListeners(); // Thông báo để cập nhật UI
  }
}


