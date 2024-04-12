import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificationDetail {
  final String title;
  final String body;
  final DateTime receivedTime;

  NotificationDetail({
    required this.title,
    required this.body,
    required this.receivedTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'receivedTime': receivedTime.toIso8601String(),
    };
  }
  factory NotificationDetail.fromJson(Map<String, dynamic> json) {
  return NotificationDetail(
    title: json['title'],
    body: json['body'],
    receivedTime: DateTime.parse(json['receivedTime']),
  );
}
String parsePatientCode() {
    // Giả sử mã bệnh nhân luôn theo mẫu "BN000026"
    RegExp regExp = RegExp(r"BN0*(\d+)");
    var matches = regExp.firstMatch(body);
    return matches?.group(1) ?? ''; // Sử dụng group(1) để lấy các số không có số 0 đầu tiên
}

 
 

}

