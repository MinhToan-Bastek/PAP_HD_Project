import 'package:flutter/material.dart';

class AttachedDocumentsSection extends StatefulWidget {
  @override
  _AttachedDocumentsSectionState createState() =>
      _AttachedDocumentsSectionState();
}

class _AttachedDocumentsSectionState extends State<AttachedDocumentsSection> {
  Map<String, bool>? checkedItems;
  int? selectedADR;

  @override
  void initState() {
    super.initState();
    checkedItems = {
      'M1': true,
      'M2': false,
      'CCCD': false,
      'Hồ sơ bệnh án': false,
      'Catalog': true,
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
              _buildCheckboxTile('M1', checkedItems!['M1']!),
              SizedBox(width: 119),
              _buildCheckboxTile('M2', checkedItems!['M2']!),
            ],
          ),
          Row(
            children: [
              _buildCheckboxTile('CCCD', checkedItems!['CCCD']!),
               SizedBox(width: 100),
              _buildCheckboxTile(
                  'Hồ sơ bệnh án', checkedItems!['Hồ sơ bệnh án']!),
            ],
          ),
          Row(
            children: [
              _buildCheckboxTile('Catalog', checkedItems!['Catalog']!),
            ],
          ),
          SizedBox(height: 16),
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
