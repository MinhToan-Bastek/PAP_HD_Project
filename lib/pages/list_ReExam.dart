import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pap_hd/components/ListPatientDetail/ScrollListTotal.dart';
import 'package:pap_hd/components/ListPatientDetail/SearchListPatient.dart';
import 'package:pap_hd/components/ListPatientDetail/TitlePatientDetail.dart';
import 'package:pap_hd/components/ListPatientDetail/listbodyPatient.dart';
import 'package:pap_hd/components/ListReExam/TitleReExamList.dart';
import 'package:pap_hd/components/ListReExam/listbodyReExam.dart';
import 'package:pap_hd/components/ListReExam/searchListReExam.dart';
import 'package:pap_hd/components/info_ReExam_Pending/title_ReExam.dart';
import 'package:pap_hd/model/ListPatient_CardScroll.dart';
import 'package:pap_hd/pages/info_ReExam_Pending.dart';
import 'package:pap_hd/services/api_service.dart';

class ListReExam extends StatefulWidget {
  final String username;
  final Map<String, dynamic> patientDetail;
  final String tenChuongTrinh;
  const ListReExam(
      {Key? key,
      required this.username,
      required this.patientDetail,
      required this.tenChuongTrinh})
      : super(key: key);

  @override
  _ListReExamState createState() => _ListReExamState();
}

class _ListReExamState extends State<ListReExam> {
  List<Map<String, dynamic>> reExams = [];
  List<Map<String, dynamic>> _allReExams = [];

  @override
  void initState() {
    super.initState();
    fetchReExamData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String convertToFormattedDate(String isoDateString) {
    try {
      DateTime dateTime = DateTime.parse(isoDateString);

      return DateFormat('dd/MM/yyyy').format(dateTime);
    } catch (e) {
      return isoDateString;
    }
  }

  void fetchReExamData() async {
    try {
      List<Map<String, dynamic>> result = await ApiService().postReExamData(
        username: widget.username,
        maChuongTrinh: widget.patientDetail['MaChuongTrinh'],
        maBenhNhan: widget.patientDetail['MaBenhNhan'],
      );
       print("API Data Received: $result");
      setState(() {
        _allReExams = result
            .map((item) => {
                  "personName": "${item['TenBenhNhan']} - ${item['MaPhieu']}",
                  //"joinDate": item['NgayKham'],
                  "appointmentDate": item['NgayHenTaiKham'],
                  "idPhieuTaiKham": item['IdPhieuTaiKham'],
                  "tinhTrang": item['TinhTrang'],
                  // "maPhieu": item['MaPhieu'],
                  // "maChuongTrinh": item['MaChuongTrinh'] ?? 'unknown',
                })
            .toList();
        reExams = List.from(_allReExams);
         print("Mapped Exams: $reExams"); 
      });
    } catch (e) {
      print("Failed to fetch re-exam data: $e");
    }
  }

  void _searchReExam(String query) {
    if (query.isEmpty) {
      setState(() {
        reExams = List.from(
            _allReExams); // Trả về danh sách ban đầu nếu trường tìm kiếm trống
      });
    } else {
      final results = _allReExams.where((exam) {
        final personName = exam['personName'].toLowerCase();
        final searchLower = query.toLowerCase();
        return personName.contains(searchLower);
      }).toList();
      setState(() {
        reExams = results;
      });
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
              TitleReExamList(tenChuongTrinh: widget.tenChuongTrinh),
              SearchListReExam(
                onSearch: _searchReExam,
              ),
              Expanded(
                child: reExams.isNotEmpty
                    ? ListView.builder(
                        itemCount: reExams.length,
                        itemBuilder: (context, index) {
                          final exam = reExams[index];
                          return InkWell(
                            onTap: () {
                              // When a list item is tapped, navigate to the InfoReExamPending page
                              // and pass the necessary data
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => InfoReExamPending(
                                    tenChuongTrinh: widget.tenChuongTrinh,
                                     idPhieuTaiKham: int.parse(exam['idPhieuTaiKham']),
                                    username: widget.username, reExamData: _allReExams,
                                    // maChuongTrinh: exam["MaChuongTrinh"],
                                    // maPhieu: exam["MaPhieu"],
                                  ),
                                ),
                              );
                            },
                            child: ListBodyReExam(
                              personName: exam["personName"],
                              // joinDate:
                              //     convertToFormattedDate(exam["joinDate"]),
                              appointmentDate: convertToFormattedDate(
                                  exam["appointmentDate"]),
                                   tinhTrang: exam["tinhTrang"],
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          'Không có dữ liệu tìm kiếm !',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
