import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:pap_hd/components/homeScreen/body.dart';
import 'package:pap_hd/components/patient_registration/info_patientRegis.dart';
import 'package:path/path.dart' as path;

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

  //Get post đăng ký bệnh nhân
  Future<void> postPatientData(
      Map<String, dynamic> patientData, List<XFile?> documentImages) async {
    final url = Uri.parse("$_baseUrl/Values/CreatePatient");

    var request = http.MultipartRequest('POST', url);
    // Gói thông tin patientData vào JSON string và thêm vào fields
    var patientDataJson = json.encode(patientData);
    request.fields['Data'] = patientDataJson;

    // Thêm các fields từ patientData
    patientData.forEach((key, value) {
      if (value is String) {
        request.fields[key] = value;
      }
    });

    // Thêm hình ảnh
    List<String> fieldNames = [
      "M1",
      "M2",
      "CCCD",
      "Hồ sơ bệnh án",
      "Contact Log",
      "ADR"
    ];

    // Thêm hình ảnh với tên được đặt theo tên của ô tương ứng
    for (int i = 0; i < documentImages.length; i++) {
      var image = documentImages[i];
      if (image != null) {
        var stream = http.ByteStream(image.openRead());
        var length = await image.length();
        // Tạo tên file mới theo định dạng "TênÔ.jpg" hoặc tương tự
        var baseName = fieldNames[i].endsWith('.')
            ? fieldNames[i].substring(0, fieldNames[i].length - 1)
            : fieldNames[i];
        var fileName = '$baseName${path.extension(image.path)}';
        var multipartFile =
            http.MultipartFile('File', stream, length, filename: fileName);
        request.files.add(multipartFile);
      }
    }

    var streamedResponse = await request.send();

    try {
      // Kiểm tra nếu streamedResponse không null
      if (streamedResponse != null) {
        // Chuyển đổi StreamedResponse thành Response để dễ dàng xử lý hơn
        var response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200 || response.statusCode == 201) {
          print(
              'Thông tin bệnh nhân và hình ảnh đã được gửi lên server thành công.');
          // Xử lý dữ liệu phản hồi ở đây, ví dụ:
          print('Phản hồi từ server: ${response.body}');
        } else {
          print('Status Code: ${response.statusCode}');
          // Bạn cũng có thể in ra phản hồi chi tiết từ server nếu cần
          print('Phản hồi chi tiết: ${response.body}');
        }
      } else {
        // Xử lý trường hợp không nhận được phản hồi từ server
        print('Không nhận được phản hồi từ server.');
      }
    } catch (e) {
      // Xử lý bất kỳ ngoại lệ nào xảy ra trong quá trình chuyển đổi hoặc xử lý phản hồi
      print('Có lỗi xảy ra khi xử lý phản hồi: $e');
    }
  }

//Lấy danh sách bệnh viện
  Future<List<Hospital>> fetchHospitals(String username) async {
    final url = Uri.parse("$_baseUrl/Values/GetListHospital");
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'username': username,
      }),
    );

    if (response.statusCode == 200) {
      List<dynamic> hospitalsJson = json.decode(response.body);
      List<Hospital> hospitals = hospitalsJson
          .map((hospitalJson) => Hospital.fromJson(hospitalJson))
          .toList();
      return hospitals;
    } else {
      throw Exception('Failed to load hospitals');
    }
  }

//Search bệnh nhân
  Future<List<dynamic>> searchPatients(String username, String query) async {
    final url = Uri.parse("$_baseUrl/Values/GetListPatient");
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'query': query,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load search results');
    }
  }

  //Kết quả search - lấy danh sách bệnh nhân
  Future<dynamic> getPatientById(String idBenhNhan) async {
    final url = Uri.parse("$_baseUrl/Values/GetPatientById");
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'IdBenhNhan': idBenhNhan,
      }),
    );

    if (response.statusCode == 200) {
      print(response.body);

      return json.decode(response.body);
    } else {
      throw Exception('Failed to load patient details');
    }
  }

//Duyệt bệnh nhân
  Future<bool> approvePatient(String username, int id, int status) async {
    final url = Uri.parse("$_baseUrl/Values/ChangeStatusPatient");
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'username': username,
        'id': id,
        'status': status,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (responseBody['Status'] == 1 &&
          responseBody['Message'].toLowerCase() == "success") {
        print(response.body);
        return true; // Duyệt thành công
      }
    }
    return false;
  }

  // Danh sách bệnh nhân
  Future<Map<String, dynamic>> fetchPatients({
    required String username,
    String query = "",
    required int status,
    required int pageIndex,
    required int pageSize,
    required String sortColumn,
    required String sortDir,
  }) async {
    final url = Uri.parse("$_baseUrl/Values/GetListPatientDetail");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json; charset=UTF-8"},
      body: jsonEncode({
        'username': username,
        'query': query,
        'status': status,
        'pageindex': pageIndex,
        'pagesize': pageSize,
        'sortcolumn': sortColumn,
        'sortdir': sortDir,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load patients');
    }
  }

//Cập nhật thông tin tái khám
  Future<void> updateReExam(Map<String, dynamic> patientDataUpdate,
      List<XFile?> documentImages) async {
    final url = Uri.parse("$_baseUrl/Values/CreateInforExamination");

    var request = http.MultipartRequest('POST', url);
     // Gói thông tin patientData vào JSON string và thêm vào fields
    var patientDataJson = json.encode(patientDataUpdate);
    request.fields['Data'] = patientDataJson;

    patientDataUpdate.forEach((key, value) {
      if (value != null) {
        request.fields[key] = value.toString();
      }
    });

    // Thêm hình ảnh
    List<String> fieldNames = [
      "M7",
      "Toa thuốc hỗ trợ",
      "Hóa đơn mua ngoài",
      "ADR",
      "ContactLog",
    ];

      for (int i = 0; i < documentImages.length; i++) {
      var image = documentImages[i];
      if (image != null) {
        var stream = http.ByteStream(image.openRead());
        var length = await image.length();
        // Tạo tên file mới theo định dạng "TênÔ.jpg" hoặc tương tự
        var baseName = fieldNames[i].endsWith('.')
            ? fieldNames[i].substring(0, fieldNames[i].length - 1)
            : fieldNames[i];
        var fileName = '$baseName${path.extension(image.path)}';
        var multipartFile =
            http.MultipartFile('File', stream, length, filename: fileName);
        request.files.add(multipartFile);
      }
    }
  var streamedResponse = await request.send();
    try {
      // Kiểm tra nếu streamedResponse không null
      if (streamedResponse != null) {
        // Chuyển đổi StreamedResponse thành Response để dễ dàng xử lý hơn
        var response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200 || response.statusCode == 201) {
          print(
              'Thông tin bệnh nhân và hình ảnh đã được gửi lên server thành công.');
          // Xử lý dữ liệu phản hồi ở đây, ví dụ:
          print('Phản hồi từ server: ${response.body}');
        } else {
          print('Status Code: ${response.statusCode}');
          // Bạn cũng có thể in ra phản hồi chi tiết từ server nếu cần
          print('Phản hồi chi tiết: ${response.body}');
        }
      } else {
        // Xử lý trường hợp không nhận được phản hồi từ server
        print('Không nhận được phản hồi từ server.');
      }
    } catch (e) {
      // Xử lý bất kỳ ngoại lệ nào xảy ra trong quá trình chuyển đổi hoặc xử lý phản hồi
      print('Có lỗi xảy ra khi xử lý phản hồi: $e');
    }
  }

//Lấy danh sách phiếu tái khám
   Future<List<Map<String, dynamic>>> postReExamData({
  required String username,
  required String maChuongTrinh,
  required String maBenhNhan,
}) async {
  final response = await http.post(
    Uri.parse('$_baseUrl/Values/GetListInforExaminationByPatient'), 
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'machuongtrinh': maChuongTrinh,
      'mabenhnhan': maBenhNhan,
    }),
  );
  if (response.statusCode == 200) {
    // Chuyển đổi kết quả JSON thành List<Map<String, dynamic>>
    return List<Map<String, dynamic>>.from(json.decode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

Future<int> fetchPatientIdd(String patientCode, String username) async {
  var response = await http.post(
    Uri.parse("$_baseUrl/Values/GetListPatient"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'query': patientCode,
    }),
  );

  if (response.statusCode == 200) {
  
    List<dynamic> jsonList = jsonDecode(response.body);
    
    
    if (jsonList.isNotEmpty) {
     
      Map<String, dynamic> patientData = jsonList.first;
      
      
      var id = patientData['IdBenhNhan'];
      if (id is int) {
        return id;
      } else {
        throw Exception('Invalid type for patient ID');
      }
    } else {
      throw Exception('Patient data is empty');
    }
  } else {
    throw Exception('Failed to load patient data');
  }
}
//Lấy danh sách thông tin phiếu tái khám
Future<Map<String, dynamic>> getInforExaminationById(String username, int id,) async {
        final url = Uri.parse("$_baseUrl/Values/GetInforExaminationById");
        var response = await http.post(url,
            headers: {"Content-Type": "application/json"},
            body: json.encode({"username": username, "id": id}));

        if (response.statusCode == 200) {
            return json.decode(response.body);
        } else {
            throw Exception('Failed to load examination info');
        }
    }



}
