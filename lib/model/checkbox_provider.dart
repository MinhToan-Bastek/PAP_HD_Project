import 'package:flutter/foundation.dart';

// class DocumentsData with ChangeNotifier {
//   Map<String, bool> checkedItems = {
//     'M1': false,
//     'M2': false,
//     'CCCD': false,
//     'Hồ sơ bệnh án': false,
//     'Contact log': false,
//   };
//   int selectedADR = 0;

//   void setCheckedItem(String key, bool value) {
//     checkedItems[key] = value;
//     notifyListeners();
//   }

//   void setSelectedADR(int value) {
//     selectedADR = value;
//     notifyListeners();
//   }
//    void reset() {
//     // Reset tất cả các trạng thái liên quan đến checkbox
//     // Ví dụ: checkedItems.clear() hoặc set lại giá trị ban đầu
//     notifyListeners(); // Thông báo để cập nhật UI
//   }
// }

class DocumentsData with ChangeNotifier {
  Map<String, bool> checkedItems = {
    'M1': false,
    'M2': false,
    'CCCD': false,
    'Hồ sơ bệnh án': false,
    'Contact log': false,
  };
  int selectedADR = 0;

  void setCheckedItem(String key, bool value) {
    checkedItems[key] = value;
    notifyListeners();
  }

  void setSelectedADR(int value) {
    selectedADR = value;
    notifyListeners();
  }

  void reset() {
    // Đặt lại tất cả các trạng thái của checkboxes về false
    checkedItems = {
      'M1': false,
      'M2': false,
      'CCCD': false,
      'Hồ sơ bệnh án': false,
      'Contact log': false,
    };
    
    // Đặt lại selected ADR về giá trị ban đầu
    selectedADR = 0;
    
    notifyListeners(); // Thông báo để cập nhật UI
  }
}

