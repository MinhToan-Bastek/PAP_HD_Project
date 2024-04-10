import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchBarApprovedWidget extends StatefulWidget {
  final Map<String, dynamic> patientDetail;

  const SearchBarApprovedWidget({Key? key, required this.patientDetail}) : super(key: key);

  @override
  State<SearchBarApprovedWidget> createState() => _SearchBarApprovedWidgetState();
}

class _SearchBarApprovedWidgetState extends State<SearchBarApprovedWidget> {
 
  String formatDate(String dateString) {
    try {
    
      DateTime dateTime = DateFormat("M/d/yyyy h:mm:ss a").parse(dateString);
      
      return DateFormat('dd/MM/yyyy').format(dateTime);
    } catch (e) {
     
      return "Ngày không xác định";
    }
  }

  @override
  Widget build(BuildContext context) {
    String ngayDuocDuyetFormatted = widget.patientDetail['NgayDuocDuyet'] != null 
      ? formatDate(widget.patientDetail['NgayDuocDuyet']) 
      : 'Không rõ'; 

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              '', 
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Đã được duyệt',
                style: TextStyle(
                  color: Color(0xFF025D3C),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                ngayDuocDuyetFormatted, 
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
