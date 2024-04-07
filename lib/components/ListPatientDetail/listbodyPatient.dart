import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomListPatient extends StatelessWidget {
  final String card;
  final String personName;
  final String telephone;
  final String joinDate;

  CustomListPatient({
    required this.card,
    required this.personName,
    required this.telephone,
    required this.joinDate,
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
                'assets/adverse_status/status_2.svg',
                width: 30, // Kích thước của biểu tượng SVG
                height: 30,
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
                          width: 20, // Thiết lập chiều rộng mong muốn
                          height: 20, // Thiết lập chiều cao mong muốn
                        ),
                        SizedBox(width: 8),
                        Text(
                          card,
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Spacer(),
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
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
