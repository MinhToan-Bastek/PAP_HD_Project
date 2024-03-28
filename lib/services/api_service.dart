import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:pap_hd/components/homeScreen/body.dart';

class ApiService {

  final String _baseUrl = "http://119.82.141.248:2345/api";

//Login
Future<Map<String, dynamic>> login(String username, String password) async {
    final url = Uri.parse("$_baseUrl/Values/login");

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData; // Trả về toàn bộ thông tin từ API
    } else {
      throw Exception('Failed to login');
    }
  }

//Gửi token về server
  Future<void> fetchAndSendToken(String username, String accesstoken) async {
    final url = Uri.parse("$_baseUrl/Values/CreateTokenLogin");
    String? tokenFCM = await FirebaseMessaging.instance.getToken();
    print("FCM Token: $tokenFCM");
    var body = jsonEncode({
      'username': username,
      'access_token': accesstoken,
      'token_app': tokenFCM,
    });
      print('Dữ liệu gửi về Server: $body'); 
      
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      print('Token và username đã được gửi lên server thành công.');
    } else {
      print('Lỗi khi gửi token và username lên server: ${response.statusCode}');
    }
  }

  //Get list - Màn hình Home
  Future<List<Project>> fetchProjects(String username) async {
    final url = Uri.parse("$_baseUrl/Values/GetListProject");

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
      }),
    );

    if (response.statusCode == 200) {
      List<dynamic> projectsJson = json.decode(response.body) as List;
      return projectsJson.map((json) => Project.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load projects');
    }
  }
  //Get list Detail - Màn hình Details
  Future<Map<String, dynamic>> fetchProjectDetails(String pid) async {
    final url = Uri.parse("$_baseUrl/Values/GetProjectDetail");

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'idchuongtrinh': pid,
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> projectDetailsJson = json.decode(response.body);
      return projectDetailsJson; // Trả về thông tin chi tiết của dự án
    } else {
      throw Exception('Failed to load project details');
    }
  }



}


