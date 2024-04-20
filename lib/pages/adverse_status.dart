// import 'package:flutter/material.dart';
// import 'package:pap_hd/components/adverse_reporting/title_adverse_Reporting.dart';
// import 'package:pap_hd/components/adverse_status/listbody_adverse_Status.dart';
// import 'package:pap_hd/components/adverse_status/provisional_confirmation_status.dart';
// import 'package:pap_hd/components/adverse_status/reject_status.dart';
// import 'package:pap_hd/components/adverse_status/scroll_adverse_Status.dart';
// import 'package:pap_hd/components/adverse_status/search_adverse_Status.dart';
// import 'package:pap_hd/components/adverse_status/title_adverse_Status.dart';
// import 'package:pap_hd/components/bottomNavBar/adverse_reportNavBar.dart';
// import 'package:pap_hd/components/bottomNavBar/adverse_statusNavBar.dart';
// import 'package:pap_hd/model/ListAdverseStatus.dart';
// import 'package:pap_hd/services/api_service.dart';

// class AdverseStatus {
//   final int id;
//    final String adrCode;
//   final String maBenhNhan;
//   final String tenBenhNhan;
//   final String cccd;

//   final DateTime? ngayBaoCao;

//   AdverseStatus({
//     required this.id,
//     required this.adrCode,
//     required this.maBenhNhan,
//     required this.tenBenhNhan,
//     required this.cccd,
//     this.ngayBaoCao,
//   });

//   factory AdverseStatus.fromJson(Map<String, dynamic> json) {
//     return AdverseStatus(
//       id: json['IdBenhNhan'],
//       maBenhNhan: json['MaBenhNhan'],
//       tenBenhNhan: json['TenBenhNhan'],
//       cccd: json['CCCD'],
//       adrCode: json['NguyenNhan'],
//       ngayBaoCao: json['NgayBaoCao'] != null
//           ? DateTime.parse(json['NgayBaoCao'])
//           : null,
//     );
//   }
// }

//   class AdverseStatus extends StatefulWidget {
//   final String username;
//   final List<AdverseStatus> adverseList;
//   final StatusSummary summary;
//   final String tenChuongTrinh;

//   const AdverseStatus(
//       {Key? key,
//       required this.username,
//       required this.summary,
//       required this.tenChuongTrinh, required this.adverseList})
//       : super(key: key);

//   @override
//   _AdverseStatusState createState() => _AdverseStatusState();
// }

// class _AdverseStatusState extends State<AdverseStatus> {

//     @override
//   void initState() {
//     super.initState();

//   }
// void fetchAdverseByStatus (int status) async {

//   if (_currentStatus != status) {
//     _currentPage = 1;
//     _patients.clear();
//   _currentStatus = status;

//   // Làm mới danh sách
//   setState(() {
//     _isFetching = true;
//     _filteredPatients = [];
//   });

//   try {
//     final response = await ApiService().fetchStatusAdverse(
//       username: widget.username,
//       status: status,
//       pageIndex: _currentPage,
//       pageSize: 5,
//       sortColumn: "IdBenhNhan",
//       sortDir: "Asc",
//     );

//     if (response is Map<String, dynamic> && response.containsKey('ListPatients')) {
//       List<dynamic> patientsJson = response['ListPatients'];
//       List<Patient> newPatients = patientsJson.map((json) => Patient.fromJson(json)).toList();

//       setState(() {
//         _filteredPatients.addAll(newPatients);
//         _patients.addAll(newPatients);
//         if (newPatients.isNotEmpty) {
//           _currentPage++;
//         }
//         _isFetching = false;
//       });
//     }
//   } catch (e) {
//     print("Error fetching patients by status: $e");
//     setState(() {
//       _isFetching = false;
//     });
//   }
// }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             // Ảnh nền cho toàn bộ màn hình
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/homeScreen/home_background.png'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Column(
//             children: [
//               TitleAdverseStatus(tenChuongTrinh: widget.tenChuongTrinh,), // Phần title không cuộn
//               Expanded(
//                 child: SingleChildScrollView(
//                   // Phần cuộn cho nội dung dưới title
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 15.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         ScrollableCardRow(
//                            summary: widget.summary,
//                 onTap: fetchAdverseByStatus,
//                         ),
//                         SearchAdverseStatus(),
//                         SizedBox(height: 10,),

//                           CustomListItemWidget(
//                             documentId: 'BCBL-001256',
//                             personName: 'Nguyễn Văn Tuấn',
//                             detail: 'Nguyên nhân dẫn đến phải thực hiện báo cáo là do nguyên nhân...',
//                             statusText: 'Xác nhận',
//                             statusColor: Color(0xFFD8F7EE),
//                             additionalIcon1: Icons.info,
//                             statusIconSvg: 'assets/adverse_status/status_2.svg',
//                           ),

//                           ProvisionalConfirrm(
//                             documentId: 'BCBL-001258',
//                             personName: 'Trương Văn Bản',
//                             detail: 'While Papua New Guineas leaders are good at rolling out the....',
//                             statusText: 'Xác nhận tạm thời',
//                             statusColor: Color(0xFFD8E2F7),
//                             additionalIcon1: Icons.info,
//                             statusIconSvg: 'assets/adverse_status/status_3.svg',
//                           ),

//                           RejectStatus(
//                             documentId: 'BCBL-001259',
//                             personName: 'Lưu Quốc Việt',
//                             detail: 'This week’s violence is a wake-up call for U.S and international...',
//                             statusText: 'Từ chối',
//                             statusColor: Color(0xFFF7D8D8),
//                             additionalIcon1: Icons.info,
//                             statusIconSvg: 'assets/adverse_status/status_4.svg',
//                           ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavBarStatusAdverse(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pap_hd/components/ListPatientDetail/ScrollListTotal.dart';
import 'package:pap_hd/components/ListPatientDetail/SearchListPatient.dart';
import 'package:pap_hd/components/ListPatientDetail/TitlePatientDetail.dart';
import 'package:pap_hd/components/ListPatientDetail/listbodyPatient.dart';
import 'package:pap_hd/components/adverse_status/listbody_adverse_Status.dart';
import 'package:pap_hd/components/adverse_status/title_adverse_Status.dart';
import 'package:pap_hd/components/bottomNavBar/adverse_statusNavBar.dart';
import 'package:pap_hd/model/ListPatient_CardScroll.dart';
import 'package:pap_hd/services/api_service.dart';

class Adverse {
  final int id;
  final String maBenhNhan;
  final String tenBenhNhan;
  final String cccd;
  final String ADRCode;
  final String nguyenNhan;
  final DateTime? ngayBaoCao;

  Adverse({
    required this.id,
    required this.maBenhNhan,
    required this.tenBenhNhan,
    required this.cccd,
    required this.ADRCode,
    required this.nguyenNhan,
    this.ngayBaoCao,
  });

  factory Adverse.fromJson(Map<String, dynamic> json) {
    String? dateString = json['NgayBaoCao'];
    DateTime? parsedDate;

    if (dateString != null) {
      DateFormat format = DateFormat('dd/MM/yyyy');
      try {
        parsedDate = format.parse(dateString, true);
      } catch (e) {
        print("Error parsing date: $e");
      }
    }

    return Adverse(
      id: json['Id'],
      maBenhNhan: json['MaBenhNhan'],
      tenBenhNhan: json['TenBenhNhan'],
      cccd: json['CCCD'],
      ADRCode: json['ADRCode'],
      nguyenNhan: json['NguyenNhan'],
      ngayBaoCao: parsedDate,
    );
  }
}

class AdverseStatus extends StatefulWidget {
  final String username;
  final List<Adverse> patientsList;
  final PatientSummary summary;
  final String tenChuongTrinh;

  const AdverseStatus(
      {Key? key,
      required this.username,
      required this.patientsList,
      required this.summary,
      required this.tenChuongTrinh})
      : super(key: key);

  @override
  _AdverseStatusState createState() => _AdverseStatusState();
}

class _AdverseStatusState extends State<AdverseStatus> {
  int _currentStatus = -1;
  int _currentPage = 1;
  bool _isFetching = false;
  final List<Adverse> _patients = [];
  List<Adverse> _filteredPatients = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchMorePatients();
    _scrollController.addListener(_onScroll);
    _filteredPatients = _patients;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_isFetching &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
      _fetchMorePatients();
    }
  }

  String convertToFormattedDate(String isoDateString) {
    try {
      DateTime dateTime = DateTime.parse(isoDateString);

      return DateFormat('dd/MM/yyyy').format(dateTime);
    } catch (e) {
      return isoDateString;
    }
  }

  Future<void> _fetchMorePatients() async {
    if (_isFetching) return;
    setState(() => _isFetching = true);

    // Tạo một instance của ApiService
    ApiService apiService = ApiService();

    try {
      final response = await apiService.fetchStatusAdverse(
        username: widget.username,
        status: _currentStatus,
        pageIndex: _currentPage,
        pageSize: 5,
        sortColumn: "Id",
        sortDir: "Asc",
      );

      if (response is Map<String, dynamic> &&
          response.containsKey('ListADRReports')) {
        List<dynamic> patientsJson = response['ListADRReports'];
        List<Adverse> newPatients =
            patientsJson.map((json) => Adverse.fromJson(json)).toList();

        if (newPatients.isNotEmpty) {
          setState(() {
            _currentPage++;
            _patients.addAll(newPatients);
            // Cập nhật _filteredPatients mỗi khi có dữ liệu mới
            _filteredPatients = _patients;
          });
        }
      }
    } catch (e) {
      print("Error fetching more patients: $e");
    } finally {
      setState(() => _isFetching = false);
    }
  }

  void filterPatients(String searchText) async {
    if (searchText.isEmpty) {
      setState(() {
        // Trả về trạng thái ban đầu nếu không có tìm kiếm
        _filteredPatients = _patients;
      });
      return;
    }
    // Gọi API với tham số tìm kiếm
    try {
      final response = await ApiService().fetchStatusAdverse(
        username: widget.username,
        query: searchText,
        status: -1,
        pageIndex: 1,
        pageSize: 5,
        sortColumn: "Id",
        sortDir: "Asc",
      );

      if (response is Map<String, dynamic> &&
          response.containsKey('ListADRReports')) {
        List<dynamic> patientsJson = response['ListADRReports'];
        List<Adverse> newPatients =
            patientsJson.map((json) => Adverse.fromJson(json)).toList();

        setState(() {
          _filteredPatients = newPatients;
        });
      }
    } catch (e) {
      print("Error searching patients: $e");
      setState(() {
        _filteredPatients = [];
      });
    }
  }

  void fetchAdverseByStatus(int status) async {
    if (_currentStatus != status) {
      _currentPage = 1;
      _patients.clear();
      _currentStatus = status;

      // Làm mới danh sách
      setState(() {
        _isFetching = true;
        _filteredPatients = [];
      });

      try {
        final response = await ApiService().fetchStatusAdverse(
          username: widget.username,
          status: status,
          pageIndex: _currentPage,
          pageSize: 5,
          sortColumn: "Id",
          sortDir: "Asc",
        );

        if (response is Map<String, dynamic> &&
            response.containsKey('ListADRReports')) {
          List<dynamic> patientsJson = response['ListADRReports'];
          List<Adverse> newPatients =
              patientsJson.map((json) => Adverse.fromJson(json)).toList();

          setState(() {
            _filteredPatients.addAll(newPatients);
            _patients.addAll(newPatients);
            if (newPatients.isNotEmpty) {
              _currentPage++;
            }
            _isFetching = false;
          });
        }
      } catch (e) {
        print("Error fetching patients by status: $e");
        setState(() {
          _isFetching = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/homeScreen/home_background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              TitleAdverseStatus(
                tenChuongTrinh: widget.tenChuongTrinh,
              ),
              ScrollPatient(
                summary: widget.summary,
                onTap: fetchAdverseByStatus,
              ),
              SearchListPatients(
                onSearch: filterPatients,
              ),
              Expanded(
                child: _filteredPatients.isEmpty && !_isFetching
                    ? Center(
                        child: Text(
                          'Không có dữ liệu !',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey[600],
                          ),
                        ),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount:
                            _filteredPatients.length + (_isFetching ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < _filteredPatients.length) {
                            final patient = _filteredPatients[index];
                            return CustomListItemWidget(
                              tenChuongTrinh: widget.tenChuongTrinh,
                              username : widget.username,
                              personName: '${patient.tenBenhNhan}',
                              ADRCode: '${patient.ADRCode}',
                              status: _currentStatus,
                              reportDate: convertToFormattedDate(
                                  patient.ngayBaoCao?.toIso8601String() ??
                                      'Chưa báo cáo'),
                              reason: '${patient.nguyenNhan}', reportId: patient.id ,
                            );
                          } else {
                            return Center(
                                child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.teal),
                            ));
                          }
                        },
                      ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar:BottomNavBarStatusAdverse()
    );
  }
}
