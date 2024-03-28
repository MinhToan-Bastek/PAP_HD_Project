import 'package:flutter/material.dart';
import 'dart:async';

class SearchBarReExam extends StatefulWidget {
  @override
  _SearchBarReExamState createState() => _SearchBarReExamState();
}

class _SearchBarReExamState extends State<SearchBarReExam> {
  bool _isWaiting = false;

  @override
  void initState() {
    super.initState();
    // Bắt đầu một timer để liên tục thay đổi trạng thái của `_isWaiting`
    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        _isWaiting = !_isWaiting;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Tìm theo mã, tên, CCCD',
                hintStyle: TextStyle(fontSize: 14.0),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal, width: 2),
                ),
                suffixIcon: Padding(
                  padding: EdgeInsets.only(
                      top: 12.0), // Adjust the padding to move the icon down
                  child: Icon(Icons.search),
                ),
                contentPadding: EdgeInsets.only(top: 17),
              ),
              onSubmitted: (value) {
                // Hành động tìm kiếm khi bàn phím ấn "submit"
                print('User searched for: $value');
              },
            ),
          ),
          AnimatedDefaultTextStyle(
            duration: Duration(milliseconds: 500), // Thời gian animation
            style: TextStyle(
              color: _isWaiting
                  ? Color(0xFFB3830A)
                  : Colors.white, // Màu văn bản thay đổi
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            curve: Curves.easeInOut, // Loại animation
            child: Container(
              margin: EdgeInsets.only(
                  top: 10), // Điều chỉnh margin dưới của văn bản
              child: Text(
                'Đang chờ duyệt',
                textAlign: TextAlign.center, // Căn giữa văn bản
              ),
            ),
          ),
        ],
      ),
    );
  }
}
