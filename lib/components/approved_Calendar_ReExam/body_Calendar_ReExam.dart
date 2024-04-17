import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:table_calendar/table_calendar.dart';

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

  // Future<void> _selectDate(
  //     BuildContext context, TextEditingController controller) async {
  //   final DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime(2101),
  //   );
  //   if (pickedDate != null) {
  //     setState(() {
  //       controller.text = _dateFormat.format(pickedDate);
  //     });
  //   }
  // }
  void _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime selectedDate = DateTime.now();

    // showModalBottomSheet returns a Future that completes when the bottom sheet is closed.
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              return Container(
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  children: [
                    TableCalendar(
                       locale: 'vi_VN',
                      //rowHeight: 40,
                      headerStyle: HeaderStyle(
                          formatButtonVisible: false, titleCentered: true),
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: DateTime.now(),
                      currentDay: DateTime.now(),
                      selectedDayPredicate: (day) {
                        return isSameDay(selectedDate, day);
                      },
                      calendarBuilders: CalendarBuilders(
                        dowBuilder: (context, day) {
                          if (day.weekday == DateTime.sunday) {
                            return Center(
                              child: Text(
                                'Ch nhật',
                                style: TextStyle(color: Colors.red),
                              ),
                            );
                          }
                        },
                        defaultBuilder: (context, day, focusedDay) {
                          if (day.weekday == DateTime.sunday) {
                            // Đối với các ngày Chủ nhật
                            return Center(
                              child: Text(
                                DateFormat('d').format(day),
                                style: TextStyle(color: Colors.red),
                              ),
                            );
                          } else {
                            // Đối với các ngày khác trong tuần
                            return Center(
                              child: Text(
                                DateFormat('d').format(day),
                              ),
                            );
                          }
                        },
                      ),
                      onDaySelected: (selectedDay, focusedDay) {
                        setModalState(() {
                          selectedDate = selectedDay;
                          //focusedDay = focusedDay;
                        });
                        // Directly set the date and close the modal when a day is selected
                        controller.text =
                            DateFormat('MM/dd/yyyy').format(selectedDate);
                        Navigator.pop(context); // Close the modal bottom sheet
                      },
                      onPageChanged: (focusedDay) {
                        // No need to call setState() here
                      },
                      calendarStyle: CalendarStyle(
                        weekendTextStyle: TextStyle(color: Colors.red),
                        selectedDecoration: BoxDecoration(
                          color: Colors.teal,
                          shape: BoxShape.circle,
                        ),
                        todayDecoration: BoxDecoration(
                          color: Colors.teal,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
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
              animationDuration: Duration(milliseconds: 300), // Tốc độ của Toggle
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
              textOn: "",
              textOnColor: Colors.white,
              textOff: "",
              colorOn: Colors.teal,
              colorOff: Colors.redAccent,
              iconOn: Icons.done,
              iconOff: CupertinoIcons.power, 
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
