import 'package:flutter/material.dart';

class DocumentsDataUpdate with ChangeNotifier {
  Map<String, bool> checkedItems = {
    'M7': false,
    'Toa thuốc hỗ trợ': false,
    'Hóa đơn mua ngoài': false,
    
  };
 
  int selectedADR = 0;
   int selectedContactLog = 0;

  void setCheckedItem(String key, bool value) {
    checkedItems[key] = value;
    notifyListeners();
  }

  void setSelectedADR(int value) {
    selectedADR = value;
    notifyListeners();
  }
   void setSelectedContaclog(int value) {
    selectedContactLog = value;
    notifyListeners();
  }

  void reset() {
    // Đặt lại tất cả các trạng thái của checkboxes về false
    checkedItems = {
      'M7': false,
    'Toa thuốc hỗ trợ': false,
    'Hóa đơn mua ngoài': false,
    
    };
    
    // Đặt lại selected ADR về giá trị ban đầu
    selectedADR = 0;
     selectedContactLog = 0;
    notifyListeners(); // Thông báo để cập nhật UI
  }
}