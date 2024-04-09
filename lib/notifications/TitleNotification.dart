import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class TitleNotification extends StatelessWidget {
  
  const TitleNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, size: 40), 
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
                      EdgeInsets.only(top: 4.0), 
                  child: Column(
                    children: [                     
                      Text(
                        'Thông báo mới',
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
              'assets/homeScreen/icon_menu.svg', 
              height: 40, 
            ),
            onPressed: () {
            
            },
          ),
        ],
      ),
    );
  }
}
