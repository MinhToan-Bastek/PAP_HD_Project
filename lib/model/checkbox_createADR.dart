import 'package:flutter/material.dart';

class DocumentsDataCreateADR with ChangeNotifier {
  Map<String, bool> checkedItems = {
    'ADR': false,
    'Contact log': true
    
  };
 
  void setCheckedItem(String key, bool value) {
    checkedItems[key] = value;
    notifyListeners();
  }
  
  void reset() {
    // Đặt lại tất cả các trạng thái của checkboxes về false
    checkedItems = {
    'ADR': false,
    'Contact log': true
    
    };
    notifyListeners(); // Thông báo để cập nhật UI
  }
}