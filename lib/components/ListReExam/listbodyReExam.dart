import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class ListBodyReExam extends StatelessWidget {
  final String personName;
  //final String joinDate;
  final String appointmentDate;
  final String tinhTrang;
  ListBodyReExam({
    required this.personName,
    //required this.joinDate,
    required this.appointmentDate,
    required this.tinhTrang
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
              SvgPicture.asset(
                'assets/adverse_status/status_5.svg',
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
                    Text(
                      tinhTrang,
                      style:
                          TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                    ),
                    SizedBox(height: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row(
                        //   children: [
                        //     Icon(
                        //       Icons.calendar_month,
                        //       color: Colors.grey,
                        //       size: 14,
                        //     ),
                        //     Text(
                        //       'Ngày khám: ',
                        //       style: TextStyle(
                        //         color: Colors.grey,
                        //         fontWeight: FontWeight.normal,
                        //         fontSize: 12,
                        //       ),
                        //     ),
                        //     Text(
                        //       joinDate,
                        //       style: TextStyle(
                        //         color: Colors.grey,
                        //         fontWeight: FontWeight.normal,
                        //         fontSize: 12,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(height: 8,),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: Colors.grey,
                              size: 14,
                            ),
                            Text(
                              'Ngày hẹn tái khám: ',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              appointmentDate,
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                          ],
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
