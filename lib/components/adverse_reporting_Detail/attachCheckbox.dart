import 'package:flutter/material.dart';

class AttachmentChecklistRpDetail extends StatefulWidget {
  final Map<String, dynamic> reportDetail;

  const AttachmentChecklistRpDetail({Key? key, required this.reportDetail})
      : super(key: key);

  @override
  _AttachmentChecklistRpDetailState createState() => _AttachmentChecklistRpDetailState();
}

class _AttachmentChecklistRpDetailState extends State<AttachmentChecklistRpDetail> {
  late bool _isCheckedADR;
  late bool _isCheckedContactLog;
  

  @override
  void initState() {
    super.initState();
    _initializeCheckboxAndRadioStates();
  }

  void _initializeCheckboxAndRadioStates() {
    setState(() {
      _isCheckedADR = widget.reportDetail['Check_ADR'] == "1";
      _isCheckedContactLog = widget.reportDetail['Check_ContactLog'] == "1";
     
    });
  }

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
                  width, 'ADR', _isCheckedADR, (value) => _isCheckedADR = value),
              _buildCheckbox(
                  width, 'ContactLog', _isCheckedContactLog, (value) => _isCheckedContactLog = value),
             
            ],
          ),
          // SizedBox(height: padding),
          // Text(
          //   'Thông tin ADR',
          //   style: TextStyle(
          //     color: Colors.teal,
          //     fontWeight: FontWeight.normal,
          //     fontSize: 16,
          //   ),
          // ),
          // SizedBox(height: padding),
          // Wrap(
          //   spacing: spacing, 
          //   runSpacing: spacing, 
          //   children: [
          //     _buildRadio(width, 'Có', true, _isCheckedADR,
          //         (value) => _isCheckedADR = value),
          //     _buildRadio(width, 'Không', false, _isCheckedADR,
          //         (value) => _isCheckedADR = value),
          //   ],
          // ),
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
