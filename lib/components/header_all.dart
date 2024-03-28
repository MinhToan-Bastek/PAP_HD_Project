import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pap_hd/pages/home.dart';

class HeaderAll extends StatelessWidget {
  Widget buildBackIcon(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context); // Quay lại trang trước đó
      },
      child: Transform.translate(
        offset: Offset(-15.0, 0.0),
        child: IntrinsicWidth(
          child: IconButton(
            icon: SvgPicture.asset(
              'assets/detailScreen/icon_back.svg',
              height: 40.0,
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => HomeScreen(username: 'toancm',)),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildMenuIcon(BuildContext context) {
    return IntrinsicWidth(
      child: Transform.translate(
        offset: Offset(5.0, 2.0),
        child: GestureDetector(
          onTap: () {
            print("Menu Icon Pressed");
            // Xử lý khi icon menu được nhấn
            // Đặt hành động bạn muốn thực hiện ở đây
          },
          child: SvgPicture.asset(
            'assets/homeScreen/icon_menu.svg',
            height: 40.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              buildBackIcon(context),
              SizedBox(width: 10.0),
              buildMenuIcon(context),
            ],
          ),
        ],
      ),
    );
  }
}
