import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RejectStatus extends StatelessWidget {
  final String documentId;
  final String personName;
  final String detail;
  final String statusText;
  final String statusIconSvg;
  final IconData additionalIcon1;
  final Color statusColor;

  RejectStatus({
    required this.documentId,
    required this.personName,
    required this.detail,
    required this.statusText,
    required this.statusIconSvg,
    required this.additionalIcon1,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3), // Màu của bóng
                      spreadRadius: 2, // Độ lan rộng của bóng
                      blurRadius: 5, // Độ mờ của bóng
                      offset: Offset(0, 3), // Độ dịch chuyển của bóng
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      AssetImage('assets/patient_registration/doc3.png'),
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
                          documentId,
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
                          personName,
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
                            detail,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Status Icon and Text
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      statusIconSvg,
                      width: 16,
                      height: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      statusText,
                      style: TextStyle(color: Color(0xffD00202), fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Detail Text
          // Padding(
          //   padding: EdgeInsets.only(top: 8.0),
          //   child: Text(
          //     detail,
          //     maxLines: 1,
          //     overflow: TextOverflow.ellipsis,
          //     style: TextStyle(color: Colors.grey),
          //   ),
          // ),
          // Underline
          Padding(
            padding: EdgeInsets.only(top: 12.0), // Adjust padding for spacing
            child: Divider(
              color: Colors.teal,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
