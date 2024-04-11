import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class CustomListPatient extends StatelessWidget {
  final String card;
  final String personName;
  final String telephone;
  final String joinDate;
  final int status;

  CustomListPatient({
    required this.card,
    required this.personName,
    required this.telephone,
    required this.joinDate,
    required this.status
  });

  @override
  Widget build(BuildContext context) {
    String statusIconPath;
  switch (status) {
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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                statusIconPath,
                width: 25, 
                height: 25,
              ),

              SizedBox(width: 24),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      personName,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/adverse_status/id_card.svg',
                          width: 20, 
                          height: 20, 
                        ),
                        SizedBox(width: 8),
                        Text(
                          card,
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Spacer(),
                         Icon(
                          Icons.calendar_month,
                          color: Colors.grey,
                          size: 14,
                        ),
                        Text(
                          'Ngày tham gia:',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          joinDate,
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                              fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: Colors.grey,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            telephone,
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
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0), // Adjust padding for spacing
            child: Divider(
              color: Colors.teal,
              thickness: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
