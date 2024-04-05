import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PatientInfoSearch extends StatefulWidget {
   final Map<String, dynamic> patientDetail;

  const PatientInfoSearch({super.key, required this.patientDetail});
  @override
  _PatientInfoSearchState createState() => _PatientInfoSearchState();
}

class _PatientInfoSearchState extends State<PatientInfoSearch> {
  final TextEditingController _joiningDateController = TextEditingController();
  final TextEditingController _appointmentDateController =
      TextEditingController();
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  @override
void initState() {
  super.initState();
  
  if (widget.patientDetail['NgayThamGia'] != null) {
    DateTime joiningDate = DateFormat('dd/MM/yyyy').parse(widget.patientDetail['NgayThamGia']);
    _joiningDateController.text = _dateFormat.format(joiningDate);
  }
  
  if (widget.patientDetail['NgayHenTaiKham'] != null) {
    DateTime appointmentDate = DateFormat('dd/MM/yyyy').parse(widget.patientDetail['NgayHenTaiKham']);
    _appointmentDateController.text = _dateFormat.format(appointmentDate);
  }
}


  @override
  void dispose() {
    _joiningDateController.dispose();
    _appointmentDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        controller.text = _dateFormat.format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [        
          _buildReadOnlyTextField('Bệnh viện', widget.patientDetail['TenBenhVien'] ?? '',true),
          SizedBox(
            height: 5,
          ),
          _buildReadOnlyTextField('Họ & tên', widget.patientDetail['TenBenhNhan'] ?? '',true),
          SizedBox(
            height: 5,
          ),
          _buildReadOnlyTextField('CCCD', widget.patientDetail['CCCD'] ?? '',true),
          SizedBox(
            height: 5,
          ),
          _buildReadOnlyTextField('Số điện thoại', widget.patientDetail['SoDienThoai'] ?? '',true),
          SizedBox(
            height: 5,
          ),
           _buildReadOnlyTextField('Ngày tham gia', _joiningDateController.text,true),
          SizedBox(
            height: 5,
          ),
           _buildReadOnlyTextField('Ngày hẹn tái khám', _appointmentDateController.text,false),
               SizedBox(
            height: 5,
          ),
         
        ],
      ),
    );
  }
   Widget _buildReadOnlyTextField(String label, String value,bool isRequired) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        readOnly: true,
        initialValue: value,
        decoration: InputDecoration(
          label: RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(color: Colors.teal, fontSize: 16),
            children: isRequired
                ? [
                    TextSpan(
                        text: ' *',
                        style: TextStyle(color: Colors.red, fontSize: 16))
                  ]
                : [],
          ),
        ),
        enabledBorder: _enabledBorder(),
        focusedBorder: _focusedBorder(),
         contentPadding: EdgeInsets.only(top: 15),
        ),
      ),
    );
  }

  Widget _buildDateField(
    String label,
    TextEditingController controller,
    bool isRequired,
  ) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        label: RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(color: Colors.teal, fontSize: 16),
            children: isRequired
                ? [
                    TextSpan(
                        text: ' *',
                        style: TextStyle(color: Colors.red, fontSize: 16))
                  ]
                : [],
          ),
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.only(
              top: 10.0), // Thêm một khoảng trống phía trên icon
          child: IconButton(
            icon: Icon(Icons.calendar_month, color: Colors.teal),
            onPressed: () {
              _selectDate(context, controller);
            },
          ),
        ),
        enabledBorder: _enabledBorder(),
        focusedBorder: _focusedBorder(),
         contentPadding: EdgeInsets.only(top: 15),
      ),
      onTap: () {
        _selectDate(context, controller);
      },
    );
  }

  UnderlineInputBorder _enabledBorder() {
    return const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.teal),
    );
  }

  UnderlineInputBorder _focusedBorder() {
    return const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.teal, width: 2),
    );
  }
}
