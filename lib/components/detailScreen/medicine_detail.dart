import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class MedicineDetails {
  final String patientCount;
  final String participationCount;
  final String participationStopCount;
  final DateTime? dateStart;
  final DateTime? dateFinish;
  final String inStock;
  final String expected;
  final String available;

  MedicineDetails({
    required this.patientCount,
    required this.participationCount,
    required this.participationStopCount,
    this.dateStart,
    this.dateFinish,
    required this.inStock,
    required this.expected,
    required this.available,
  });

  //FormatDate từ API
  static DateTime? tryParseDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return null;
    }

    try {
      // Thử định dạng phổ biến trước
      final DateFormat formatter = DateFormat("M/d/yyyy hh:mm:ss a");
      return formatter.parseLoose(dateString);
    } catch (e) {
      print("Ngày không hợp lệ: $dateString - Lỗi: $e");
      return null;
    }
  }

  factory MedicineDetails.fromJson(Map<String, dynamic> json) {
    return MedicineDetails(
      patientCount: json['SoLuongBenhNhan'],
      participationCount: json['SoLuongThamGia'],
      participationStopCount: json['SoLuongNgungChuongTrinh'],
      dateStart: tryParseDate(json['NgayBatDau']),
      dateFinish: tryParseDate(json['NgayKetThuc']),
      inStock: json['TongSoLuongTon'],
      expected: json['SoLuongDuocHoTro'],
      available: json['SoLuongConLai'],
    );
  }
}

class MedicineInfo extends StatefulWidget {
  final MedicineDetails details;

  const MedicineInfo({super.key, required this.details});
  @override
  State<MedicineInfo> createState() => _MedicineInfoState();
}

class _MedicineInfoState extends State<MedicineInfo> {
  @override
  Widget build(BuildContext context) {
    final String formattedStartDate = widget.details.dateStart != null
        ? DateFormat('dd/MM/yyyy').format(widget.details.dateStart!)
        : 'Unknown';

    final String formattedEndDate = widget.details.dateFinish != null
        ? DateFormat('dd/MM/yyyy').format(widget.details.dateFinish!)
        : 'Unknown';

    final String dateRange = '$formattedStartDate -> $formattedEndDate';
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(            
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), 
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 70,
              backgroundColor: Colors.white, 
              backgroundImage:
                  AssetImage('assets/detailScreen/img_medicine.png'),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${widget.details.patientCount} patients',
                  style: TextStyle(
                    color: Color(0xFF02665A),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '${widget.details.participationCount} đang tham gia,${widget.details.participationStopCount} dừng chương trình',
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  dateRange,
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 10),
                InfoLine(
                  svgAsset: 'assets/detailScreen/icon_instock.svg',
                  text: 'In Stock: ${widget.details.inStock}',
                  iconColor: Colors.black,
                  textColor: Colors.black,
                ),
                InfoLine(
                  svgAsset: 'assets/detailScreen/icon_expected.svg',
                  text: 'Expected: ${widget.details.expected}',
                  iconColor: Color(0xFF709505),
                  textColor: Colors.black,
                ),
                InfoLine(
                    svgAsset: 'assets/detailScreen/icon_available.svg',
                    text: 'Available: ${widget.details.available}',
                    iconColor: Color(0xFF025D3C),
                    textColor: Color(0xFF025D3C)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InfoLine extends StatelessWidget {
  final String svgAsset;
  final String text;
  final Color iconColor;
  final Color textColor;

  const InfoLine({
    Key? key,
    required this.svgAsset,
    required this.text,
    required this.iconColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(svgAsset, color: iconColor, height: 20, width: 20),
        SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(color: textColor), // Màu cho văn bản
        ),
      ],
    );
  }
}
