import 'package:flutter/material.dart';
import 'package:pap_hd/model/checkbox_provider.dart';
import 'package:pap_hd/model/checkbox_updateReExam.dart';
import 'package:pap_hd/services/api_service.dart';
import 'package:provider/provider.dart';

class AttachedPendingReExam extends StatefulWidget {
  final int idPhieuTaiKham;
  final String username;

  const AttachedPendingReExam(
      {super.key, required this.idPhieuTaiKham, required this.username});
  @override
  _AttachedPendingReExamState createState() => _AttachedPendingReExamState();
}

class _AttachedPendingReExamState extends State<AttachedPendingReExam> {
    bool _isCheckedADR = false;
  bool _isCheckedContactLog = false;
  bool _isCheckedM7 = false;
  bool _isCheckedToaThuocHoTro = false;
  bool _isCheckedHoaDonMuaNgoai = false;
  

  
  @override
  void initState() {
    super.initState();
    fetchInitialData();
  }

   Future<void> fetchInitialData() async {
    try {
      var apiResponse = await ApiService().getInforExaminationById(widget.username, widget.idPhieuTaiKham);
      if (apiResponse != null) {
        setState(() {
          _isCheckedADR = apiResponse['Check_ADR'] == '1';
          _isCheckedContactLog = apiResponse['Check_ContactLog'] == '1';
          _isCheckedM7 = apiResponse['Check_M7'] == '1';
          _isCheckedToaThuocHoTro = apiResponse['Check_ToaThuocHoTro'] == '1';
          _isCheckedHoaDonMuaNgoai = apiResponse['Check_HoaDonMuaNgoai'] == '1';
        });
      }
    } catch (e) {
      print("Failed to fetch data: $e");
      // Optionally set up a fallback state
      setState(() {
        _isCheckedADR = false;
        _isCheckedContactLog = false;
        _isCheckedM7 = false;
        _isCheckedToaThuocHoTro = false;
        _isCheckedHoaDonMuaNgoai = false;
      });
    }
  }

//   void fetchCheckAndRadioData() async {
//     try {
//       var apiResponse = await ApiService()
//           .getInforExaminationById(widget.username, widget.idPhieuTaiKham);
//       if (apiResponse != null) {
//         int selectedADR = int.parse(apiResponse['Check_ADR']);
//         int selectedContactLog = int.parse(apiResponse['Check_ContactLog']);
//         print("ADR Value from API: ${apiResponse['Check_ADR']}");
// print("Contact Log Value from API: ${apiResponse['Check_ContactLog']}");

//         Provider.of<DocumentsDataUpdate>(context, listen: false)
//             .setCheckedItem('M7', apiResponse['Check_M7'] == '1');
//         Provider.of<DocumentsDataUpdate>(context, listen: false).setCheckedItem(
//             'Toa Thuốc Hỗ Trợ', apiResponse['Check_ToaThuocHoTro'] == '1');
//         Provider.of<DocumentsDataUpdate>(context, listen: false).setCheckedItem(
//             'Hóa Đơn Mua Ngoài', apiResponse['Check_HoaDonMuaNgoai'] == '1');
//         Provider.of<DocumentsDataUpdate>(context, listen: false)
//             .setSelectedADR(selectedADR);
//         Provider.of<DocumentsDataUpdate>(context, listen: false)
//             .setSelectedContaclog(selectedContactLog);
//       }
//     } catch (e) {
//       print("Error fetching checkbox/radio info: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error fetching checkbox/radio info: $e')));
//     }
//   }

  // @override
  // Widget build(BuildContext context) {
  //   final documentsData = Provider.of<DocumentsDataUpdate>(context);
  //   double screenWidth = MediaQuery.of(context).size.width;
  //   double padding = 16.0; // Adjust the padding if needed
  //   double spacing =
  //       2.0; // Adjust the spacing if needed, smaller value will reduce space
  //   double width = (screenWidth - padding * 2 - spacing) / 2;

  //   return Container(
  //     padding: EdgeInsets.all(padding),
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
  //         //SizedBox(height: padding),
  //         Wrap(
  //           spacing:
  //               spacing, // Adjust the horizontal spacing between checkboxes
  //           runSpacing: spacing /
  //               2, // Adjust the vertical spacing between rows of checkboxes
  //           children: documentsData.checkedItems.keys.map((key) {
  //             return Container(
  //               width: width,
  //               child: IgnorePointer(
  //                 child: CheckboxListTile(
  //                   title: Text(key),
  //                   value: documentsData.checkedItems[key],
  //                   onChanged: (bool? value) {},
  //                   // onChanged: (bool? value) {
  //                   //   documentsData.setCheckedItem(key, value!);
  //                   // },
  //                   controlAffinity: ListTileControlAffinity.leading,
  //                   contentPadding: EdgeInsets.symmetric(
  //                       horizontal: 4), // Reduce padding if needed
  //                   activeColor: Colors.teal,
  //                 ),
  //               ),
  //             );
  //           }).toList(),
  //         ),
  //         SizedBox(height: padding),
  //         Text(
  //           'Thông tin ADR',
  //           style: TextStyle(
  //             color: Colors.teal,
  //             fontWeight: FontWeight.normal,
  //             fontSize: 16,
  //           ),
  //         ),
  //         Wrap(
  //           spacing:
  //               spacing, // Adjust the horizontal spacing between radio buttons
  //           runSpacing:
  //               spacing, // Adjust the vertical spacing between rows of radio buttons
  //           children: List.generate(2, (index) {
  //             return Container(
  //               width: width,
  //               child: IgnorePointer(
  //                 child: RadioListTile<int>(
  //                   title: Text(index == 0 ? 'Có' : 'Không'),
  //                   value: index,
  //                   groupValue: documentsData.selectedADR,
  //                   //onChanged: null,
  //                   onChanged: (int? newValue) {
  //                     documentsData.setSelectedADR(newValue!);
  //                   },
  //                   activeColor: Colors.teal,
  //                   contentPadding: EdgeInsets.symmetric(horizontal: 4),
  //                 ),
  //               ),
  //             );
  //           }),
  //         ),
  //         Text(
  //           'Tương tác bệnh nhân',
  //           style: TextStyle(
  //             color: Colors.teal,
  //             fontWeight: FontWeight.normal,
  //             fontSize: 16,
  //           ),
  //         ),
  //         Wrap(
  //           spacing: spacing,
  //           runSpacing: spacing,
  //           children: List.generate(2, (index) {
  //             return Container(
  //               width: width,
  //               child: IgnorePointer(
  //                 child: RadioListTile<int>(
  //                   title: Text(index == 0 ? 'Có' : 'Không'),
  //                   value: index,
  //                   groupValue: documentsData.selectedContactLog,
  //                   onChanged: (int? newValue) {
  //                     documentsData.setSelectedContaclog(newValue!);
  //                   },
  //                   activeColor: Colors.teal,
  //                   contentPadding: EdgeInsets.symmetric(horizontal: 4),
  //                 ),
  //               ),
  //             );
  //           }),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double padding = 12.0;
    double spacing = 8.0;
    double width = (screenWidth - padding * 2 - spacing * 2) / 2;

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
            spacing: spacing,
            runSpacing: spacing,
            children: [
              _buildCheckbox(
                  width, 'M7', _isCheckedM7, (value) => _isCheckedM7 = value),
              _buildCheckbox(
                  width, 'Toa thuốc hỗ trợ', _isCheckedToaThuocHoTro, (value) => _isCheckedToaThuocHoTro = value),
              _buildCheckbox(width, 'Hóa đơn mua ngoài', _isCheckedHoaDonMuaNgoai,
                  (value) => _isCheckedHoaDonMuaNgoai = value),            
            ],
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
          SizedBox(height: padding),
          Wrap(
            spacing: spacing, 
            runSpacing: spacing, 
            children: [
              _buildRadio(width, 'Có', true, _isCheckedADR,
                  (value) => _isCheckedADR = value),
              _buildRadio(width, 'Không', false, _isCheckedADR,
                  (value) => _isCheckedADR = value),
            ],
          ),

           SizedBox(height: padding),
          Text(
            'Tương tác bệnh nhân',
            style: TextStyle(
              color: Colors.teal,
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
          SizedBox(height: padding),
          Wrap(
            spacing: spacing, 
            runSpacing: spacing, 
            children: [
              _buildRadio(width, 'Có', true, _isCheckedContactLog,
                  (value) => _isCheckedContactLog = value),
              _buildRadio(width, 'Không', false, _isCheckedContactLog,
                  (value) => _isCheckedContactLog = value),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCheckbox(
      double width, String title, bool isChecked, Function(bool) onChanged) {
    return Container(
      width: width,
      child: IgnorePointer(
        child: CheckboxListTile(
          title: Text(title),
          value: isChecked,
          onChanged: (value) => setState(() => onChanged(value!)),
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
          activeColor: Colors.teal,
        ),
      ),
    );
  }

  Widget _buildRadio(double width, String title, bool value, bool groupValue,
      Function(bool) onChanged) {
    return Container(
      width: width,
      child: IgnorePointer(
        child: RadioListTile<bool>(
          title: Text(title),
          value: value,
          groupValue: groupValue,
          onChanged: (value) => setState(() => onChanged(value!)),
          activeColor: Colors.teal,
          contentPadding: EdgeInsets.symmetric(horizontal: 4),
        ),
      ),
    );
  }


}
