import 'package:flutter/material.dart';
import 'package:pap_hd/components/adverse_reporting/title_adverse_Reporting.dart';
import 'package:pap_hd/components/adverse_status/listbody_adverse_Status.dart';
import 'package:pap_hd/components/adverse_status/provisional_confirmation_status.dart';
import 'package:pap_hd/components/adverse_status/reject_status.dart';
import 'package:pap_hd/components/adverse_status/scroll_adverse_Status.dart';
import 'package:pap_hd/components/adverse_status/search_adverse_Status.dart';
import 'package:pap_hd/components/adverse_status/title_adverse_Status.dart';
import 'package:pap_hd/components/bottomNavBar/adverse_reportNavBar.dart';


class AdverseStatus extends StatefulWidget {
  final String tenChuongTrinh;

  const AdverseStatus({super.key, required this.tenChuongTrinh});
  @override
  State<AdverseStatus> createState() => _AdverseStatusState();
}

class _AdverseStatusState extends State<AdverseStatus> {
  bool showCustomListItem = true;
  bool showProvisionalConfirrm = true;
  bool showRejectStatus = true;

    @override
  void initState() {
    super.initState();
    // Hiển thị tất cả các widget khi trang được tải lần đầu
    showCustomListItem = true;
    showProvisionalConfirrm = true;
    showRejectStatus = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            // Ảnh nền cho toàn bộ màn hình
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/homeScreen/home_background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              TitleAdverseStatus(tenChuongTrinh: widget.tenChuongTrinh,), // Phần title không cuộn
              Expanded(
                child: SingleChildScrollView(
                  // Phần cuộn cho nội dung dưới title
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ScrollableCardRow(
                          onTap: (index) {
                            setState(() {
                              if (index == 0) {
                                // Nếu bấm vào ô "Tổng cộng", hiển thị tất cả widget
                                showCustomListItem = true;
                                showProvisionalConfirrm = true;
                                showRejectStatus = true;
                              } else if (index == 1) {
                                // Nếu bấm vào ô "Xác nhận", hiển thị widget CustomListItemWidget và ẩn các widget khác
                                showCustomListItem = true;
                                showProvisionalConfirrm = false;
                                showRejectStatus = false;
                              } else if (index == 2) {
                                // Nếu bấm vào ô "Xác nhận tạm thời", hiển thị widget ProvisionalConfirrm và ẩn các widget khác
                                showCustomListItem = false;
                                showProvisionalConfirrm = true;
                                showRejectStatus = false;
                              } else if (index == 3) {
                                // Nếu bấm vào ô "Từ chối", hiển thị widget RejectStatus và ẩn các widget khác
                                showCustomListItem = false;
                                showProvisionalConfirrm = false;
                                showRejectStatus = true;
                              }
                            });
                          },
                        ),
                        SearchAdverseStatus(),
                        SizedBox(height: 10,),
                        if (showCustomListItem)
                          CustomListItemWidget(
                            documentId: 'BCBL-001256',
                            personName: 'Nguyễn Văn Tuấn',
                            detail: 'Nguyên nhân dẫn đến phải thực hiện báo cáo là do nguyên nhân...',
                            statusText: 'Xác nhận',
                            statusColor: Color(0xFFD8F7EE),
                            additionalIcon1: Icons.info,
                            statusIconSvg: 'assets/adverse_status/status_2.svg',
                          ),
                        if (showProvisionalConfirrm)
                          ProvisionalConfirrm(
                            documentId: 'BCBL-001258',
                            personName: 'Trương Văn Bản',
                            detail: 'While Papua New Guineas leaders are good at rolling out the....',
                            statusText: 'Xác nhận tạm thời',
                            statusColor: Color(0xFFD8E2F7),
                            additionalIcon1: Icons.info,
                            statusIconSvg: 'assets/adverse_status/status_3.svg',
                          ),
                        if (showRejectStatus)
                          RejectStatus(
                            documentId: 'BCBL-001259',
                            personName: 'Lưu Quốc Việt',
                            detail: 'This week’s violence is a wake-up call for U.S and international...',
                            statusText: 'Từ chối',
                            statusColor: Color(0xFFF7D8D8),
                            additionalIcon1: Icons.info,
                            statusIconSvg: 'assets/adverse_status/status_4.svg',
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: AdverseReportNavBar(),
    );
  }
}
