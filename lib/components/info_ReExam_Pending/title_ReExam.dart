import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pap_hd/pages/details.dart';
import 'package:pap_hd/pages/search.dart';

class TitleReExam extends StatelessWidget {
  const TitleReExam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, size: 40), // Biểu tượng của nút back
            onPressed: () {
             Navigator.pop(context);
            },
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: 16.0), // Thêm khoảng cách dưới chữ
                  child: Column(
                    children: [
                      Text(
                        'Chương trình Jakavi',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        'Thông tin tái khám',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/homeScreen/icon_menu.svg', // Đường dẫn đến file SVG
              height: 40, // Chiều cao của biểu tượng
            ),
            onPressed: () {
              // Logic mở menu hoặc navigation drawer
            },
          ),
        ],
      ),
    );
  }
}
