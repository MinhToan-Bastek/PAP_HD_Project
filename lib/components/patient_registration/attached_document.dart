
import 'package:flutter/material.dart';
import 'package:pap_hd/model/checkbox_provider.dart';
import 'package:provider/provider.dart';


class AttachedDocumentsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final documentsData = Provider.of<DocumentsData>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double padding = 16.0; // Adjust the padding if needed
    double spacing = 8.0; // Adjust the spacing if needed, smaller value will reduce space
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
          SizedBox(height: padding),
          Wrap(
            spacing: spacing, // Adjust the horizontal spacing between checkboxes
            runSpacing: spacing, // Adjust the vertical spacing between rows of checkboxes
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
        ],
      ),
    );
  }
}




// Chính
// class AttachedDocumentsSection extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Lấy dữ liệu từ Provider
//     final documentsData = Provider.of<DocumentsData>(context);

//     return Container(
//       padding: EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Hồ sơ đính kèm bao gồm',
//             style: TextStyle(
//               color: Colors.teal,
//               fontWeight: FontWeight.normal,
//               fontSize: 16,
//             ),
//           ),
//           SizedBox(height: 8),
//           ...documentsData.checkedItems.keys.map((String key) {
//             return _buildCheckboxTile(context, key, documentsData.checkedItems[key]!);
//           }).toList(),
//           SizedBox(height: 16),
//           Text(
//             'Thông tin ADR',
//             style: TextStyle(
//               color: Colors.teal,
//               fontWeight: FontWeight.normal,
//               fontSize: 16,
//             ),
//           ),
//           _buildRadioTile(context, 'Có', 0),
//           _buildRadioTile(context, 'Không', 1),
//         ],
//       ),
//     );
//   }

//   Widget _buildCheckboxTile(BuildContext context, String title, bool isChecked) {
//     return Theme(
//       data: ThemeData(unselectedWidgetColor: Colors.teal),
//       child: CheckboxListTile(
//         title: Text(title, style: TextStyle(fontSize: 16)),
//         value: isChecked,
//         onChanged: (bool? value) {
//           // Cập nhật state thông qua Provider
//           Provider.of<DocumentsData>(context, listen: false).setCheckedItem(title, value!);
//         },
//         activeColor: Colors.teal,
//         controlAffinity: ListTileControlAffinity.leading, // Đặt checkbox trước tiêu đề
//       ),
//     );
//   }

//   Widget _buildRadioTile(BuildContext context, String title, int value) {
//     final documentsData = Provider.of<DocumentsData>(context);
//     return ListTile(
//       title: Text(title, style: TextStyle(fontSize: 16)),
//       leading: Radio<int>(
//         value: value,
//         groupValue: documentsData.selectedADR,
//         onChanged: (int? newValue) {
//           // Cập nhật state thông qua Provider
//           Provider.of<DocumentsData>(context, listen: false).setSelectedADR(newValue!);
//         },
//         activeColor: Colors.teal,
//       ),
//     );
//   }
// }

