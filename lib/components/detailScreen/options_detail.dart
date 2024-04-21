import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pap_hd/model/ListAdverseStatus.dart';
import 'package:pap_hd/model/ListPatient_CardScroll.dart';
import 'package:pap_hd/pages/adverse_reporting.dart';
import 'package:pap_hd/pages/adverse_status.dart';
import 'package:pap_hd/pages/approved_calendarReExam.dart';
import 'package:pap_hd/pages/list_patientDetail.dart';
import 'package:pap_hd/pages/patient_registration.dart';
import 'package:pap_hd/pages/update_info_patient.dart';
import 'package:pap_hd/services/api_service.dart';

class OptionsGrid extends StatefulWidget {
  final String maChuongTrinh;
  final String username;
  final String pid;
  final String name;
  final String tenChuongTrinh;
  OptionsGrid(
      {Key? key,
      required this.maChuongTrinh,
      required this.username,
      required this.pid,
      required this.name,
      required this.tenChuongTrinh})
      : super(key: key);

  @override
  State<OptionsGrid> createState() => _OptionsGridState();
}

class _OptionsGridState extends State<OptionsGrid> {
  void fetchAndNavigateToListPatients(BuildContext context) async {
    try {
      final response = await ApiService().fetchPatients(
        username: widget.username,
        status: -1,
        pageIndex: 1,
        pageSize: 5,
        sortColumn: "IdBenhNhan",
        sortDir: "asc",
      );

      if (response is Map<String, dynamic>) {
        List<dynamic> patientsJson = response['ListPatients'] ?? [];
        List<Patient> patientsList =
            patientsJson.map((json) => Patient.fromJson(json)).toList();

        PatientSummary summary = PatientSummary(
          total: response['TongCong'],
          confirmed: response['XacNhan'],
          temporaryConfirmed: response['XacNhanTamThoi'],
          rejected: response['TuChoi'],
          awaitingConfirmation: response['ChoXacNhan'],
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ListPatientDetail(
              tenChuongTrinh: widget.tenChuongTrinh,
              patientsList: patientsList,
              summary: summary,
              username: widget.username,
            ),
          ),
        );
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi khi tải danh sách bệnh nhân: $e')),
      );
    }
  }

  //Danh sách tình trạng biến cố bất lợi

  void fetchAndNavigateToListStatusAdverse(BuildContext context) async {
    try {
      final response = await ApiService().fetchStatusAdverse(
        username: widget.username,
        status: -1,
        pageIndex: 1,
        pageSize: 5,
        sortColumn: "Id",
        sortDir: "asc",
      );

      if (response is Map<String, dynamic>) {
        List<dynamic> patientsJson = response['ListADRReports'] ?? [];
        List<Adverse> patientsList =
            patientsJson.map((json) => Adverse.fromJson(json)).toList();

        PatientSummary summary = PatientSummary(
          total: response['TongCong'],
          confirmed: response['XacNhan'],
          temporaryConfirmed: response['XacNhanTamThoi'],
          rejected: response['TuChoi'],
          awaitingConfirmation: response['ChoXacNhan'],
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdverseStatus(
              tenChuongTrinh: widget.tenChuongTrinh,
              patientsList: patientsList,
              summary: summary,
              username: widget.username,
            ),
          ),
        );
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi khi tải danh sách bệnh nhân: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final options = [
      {
        'icon': 'assets/detailScreen/icon_work.svg',
        'label': 'Tình trạng công việc'
      },
      {
        'icon': 'assets/detailScreen/icon_patient.svg',
        'label': 'Đăng ký bệnh nhân',
        'screen': PatientRegistScreen(
            maChuongTrinh: widget.maChuongTrinh,
            username: widget.username,
            pid: widget.pid,
            name: widget.name,
            tenChuongTrinh: widget.tenChuongTrinh)
      },
      {
        'icon': 'assets/detailScreen/icon_approved.svg',
        'label': 'Xác nhận lịch tái khám',
        // 'screen': ApprovedCalendarReExam(
        //   tenChuongTrinh: widget.tenChuongTrinh,
        // )
      },
      {
        'icon': 'assets/detailScreen/icon_support.svg',
        'label': 'Cập nhật thông tin hỗ trợ',
        // 'screen': UpdateInfoPatient(
        //   tenChuongTrinh: widget.tenChuongTrinh,
        // )
      },
      {
        'icon': 'assets/detailScreen/icon_reportbl.svg',
        'label': 'Báo cáo biến cố bất lợi',
        // 'screen': AdverseReporting(
        //   tenChuongTrinh: widget.tenChuongTrinh,
        //   )
      },
      {
        'icon': 'assets/detailScreen/icon_infopati.svg',
        'label': 'Thông báo bệnh nhân ngừng chương trình',
      },
      {
        'iconData': CupertinoIcons.doc_text_search,
        'label': 'Báo cáo kiểm tra thuốc'
      },
      {
        'iconData': CupertinoIcons.exclamationmark_circle,
        'label': 'Tình trạng báo cáo biến cố bất lợi',
      },
      {
        'iconData': CupertinoIcons.book,
        'label': 'Danh sách bệnh nhân',
      },
    ];

    return Container(
      constraints: BoxConstraints(maxWidth: 380.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Color(0xFFE0F2EF),
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: options.length,
        itemBuilder: (context, index) {
          final option = options[index];
          return InkWell(
            //     onTap: () {
            //       // if (option['label'] == 'Danh sách bệnh nhân') {
            //       //   fetchAndNavigateToListPatients(context);
            //       // } else if (option.containsKey('screen')) {
            //       //   final screenWidget = option['screen'];
            //       //   if (screenWidget != null) {
            //       //     Navigator.push(
            //       //       context,
            //       //       MaterialPageRoute(
            //       //           builder: (context) => screenWidget as Widget),
            //       //     );
            //       //   }
            //       // }
            //        switch (option['label']) {
            //     case 'Danh sách bệnh nhân':
            //         fetchAndNavigateToListPatients(context);
            //         break;
            //     case 'Tình trạng báo cáo biến cố bất lợi':
            //         fetchAndNavigateToListStatusAdverse(context);
            //         break;
            //     default:
            //         // Handle other cases or provide a default action
            //         break;
            // }
            //       print("${option['label']} pressed");
            //     },
            onTap: () {
              switch (option['label']) {
                case 'Danh sách bệnh nhân':
                  fetchAndNavigateToListPatients(context);
                  break;
                case 'Tình trạng báo cáo biến cố bất lợi':
                  fetchAndNavigateToListStatusAdverse(context);
                  break;
                default:
                  // Check if the 'screen' key exists and contains a valid widget to navigate to
                  if (option.containsKey('screen') &&
                      option['screen'] is Widget) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => option['screen'] as Widget),
                    );
                  } else {
                    // Optionally, handle cases where there is no 'screen' defined or the definition is not valid
                    print(
                        'No screen defined for ${option['label']} or not a Widget');
                  }
                  break;
              }
              print("${option['label']} pressed");
            },

            child: OptionItem(
              iconAsset: option['icon'] as String?,
              iconData: option['iconData'] as IconData?,
              label: option['label'] as String,
            ),
          );
        },
      ),
    );
  }
}

class OptionItem extends StatelessWidget {
  final String? iconAsset;
  final String label;
  final IconData? iconData;

  const OptionItem({
    Key? key,
    this.iconAsset,
    required this.label,
    this.iconData, // Thêm tham số này
  })  : assert(iconAsset != null || iconData != null,
            'Cần cung cấp ít nhất một loại icon'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (iconAsset != null)
          SvgPicture.asset(
            iconAsset!,
            height: 30.0,
          )
        else if (iconData != null)
          Icon(
            iconData,
            size: 30.0,
          ),
        SizedBox(height: 8.0),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
