import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class CalendarReExamBody extends StatefulWidget {
    final ValueChanged<bool> onToggle;

  CalendarReExamBody({required this.onToggle});
  @override
  _CalendarReExamBodyState createState() => _CalendarReExamBodyState();
}

class _CalendarReExamBodyState extends State<CalendarReExamBody> {
  final TextEditingController _joiningDateController = TextEditingController();
  final TextEditingController _appointmentDateController =
      TextEditingController();
      final TextEditingController _rememberDateController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  bool _isReminderOn = false;

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
          _buildReminderToggle(),
             if (_isReminderOn) ...[ // Kiểm tra nếu toggle nhắc nhở bật thì hiển thị ngày nhắc
            SizedBox(height: 5),
            _buildDateField('Ngày nhắc', _rememberDateController, true),
          ],
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

  // Widget _buildReminderToggle() {
  //   return InkWell(
  //     onTap: () {
  //       // Không cần thiết phải xử lý onTap tại đây nếu đã có onChanged trong Switch
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(vertical: 8.0),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(
  //             'Nhắc lịch tái khám',
  //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal),
  //           ),
  //           Switch(
  //             value: _isReminderOn,
  //             onChanged: (value) {
  //               setState(() {
  //                 _isReminderOn = value;
  //                 widget.onToggle(_isReminderOn); // Gọi callback để thông báo trạng thái mới cho widget cha
  //               });
  //             },
  //             activeColor: Colors.teal, // Màu của toggle khi được bật
  //             inactiveThumbColor: Colors.grey, // Sửa lại màu ở đây nếu muốn
  //              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                
        
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }


  Widget _buildReminderToggle() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Nhắc lịch tái khám',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal),
        ),
        SizedBox( // Đặt một khoảng trống giữa văn bản và LiteRollingSwitch
          width: 10, // Điều chỉnh kích thước của khoảng trống
        ),
        Transform.translate(
          offset: Offset(20, 0), // Điều chỉnh phép dịch chuyển sang phải
          child: Transform.scale(
            scale: 0.6, // Điều chỉnh tỉ lệ để làm cho LiteRollingSwitch nhỏ hơn
            child: LiteRollingSwitch(
              onTap: () {},
              onDoubleTap: () {},
              onSwipe: () {},
              onChanged: (bool position) {
                setState(() {
                  _isReminderOn = position;
                  widget.onToggle(_isReminderOn);
                });
              },
              value: _isReminderOn,
              textOn: "On",
              textOnColor: Colors.white,
              textOff: "Off",
              colorOn: Colors.teal,
              colorOff: Colors.redAccent,
              iconOn: Icons.done,
              iconOff: Icons.alarm_off,
              textSize: 16,
              width: 110,
            ),
          ),
        ),
      ],
    ),
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
