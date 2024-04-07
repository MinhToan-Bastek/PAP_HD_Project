import 'package:flutter/material.dart';
import 'package:pap_hd/components/ListPatientDetail/ScrollListTotal.dart';
import 'package:pap_hd/components/ListPatientDetail/SearchListPatient.dart';
import 'package:pap_hd/components/ListPatientDetail/TitlePatientDetail.dart';
import 'package:pap_hd/components/ListPatientDetail/listbodyPatient.dart';
import 'package:pap_hd/components/adverse_reporting/title_adverse_Reporting.dart';
import 'package:pap_hd/components/adverse_status/listbody_adverse_Status.dart';
import 'package:pap_hd/components/adverse_status/provisional_confirmation_status.dart';
import 'package:pap_hd/components/adverse_status/reject_status.dart';
import 'package:pap_hd/components/adverse_status/scroll_adverse_Status.dart';
import 'package:pap_hd/components/adverse_status/search_adverse_Status.dart';
import 'package:pap_hd/components/adverse_status/title_adverse_Status.dart';
import 'package:pap_hd/components/bottomNavBar/adverse_reportNavBar.dart';
import 'package:pap_hd/model/ListPatient_CardScroll.dart';

class Patient {
  final int id;
  final String maBenhNhan;
  final String tenBenhNhan;
  final String cccd;
  final String soDienThoai;
  final DateTime? ngayDuocDuyet;

  Patient({
    required this.id,
    required this.maBenhNhan,
    required this.tenBenhNhan,
    required this.cccd,
    required this.soDienThoai,
    this.ngayDuocDuyet,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['IdBenhNhan'],
      maBenhNhan: json['MaBenhNhan'],
      tenBenhNhan: json['TenBenhNhan'],
      cccd: json['CCCD'],
      soDienThoai: json['SoDienThoai'],
      ngayDuocDuyet: json['NgayDuocDuyet'] != null ? DateTime.parse(json['NgayDuocDuyet']) : null,
    );
  }
}

class ListPatientDetail extends StatefulWidget {
  final List<Patient> patientsList;
  final PatientSummary summary;
  const ListPatientDetail({Key? key, required this.patientsList,required this.summary}) : super(key: key);

  @override
  State<ListPatientDetail> createState() => _ListPatientDetailState();
}

class _ListPatientDetailState extends State<ListPatientDetail> {
  List<Patient> filteredPatientsList = [];

  @override
  void initState() {
    super.initState();
    filteredPatientsList = widget.patientsList;
  }

  void filterPatients(String searchText) {
    setState(() {
      if (searchText.isEmpty) {
        filteredPatientsList = widget.patientsList;
      } else {
        filteredPatientsList = widget.patientsList.where((patient) =>
          patient.tenBenhNhan.toLowerCase().contains(searchText.toLowerCase()) ||
          patient.maBenhNhan.toLowerCase().contains(searchText.toLowerCase())
        ).toList();
      }
    });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('Danh sách bệnh nhân')),
    body: Column(
      children: [
        ScrollPatient(summary: widget.summary, onTap: (index) {
          // Xử lý sự kiện tap vào mỗi card, có thể là lọc danh sách bệnh nhân dựa trên trạng thái
          //filterPatientsBasedOnStatus(index);
        }),
        SearchListPatients(
          onSearch: (searchText) {
            filterPatients(searchText);
          },
        ),
        
        Expanded(
          child: ListView.builder(
            itemCount: filteredPatientsList.length,
            itemBuilder: (context, index) {
              // Bạn cũng có thể thêm logic tại đây để hiển thị dữ liệu dựa trên bộ lọc
              final patient = filteredPatientsList[index];
               String personName = '${patient.maBenhNhan} - ${patient.tenBenhNhan}';
              return CustomListPatient(
                personName: personName,
                card: patient.cccd,
                telephone: patient.soDienThoai,
                joinDate: patient.ngayDuocDuyet?.toString() ?? 'Chưa duyệt',
              );
            },
          ),
        ),
      ],
    ),
  );
}
}






// class ListPatientDetail extends StatefulWidget {
//     final List<Patient> patientsList;


//   const ListPatientDetail({super.key, required this.patientsList});
//   @override
//   State<ListPatientDetail> createState() => _ListPatientDetailState();
// }

// class _ListPatientDetailState extends State<ListPatientDetail> {
//   bool showCustomListPatient = true;
//   bool showProvisionalConfirrm = true;
//   bool showRejectStatus = true;

//     @override
//   void initState() {
//     super.initState();
//     // Hiển thị tất cả các widget khi trang được tải lần đầu
//     showCustomListPatient = true;
//     showProvisionalConfirrm = true;
//     showRejectStatus = true;
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
//            Column(
//             children: [
//               TitlePatientDetail(), // Phần title không cuộn
//               Expanded(
//                 child: SingleChildScrollView(
//                   // Phần cuộn cho nội dung dưới title
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 15.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         ScrollableCardRow(
//                           onTap: (index) {
//                             setState(() {
//                               if (index == 0) {
//                                 // Nếu bấm vào ô "Tổng cộng", hiển thị tất cả widget
//                                 showCustomListPatient = true;
//                                 showProvisionalConfirrm = true;
//                                 showRejectStatus = true;
//                               } else if (index == 1) {
                                
//                                 showCustomListPatient = true;
//                                 showProvisionalConfirrm = false;
//                                 showRejectStatus = false;
//                               } else if (index == 2) {
                              
//                                 showCustomListPatient = false;
//                                 showProvisionalConfirrm = true;
//                                 showRejectStatus = false;
//                               } else if (index == 3) {
                               
//                                 showCustomListPatient = false;
//                                 showProvisionalConfirrm = false;
//                                 showRejectStatus = true;
//                               }
//                             });
//                           },
//                         ),
//                         SearchAdverseStatus(),
//                         SizedBox(height: 10,),
//                         if (showCustomListPatient)
//                           CustomListPatient(
                            
//                             personName: 'BN00001-Nguyễn Văn Tuấn',
//                             card: '09909999',
//                             telephone: '09099999',
//                             joinDate: 'Ngày tham gia : 03/04/2024',
                           
                            
                           
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
//       bottomNavigationBar: AdverseReportNavBar(),
//     );
//   }
// }
