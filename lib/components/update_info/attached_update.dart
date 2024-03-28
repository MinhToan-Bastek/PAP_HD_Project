import 'package:flutter/material.dart';

class AttachedUpdate extends StatefulWidget {
  @override
  _AttachedUpdateState createState() =>
      _AttachedUpdateState();
}

class _AttachedUpdateState extends State<AttachedUpdate> {
  Map<String, bool>? checkedItems;
  int? selectedADR;

  @override
  void initState() {
    super.initState();
    checkedItems = {
      'M7': true,
      'Toa thuốc hỗ trợ': true,
      'Hóa đơn chứng từ mua thuốc trước đó': false,
    };
    selectedADR = 0;
  }

  @override
  Widget build(BuildContext context) {
    // Kiểm tra null trước khi sử dụng
    selectedADR ??= 0;
    checkedItems ??= {};

    return Container(
      padding: EdgeInsets.all(16),
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
          SizedBox(height: 8),
          Row(
            children: [
              _buildCheckboxTile('M7', checkedItems!['M7']!),
              SizedBox(width: 119),
              _buildCheckboxTile('Toa thuốc hỗ trợ', checkedItems!['Toa thuốc hỗ trợ']!),
            ],
          ),    
              _buildCheckboxTile('Hóa đơn chứng từ mua thuốc trước đó', checkedItems!['Hóa đơn chứng từ mua thuốc trước đó']!),
                 
         
          SizedBox(height: 10),
          Text(
            'Thông tin ADR',
            style: TextStyle(
              color: Colors.teal,
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildRadioTile('Có', 0),
              ),
              Expanded(
                child: _buildRadioTile('Không', 1),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxTile(String title, bool isChecked) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: Colors.teal,
      ),
      child: Row(
        children: [
          Checkbox(
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                checkedItems![title] = value!;
              });
            },
            activeColor: Colors.teal,
          ),
           Text(
            title,
            style: TextStyle(fontSize: 16), // Sử dụng fontSize cho chữ
          ),
        ],
      ),
    );
  }

  Widget _buildRadioTile(String title, int value) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: Colors.teal,
      ),
      child: Row(
        children: [
          Radio<int>(
            value: value,
            groupValue: selectedADR,
            onChanged: (int? newValue) {
              setState(() {
                selectedADR = newValue;
              });
            },
            activeColor: Colors.teal,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 16), // Sử dụng fontSize cho chữ
          ),
        ],
      ),
    );
  }
}
