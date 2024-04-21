import 'package:flutter/material.dart';

class ExaminationInfoProvider with ChangeNotifier {
  Map<String, dynamic> _examInfo = {};

  Map<String, dynamic> get examInfo => _examInfo;

  set examInfo(Map<String, dynamic> newInfo) {
    _examInfo = newInfo;
    notifyListeners();
  }

  void updateExamInfo(Map<String, dynamic> newInfo) {
    _examInfo = newInfo;
    notifyListeners();
  }
}

