import 'package:flutter/material.dart';
import 'package:pap_hd/model/checkbox_provider.dart';
import 'package:pap_hd/model/checkbox_updateReExam.dart';
import 'package:provider/provider.dart';

class AttachedUpdate extends StatefulWidget {
  @override
  _AttachedUpdateState createState() =>
      _AttachedUpdateState();
}

class _AttachedUpdateState extends State<AttachedUpdate> {
  @override
  Widget build(BuildContext context) {
    final documentsData = Provider.of<DocumentsDataUpdate>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double padding = 16.0; // Adjust the padding if needed
    double spacing = 2.0; // Adjust the spacing if needed, smaller value will reduce space
    double width = (screenWidth - padding * 2 - spacing) / 2;

    return Container(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hồ sơ đính kèm bao gồm',
            style: TextStyle(
              color: Colors.teal,
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
          //SizedBox(height: padding),
          Wrap(
            spacing: spacing, // Adjust the horizontal spacing between checkboxes
            runSpacing: spacing/2, // Adjust the vertical spacing between rows of checkboxes
            children: documentsData.checkedItems.keys.map((key) {
              return Container(
                width: width,
                child: CheckboxListTile(
                  title: Text(key),
                  value: documentsData.checkedItems[key],
                  onChanged: (bool? value) {
                    documentsData.setCheckedItem(key, value!);
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.symmetric(horizontal: 4), // Reduce padding if needed
                   activeColor: Colors.teal,
                ),
              );
            }).toList(),
          ),
          SizedBox(height: padding),
          Text(
            'Thông tin ADR',
            style: TextStyle(
              color: Colors.teal,
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
          Wrap(
            spacing: spacing, // Adjust the horizontal spacing between radio buttons
            runSpacing: spacing, // Adjust the vertical spacing between rows of radio buttons
            children: List.generate(2, (index) {
              return Container(
                width: width,
                child: RadioListTile<int>(
                  title: Text(index == 0 ? 'Có' : 'Không'),
                  value: index,
                  groupValue: documentsData.selectedADR,
                  onChanged: (int? newValue) {
                    documentsData.setSelectedADR(newValue!);
                  },
                  activeColor: Colors.teal,
                   contentPadding: EdgeInsets.symmetric(horizontal: 4),
                ),
              );
            }),
          ),
           Text(
            'Tương tác bệnh nhân',
            style: TextStyle(
              color: Colors.teal,
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
          Wrap(
            spacing: spacing, 
            runSpacing: spacing, 
            children: List.generate(2, (index) {
              return Container(
                width: width,
                child: RadioListTile<int>(
                  title: Text(index == 0 ? 'Có' : 'Không'),
                  value: index,
                  groupValue: documentsData.selectedContactLog,
                  onChanged: (int? newValue) {
                    documentsData.setSelectedContaclog(newValue!);
                  },
                  activeColor: Colors.teal,
                   contentPadding: EdgeInsets.symmetric(horizontal: 4),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
  // Map<String, bool>? checkedItems;
  // int? selectedADR;

  // @override
  // void initState() {
  //   super.initState();
  //   checkedItems = {
  //     'M7': true,
  //     'Toa thuốc hỗ trợ': true,
  //     'Hóa đơn chứng từ mua thuốc trước đó': false,
  //   };
  //   selectedADR = 0;
  // }

  // @override
  // Widget build(BuildContext context) {
  //   // Kiểm tra null trước khi sử dụng
  //   selectedADR ??= 0;
  //   checkedItems ??= {};

  //   return Container(
  //     padding: EdgeInsets.all(16),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'Hồ sơ đính kèm bao gồm',
  //           style: TextStyle(
  //             color: Colors.teal,
  //             fontWeight: FontWeight.normal,
  //             fontSize: 16,
  //           ),
  //         ),
  //         SizedBox(height: 8),
  //         Row(
  //           children: [
  //             _buildCheckboxTile('M7', checkedItems!['M7']!),
  //             SizedBox(width: 119),
  //             _buildCheckboxTile('Toa thuốc hỗ trợ', checkedItems!['Toa thuốc hỗ trợ']!),
  //           ],
  //         ),    
  //             _buildCheckboxTile('Hóa đơn chứng từ mua thuốc trước đó', checkedItems!['Hóa đơn chứng từ mua thuốc trước đó']!),
                 
         
  //         SizedBox(height: 10),
  //         Text(
  //           'Thông tin ADR',
  //           style: TextStyle(
  //             color: Colors.teal,
  //             fontWeight: FontWeight.normal,
  //             fontSize: 16,
  //           ),
  //         ),
  //         Row(
  //           children: [
  //             Expanded(
  //               child: _buildRadioTile('Có', 0),
  //             ),
  //             Expanded(
  //               child: _buildRadioTile('Không', 1),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildCheckboxTile(String title, bool isChecked) {
  //   return Theme(
  //     data: ThemeData(
  //       unselectedWidgetColor: Colors.teal,
  //     ),
  //     child: Row(
  //       children: [
  //         Checkbox(
  //           value: isChecked,
  //           onChanged: (bool? value) {
  //             setState(() {
  //               checkedItems![title] = value!;
  //             });
  //           },
  //           activeColor: Colors.teal,
  //         ),
  //          Text(
  //           title,
  //           style: TextStyle(fontSize: 16), // Sử dụng fontSize cho chữ
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildRadioTile(String title, int value) {
  //   return Theme(
  //     data: ThemeData(
  //       unselectedWidgetColor: Colors.teal,
  //     ),
  //     child: Row(
  //       children: [
  //         Radio<int>(
  //           value: value,
  //           groupValue: selectedADR,
  //           onChanged: (int? newValue) {
  //             setState(() {
  //               selectedADR = newValue;
  //             });
  //           },
  //           activeColor: Colors.teal,
  //         ),
  //         Text(
  //           title,
  //           style: TextStyle(fontSize: 16), // Sử dụng fontSize cho chữ
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
