import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScrollableCardRow extends StatefulWidget {
  final Function(int) onTap;

  const ScrollableCardRow({Key? key, required this.onTap}) : super(key: key);

  @override
  _ScrollableCardRowState createState() => _ScrollableCardRowState();
}

class _ScrollableCardRowState extends State<ScrollableCardRow> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30.0, horizontal: 10),
      height: 130.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          buildCardWidget('1,258', 'Tổng cộng', 'assets/adverse_status/status_1.svg', 0),
          buildCardWidget('1,113', 'Xác nhận', 'assets/adverse_status/status_2.svg', 1),
          buildCardWidget('16', 'Xác nhận tạm thời', 'assets/adverse_status/status_3.svg', 2),
          buildCardWidget('129', 'Từ chối', 'assets/adverse_status/status_4.svg', 3),
          buildCardWidget('980', 'Báo cáo hãng', 'assets/adverse_status/status_5.svg', 4),
          // Add more cards as needed
        ],
      ),
    );
  }

  Widget buildCardWidget(String count, String label, String iconPath, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        widget.onTap(index);
      },
      child: Container(
        width: 160.0,
        child: Card(
          color: index == selectedIndex ? Color(0xFFB8F3E1) : Color(0xFFE0F2EF),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  count,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                SvgPicture.asset(
                  iconPath,
                  width: 20, // Điều chỉnh kích thước của hình ảnh SVG tại đây
                  height: 20,
                ),
                SizedBox(height: 8),
                Text(
                  label,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
