import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pap_hd/model/ListAdverseStatus.dart';
import 'package:pap_hd/model/ListPatient_CardScroll.dart';


class ScrollableCardRow extends StatefulWidget {
  final StatusSummary summary;
  final Function(int) onTap;

  const ScrollableCardRow({Key? key, required this.summary, required this.onTap}) : super(key: key);

  @override
  _ScrollableCardRowState createState() => _ScrollableCardRowState();
}

class _ScrollableCardRowState extends State<ScrollableCardRow> {
  // Thêm một danh sách mới để lưu trữ các status
final List<int> statusValues = [-1, 2, 1, 3, 0]; // Cập nhật giá trị status tương ứng

  int selectedIndex = 0;

  List<Map<String, dynamic>> getCardsData() {
    return [
      {
        "label": "Tổng cộng",
        "count": widget.summary.total.toString(),
        "iconPath": "assets/adverse_status/status_1.svg",
      },
      {
        "label": "Xác nhận",
        "count": widget.summary.confirmed.toString(),
        "iconPath": "assets/adverse_status/status_2.svg",
      },
      {
        "label": "Xác nhận tạm thời",
        "count": widget.summary.temporaryConfirmed.toString(),
        "iconPath": "assets/adverse_status/status_3.svg",
      },
      {
        "label": "Từ chối",
        "count": widget.summary.rejected.toString(),
        "iconPath": "assets/adverse_status/status_4.svg",
      },
      {
        "label": "Chờ xác nhận",
        "count": widget.summary.awaitingConfirmation.toString(),
        "iconPath": "assets/adverse_status/status_5.svg",
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> cardsData = getCardsData();

    return Container(
      height: 120.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cardsData.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onTap(statusValues[index]);
            },
            child: Container(
              width: 115.0,
              margin: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: selectedIndex == index ? Color(0xFFB8F3E1) : Color(0xFFE0F2EF),
                borderRadius: BorderRadius.circular(10),
                 boxShadow: selectedIndex == index ? [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 8, spreadRadius: 1)] : [],
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      cardsData[index]['count'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    SvgPicture.asset(
                      cardsData[index]['iconPath'],
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(height: 4),
                    Text(
                      cardsData[index]['label'],
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
