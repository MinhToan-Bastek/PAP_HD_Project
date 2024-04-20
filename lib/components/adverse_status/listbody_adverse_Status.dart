import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pap_hd/pages/adverse_reporting_detail.dart';
import 'package:pap_hd/services/api_service.dart';

class CustomListItemWidget extends StatefulWidget {
  final String ADRCode;
  final String personName;
  final String reportDate;
  final String reason;
  final int status;
   final int reportId;
   final String username;
   final String tenChuongTrinh;
  CustomListItemWidget({
    required this.ADRCode,
    required this.personName,
    required this.reportDate,
    required this.reason,
    required this.status,
    required this.reportId,
    required this.username, required this.tenChuongTrinh
    // required this.statusIconSvg,
    // required this.additionalIcon1,
    // required this.statusColor,
  });

  @override
  State<CustomListItemWidget> createState() => _CustomListItemWidgetState();
}

class _CustomListItemWidgetState extends State<CustomListItemWidget> {
  @override
  Widget build(BuildContext context) {
    //   Map<int, Map<String, dynamic>> statusMap = {
    //   0: {"path": 'assets/adverse_status/status_5.svg', "text": "Chờ xác nhận"},
    //   1: {"path": 'assets/adverse_status/status_3.svg', "text": "Xác nhận tạm thời"},
    //   2: {"path": 'assets/adverse_status/status_2.svg', "text": "Xác nhận"},
    //   3: {"path": 'assets/adverse_status/status_4.svg', "text": "Từ chối"},
    // };

    // // Tạo ra widget hiển thị icon trạng thái.
    // List<Widget> statusWidgets = [];
    // if (status == -1) {
    //   statusMap.forEach((key, value) {
    //     statusWidgets.add(Padding(
    //       padding: const EdgeInsets.only(right: 4),
    //       child: SvgPicture.asset(value['path'], width: 16, height: 16),
    //     ));
    //   });
    // } else {
    //   String statusIconPath = statusMap[status]?["path"] ?? 'assets/adverse_status/status_1.svg';
    //   statusWidgets.add(SvgPicture.asset(statusIconPath, width: 16, height: 16));
    // }
    String statusIconPath;
  switch (widget.status) {
      case 0:
        statusIconPath = 'assets/adverse_status/status_5.svg';
        break;
      case 1:
        statusIconPath = 'assets/adverse_status/status_3.svg';
        break;
      case 2:
        statusIconPath = 'assets/adverse_status/status_2.svg';
        break;
      case 3:
        statusIconPath = 'assets/adverse_status/status_4.svg';
        break;
      default:
        statusIconPath = 'assets/adverse_status/status_1.svg';
        break;
    }
    return InkWell(
      onTap: () async {
    try {
      final reportDetail = await ApiService().getADRReportById(widget.username, widget.reportId);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdverseReportingDetail(
            tenChuongTrinh: widget.tenChuongTrinh,
            reportDetail: reportDetail,
            username: widget.username,
          ),
        ),
      );
    } catch (e) {
      // Xử lý lỗi ở đây, ví dụ hiển thị thông báo
      print("Error fetching ADR report detail: $e");
    }
  },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Circle Avatar
                // Circle Avatar
                Container(
                  width: 60,
                  height: 60,
                  // decoration: BoxDecoration(
                  //   shape: BoxShape.circle,
                  //   boxShadow: [
                  //     BoxShadow(
                  //       color: Colors.black.withOpacity(0.3), // Màu của bóng
                  //       spreadRadius: 2, // Độ lan rộng của bóng
                  //       blurRadius: 5, // Độ mờ của bóng
                  //       offset: Offset(0, 3), // Độ dịch chuyển của bóng
                  //     ),
                  //   ],
                  // ),
                  child: SvgPicture.asset(
                  statusIconPath,
                  width: 25, 
                  height: 25,
                ),
                  alignment: Alignment.center,
                ),
    
                SizedBox(width: 12),
                // Document ID and Person Name
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/adverse_status/check.svg',
                            width: 26, // Thiết lập chiều rộng mong muốn
                            height: 26, // Thiết lập chiều cao mong muốn
                          ),
                          SizedBox(width: 8),
                          Text(
                            widget.ADRCode,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(
                            Icons.person_outlined,
                            color: Colors.grey,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            widget.personName,
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          SizedBox(width: 8),
                           SvgPicture.asset(
                            'assets/adverse_status/status_5.svg',
                            width: 20, // Thiết lập chiều rộng mong muốn
                            height: 20, // Thiết lập chiều cao mong muốn
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                           Icon(
                            Icons.calendar_month,
                            color: Colors.grey,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            widget.reportDate,
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.grey,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              widget.reason,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                        
                      ),
                    ],
                  ),
                ),
               // ...statusWidgets, 
              //  // Status Icon and Text
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                //   decoration: BoxDecoration(
                //     // color: statusColor,
                //     // borderRadius: BorderRadius.circular(5),
                //       color: Colors.grey[200],
                //     borderRadius: BorderRadius.circular(5),
                //   ),
                //   child: Row(
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       SvgPicture.asset(
                //         statusIconPath,
                //         width: 16,
                //         height: 16,
                //       ),
                //       SizedBox(width: 4),
                //       Text(
                //         statusText,
                //         style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),       
            Padding(
              padding: EdgeInsets.only(top: 12.0), // Adjust padding for spacing
              child: Divider(
                color: Colors.teal,
                thickness: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
