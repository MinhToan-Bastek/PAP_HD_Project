import 'package:flutter/material.dart';

class SearchBarApprovedWidget extends StatefulWidget {
  @override
  State<SearchBarApprovedWidget> createState() => _SearchBarApprovedWidgetState();
}

class _SearchBarApprovedWidgetState extends State<SearchBarApprovedWidget> {
  @override
  Widget build(BuildContext context) {
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
                '12/03/2024', // Here you should format the date properly
                style: TextStyle(
                  //color: Color(0xFF025D3C),
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
