import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class UpdateInfoBody extends StatefulWidget {
  @override
  _UpdateInfoBodyState createState() => _UpdateInfoBodyState();
}

class _UpdateInfoBodyState extends State<UpdateInfoBody> {
  final TextEditingController _joiningDateController = TextEditingController();
  final TextEditingController _appointmentDateController =
      TextEditingController();
  final TextEditingController _medicineBoxController = TextEditingController();
  final TextEditingController _supportiveMedicineBoxController =
      TextEditingController();
  final TextEditingController _emptyMedicineBoxController = TextEditingController();
  final TextEditingController _returnedMedicineBoxController = TextEditingController();
  final TextEditingController _lostMedicineBoxController = TextEditingController();
  
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  final RegExp _numericRegex = RegExp(r'^[0-9]*$'); // Chỉ cho phép nhập số

  @override
  void dispose() {
    _joiningDateController.dispose();
    _appointmentDateController.dispose();
    _medicineBoxController.dispose();
    _supportiveMedicineBoxController.dispose();
    _emptyMedicineBoxController.dispose();
    _returnedMedicineBoxController.dispose();
    _lostMedicineBoxController.dispose();
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
          _buildTextField('Họ & tên', false),
          SizedBox(
            height: 5,
          ),
          _buildTextField('CCCD', false),
          SizedBox(
            height: 5,
          ),
          _buildDateField('Ngày khám', _joiningDateController, true),
          SizedBox(
            height: 5,
          ),
          _buildDateField(
              'Ngày hẹn tái khám', _appointmentDateController, true),
          SizedBox(
            height: 15,
          ),
          Text(
            'Thuốc thương mại',
            style: TextStyle(fontSize: 16),
          ),
          Row(
            children: [
              Expanded(
                child: _buildTextField('Hàm lượng', true),
              ),
              SizedBox(width: 16), // Khoảng cách giữa hai widget
              Expanded(
                child: _buildNumericTextField('Số lượng (hộp)', _medicineBoxController, true),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),

          Text(
            'Thuốc hỗ trợ',
            style: TextStyle(fontSize: 16),
          ),
          Row(
            children: [
              Expanded(
                child: _buildTextField('Hàm lượng', true),
              ),
              SizedBox(width: 16), // Khoảng cách giữa hai widget
              Expanded(
                child: _buildNumericTextField('Số lượng (hộp)', _supportiveMedicineBoxController, true),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Vỉ vỏ thuốc rỗng',
            style: TextStyle(fontSize: 16),
          ),
          Row(
            children: [
              Expanded(
                child: _buildTextField('Hàm lượng', false),
              ),
              SizedBox(width: 16), // Khoảng cách giữa hai widget
              Expanded(
                child: _buildNumericTextField('Số lượng (hộp)', _emptyMedicineBoxController, false),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Thuốc trả lại',
            style: TextStyle(fontSize: 16),
          ),
          Row(
            children: [
              Expanded(
                child: _buildTextField('Hàm lượng', false),
              ),
              SizedBox(width: 16), // Khoảng cách giữa hai widget
              Expanded(
                child: _buildNumericTextField('Số lượng (hộp)', _returnedMedicineBoxController, false),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Thuốc thất lạc',
            style: TextStyle(fontSize: 16),
          ),
          Row(
            children: [
              Expanded(
                child: _buildTextField('Hàm lượng', false),
              ),
              SizedBox(width: 16), // Khoảng cách giữa hai widget
              Expanded(
                child: _buildNumericTextField('Số lượng (hộp)', _lostMedicineBoxController, false),
              ),
            ],
          ),

        ],
      ),
    );
  }

  Widget _buildTextField(String label, bool isRequired) {
    return TextFormField(
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
        // Chỉnh sửa content padding tại đây
      ),
    );
  }

  Widget _buildNumericTextField(String label, TextEditingController controller, bool isRequired) {
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
        enabledBorder: _enabledBorder(),
        focusedBorder: _focusedBorder(),
        contentPadding: EdgeInsets.only(top: 15),
        // Chỉnh sửa content padding tại đây
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*$'))], // nhập số
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
