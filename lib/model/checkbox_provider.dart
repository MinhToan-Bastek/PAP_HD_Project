import 'package:flutter/foundation.dart';

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
}
