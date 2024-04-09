import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

void showNotificationFlushbar(BuildContext context, String title, String body) {
  Flushbar(
    flushbarPosition: FlushbarPosition.TOP, // Hiển thị ở đầu trang
    titleText: Text(
      title,
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Colors.black, // Màu tiêu đề
      ),
    ),
    messageText: Text(
      body,
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.black, // Màu nội dung thông báo
      ),
    ),
    duration: Duration(seconds: 4), // Thời gian hiển thị thông báo
    margin: EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(24),
    backgroundColor: Color(0xFFE9F9F7)
  ).show(context);
}
