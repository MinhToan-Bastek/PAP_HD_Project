import 'package:flutter/material.dart';

class AttachmentChecklist extends StatefulWidget {
  final Map<String, dynamic> patientDetail;

  const AttachmentChecklist({Key? key, required this.patientDetail}) : super(key: key);

  @override
  _AttachmentChecklistState createState() => _AttachmentChecklistState();
}

class _AttachmentChecklistState extends State<AttachmentChecklist> {
  late bool _isCheckedM1;
  late bool _isCheckedM2;
  late bool _isCheckedCCCD;
  late bool _isCheckedHoSoBenhAn;
  late bool _isCheckedContactLog;
  late bool _isCheckedADR;

  @override
  void initState() {
    super.initState();
    _initializeCheckboxAndRadioStates();
  }

  void _initializeCheckboxAndRadioStates() {
    setState(() {
      _isCheckedM1 = widget.patientDetail['Check_M1'] == "1";
      _isCheckedM2 = widget.patientDetail['Check_M2'] == "1";
      _isCheckedCCCD = widget.patientDetail['Check_CCCD'] == "1";
      _isCheckedHoSoBenhAn = widget.patientDetail['Check_HoSoBenhAn'] == "1";
      _isCheckedContactLog = widget.patientDetail['Check_ContactLog'] == "1";
      _isCheckedADR = widget.patientDetail['Check_ADR'] == "1";
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
              _buildCheckbox(width, 'M1', _isCheckedM1, (value) => _isCheckedM1 = value),
              _buildCheckbox(width, 'M2', _isCheckedM2, (value) => _isCheckedM2 = value),
              _buildCheckbox(width, 'CCCD', _isCheckedCCCD, (value) => _isCheckedCCCD = value),
              _buildCheckbox(width, 'Hồ sơ bệnh án', _isCheckedHoSoBenhAn, (value) => _isCheckedHoSoBenhAn = value),
              _buildCheckbox(width, 'Contact log', _isCheckedContactLog, (value) => _isCheckedContactLog = value),
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
          _buildRadio(width, 'Có', true, _isCheckedADR, (value) => _isCheckedADR = value),
          _buildRadio(width, 'Không', false, _isCheckedADR, (value) => _isCheckedADR = value),
        ],
      ),
    );
  }

  Widget _buildCheckbox(double width, String title, bool isChecked, Function(bool) onChanged) {
    return Container(
      width: width,
      child: CheckboxListTile(
        title: Text(title),
        value: isChecked,
        onChanged: (value) => setState(() => onChanged(value!)),
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: EdgeInsets.zero,
        activeColor: Colors.teal,
       
      ),
    );
  }

  Widget _buildRadio(double width, String title, bool value, bool groupValue, Function(bool) onChanged) {
    return Container(
      width: width,
      child: RadioListTile<bool>(
        title: Text(title),
        value: value,
        groupValue: groupValue,
        onChanged: (value) => setState(() => onChanged(value!)),
        activeColor: Colors.teal,
          contentPadding: EdgeInsets.symmetric(horizontal: 4),
      ),
    );
  }
}
