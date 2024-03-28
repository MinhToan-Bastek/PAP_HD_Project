import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pap_hd/pages/login.dart';

class Header extends StatelessWidget {
  Widget buildIconMenu(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Icon Menu Pressed");
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
        // Xử lý khi icon menu được nhấn
        // Đặt hành động bạn muốn thực hiện ở đây
      },
      child: Transform.translate(
        offset: Offset(-6.0, 0.0),
        child: IntrinsicWidth(
          child: SvgPicture.asset(
            'assets/homeScreen/icon_menu.svg',
            height: 40.0,
          ),
        ),
      ),
    );
  }

  Widget buildAvatar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Avatar Pressed");
        // Xử lý khi avatar được nhấn
        // Đặt hành động bạn muốn thực hiện ở đây
      },
      child: IntrinsicWidth(
        child: Transform.translate(
          offset: Offset(0.0, 4.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/homeScreen/header_avt.png'),
            radius: 20.0,
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
              buildIconMenu(context),
              SizedBox(width: 10.0),
              buildAvatar(context),
            ],
          ),
          SizedBox(height: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Hello Hitachi !',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Welcome to Hoang Duc PAP',
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
