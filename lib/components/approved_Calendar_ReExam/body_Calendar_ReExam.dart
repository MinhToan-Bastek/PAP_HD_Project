import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:pap_hd/model/checkbox_createADR.dart';
import 'package:pap_hd/model/documentImages_provider.dart';
import 'package:pap_hd/services/api_service.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarReExamBody extends StatefulWidget {
    final ValueChanged<bool> onToggle;
      final Map<String, dynamic> examInfo;
      

  CalendarReExamBody(
    {Key? key, required this.onToggle, required this.examInfo})
      : super(key: key);
  @override
  CalendarReExamBodyState createState() => CalendarReExamBodyState();
}

class CalendarReExamBodyState extends State<CalendarReExamBody> {
   final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cccdController = TextEditingController();
  final TextEditingController _joiningDateController = TextEditingController();
  final TextEditingController _appointmentDateController =
      TextEditingController();
      final TextEditingController _rememberDateController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  bool _isReminderOn = false;

   @override
  void initState() {
    super.initState();
    // Initialize all controllers with data from examInfo
    _nameController.text = widget.examInfo['tenBenhNhan'] ?? '';
    _cccdController.text = widget.examInfo['cccd'] ?? '';
    _joiningDateController.text = widget.examInfo['ngayKham'] ?? '';
    _appointmentDateController.text = widget.examInfo['ngayHenTaiKham'] ?? '';
  }

 @override
  void dispose() {
    _nameController.dispose();
    _cccdController.dispose();
    _joiningDateController.dispose();
    _appointmentDateController.dispose();
    super.dispose();
  }

  void createAlertExamination() async {
    // Lấy dữ liệu từ Provider hoặc từ nguồn dữ liệu khác
    final documentsData =
        Provider.of<DocumentsDataCreateADR>(context, listen: false);
    final documentImagesProvider =
        Provider.of<DocumentImagesProvider>(context, listen: false);
    List<XFile?> documentImages = documentImagesProvider.documentImages;

    // Tạo Map chứa dữ liệu tái khám
    final Map<String, dynamic> createAlertExamData = {
      "MaChuongTrinh": widget.examInfo['maChuongTrinh'],
      "MaPhieu": widget.examInfo['maPhieu'],  

      "NgayNhacLich": _rememberDateController.text.trim(),  

       "Check_ADR": documentsData.checkedItems['ADR']! ? "1" : "0",
      "Check_ContactLog":
          documentsData.checkedItems['Contact log']! ? "1" : "0",
   
      "Username": widget.examInfo['username'],
      
    };

    // Thực hiện việc gửi dữ liệu cập nhật
    try {
      await ApiService().createAlertExamination(createAlertExamData, documentImages);
      Provider.of<DocumentsDataCreateADR>(context, listen: false).reset();
      Provider.of<DocumentImagesProvider>(context, listen: false).reset();
      Navigator.pop(context);
    } catch (e) {
      // Hiển thị thông báo lỗi
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi khi cập nhật thông tin tái khám: $e')),
      );
    }
  }
  void _selectDate(BuildContext context, TextEditingController controller) async {
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
                    locale: 'vi_VN', // Ensure locale is set for proper localization
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false, 
                      titleCentered: true
                    ),
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
                              'Chủ nhật',
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                        }
                      },
                      defaultBuilder: (context, day, focusedDay) {
                        if (day.weekday == DateTime.sunday) {
                          return Center(
                            child: Text(
                              DateFormat('d').format(day),
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                        } else {
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
                      });
                      // // Correctly format the date to "day/month/year"
                      // controller.text = DateFormat('dd/MM/yyyy').format(selectedDate);
                      // Navigator.pop(context); // Close the modal bottom sheet
                        controller.text =
                            DateFormat('MM/dd/yyyy').format(selectedDate);
                        Navigator.pop(context);
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

  // void _selectDate(
  //     BuildContext context, TextEditingController controller) async {
  //   DateTime selectedDate = DateTime.now();

  //   // showModalBottomSheet returns a Future that completes when the bottom sheet is closed.
  //   await showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return StatefulBuilder(
  //           builder: (BuildContext context, StateSetter setModalState) {
  //             return Container(
  //               height: MediaQuery.of(context).size.height / 2,
  //               child: Column(
  //                 children: [
  //                   TableCalendar(
  //                      locale: 'vi_VN',
  //                     //rowHeight: 40,
  //                     headerStyle: HeaderStyle(
  //                         formatButtonVisible: false, titleCentered: true),
  //                     firstDay: DateTime.utc(2010, 10, 16),
  //                     lastDay: DateTime.utc(2030, 3, 14),
  //                     focusedDay: DateTime.now(),
  //                     currentDay: DateTime.now(),
  //                     selectedDayPredicate: (day) {
  //                       return isSameDay(selectedDate, day);
  //                     },
  //                     calendarBuilders: CalendarBuilders(
  //                       dowBuilder: (context, day) {
  //                         if (day.weekday == DateTime.sunday) {
  //                           return Center(
  //                             child: Text(
  //                               'Ch nhật',
  //                               style: TextStyle(color: Colors.red),
  //                             ),
  //                           );
  //                         }
  //                       },
  //                       defaultBuilder: (context, day, focusedDay) {
  //                         if (day.weekday == DateTime.sunday) {
  //                           // Đối với các ngày Chủ nhật
  //                           return Center(
  //                             child: Text(
  //                               DateFormat('d').format(day),
  //                               style: TextStyle(color: Colors.red),
  //                             ),
  //                           );
  //                         } else {
  //                           // Đối với các ngày khác trong tuần
  //                           return Center(
  //                             child: Text(
  //                               DateFormat('d').format(day),
  //                             ),
  //                           );
  //                         }
  //                       },
  //                     ),
  //                     onDaySelected: (selectedDay, focusedDay) {
  //                       setModalState(() {
  //                         selectedDate = selectedDay;
  //                         //focusedDay = focusedDay;
  //                       });
  //                       // Directly set the date and close the modal when a day is selected
  //                       controller.text =
  //                           DateFormat('MM/dd/yyyy').format(selectedDate);
  //                       Navigator.pop(context); // Close the modal bottom sheet
  //                     },
  //                     onPageChanged: (focusedDay) {
  //                       // No need to call setState() here
  //                     },
  //                     calendarStyle: CalendarStyle(
  //                       weekendTextStyle: TextStyle(color: Colors.red),
  //                       selectedDecoration: BoxDecoration(
  //                         color: Colors.teal,
  //                         shape: BoxShape.circle,
  //                       ),
  //                       todayDecoration: BoxDecoration(
  //                         color: Colors.teal,
  //                         shape: BoxShape.circle,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             );
  //           },
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField('Họ & tên',false, _nameController, ),
          SizedBox(height: 5),
          _buildTextField('CCCD',false, _cccdController),
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
   

  Widget _buildTextField(String label, bool isRequired,TextEditingController controller) {
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
