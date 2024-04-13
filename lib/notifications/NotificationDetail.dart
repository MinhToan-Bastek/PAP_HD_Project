// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class NotificationDetail {
//   final String title;
//   final String body;
//   final DateTime receivedTime;

//   NotificationDetail({
//     required this.title,
//     required this.body,
//     required this.receivedTime,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'title': title,
//       'body': body,
//       'receivedTime': receivedTime.toIso8601String(),
//     };
//   }
//   factory NotificationDetail.fromJson(Map<String, dynamic> json) {
//   return NotificationDetail(
//     title: json['title'],
//     body: json['body'],
//     receivedTime: DateTime.parse(json['receivedTime']),
//   );
// }
// String parsePatientCode() {
//     // Giả sử mã bệnh nhân luôn theo mẫu "BN000026"
//     RegExp regExp = RegExp(r"BN0*(\d+)");
//     var matches = regExp.firstMatch(body);
//     return matches?.group(1) ?? ''; // Sử dụng group(1) để lấy các số không có số 0 đầu tiên
// }

 
 

// }




import 'dart:convert';

class NotificationDetail {
  final String title;        // Tiêu đề thông báo
  final String body;         // Nội dung thông báo
  final DateTime receivedTime; // Thời gian nhận thông báo
   bool flagRead; 
  bool flagClick;  

  NotificationDetail({required this.title, required this.body, required this.receivedTime, this.flagRead = false,  
    this.flagClick = false, 
     });

  // Phương thức khởi tạo từ JSON
  factory NotificationDetail.fromJson(Map<String, dynamic> json) {
    return NotificationDetail(
      title: json['DocType'], // Sử dụng DocType làm title
      body: json['Message'],  // Sử dụng Message làm body
      receivedTime: DateTime.parse(json['SendDate']), 
       flagRead: json['FlagRead'] == 0 ? false : true,  // Giả sử 0 là chưa đọc, 1 là đã đọc
      flagClick: json['FlagClick'] == 0 ? false : true,
    );
  }

  // Chuyển đổi đối tượng thành JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'receivedTime': receivedTime.toIso8601String(),
       'FlagRead': flagRead ? 1 : 0,
      'FlagClick': flagClick ? 1 : 0,
    };
  }

  // Phương thức để phân tích mã bệnh nhân từ body
  String parsePatientCode() {
    RegExp regExp = RegExp(r"BN0*(\d+)");
    var matches = regExp.firstMatch(body);
    return matches?.group(1) ?? '';
  }
}



