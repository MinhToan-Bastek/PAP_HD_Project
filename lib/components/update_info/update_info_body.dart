import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pap_hd/components/patient_registration/info_patientRegis.dart';
import 'package:pap_hd/model/checkbox_provider.dart';
import 'package:pap_hd/model/checkbox_updateReExam.dart';
import 'package:pap_hd/model/documentImages_provider.dart';
import 'package:pap_hd/services/api_service.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class UpdateInfoBody extends StatefulWidget {
  final Map<String, dynamic> patientDetail;
  final String username;
  const UpdateInfoBody(
      {Key? key, required this.patientDetail, required this.username})
      : super(key: key);

  @override
  UpdateInfoBodyState createState() => UpdateInfoBodyState();
}

class UpdateInfoBodyState extends State<UpdateInfoBody> {
  bool _isFormValid = true;
  bool _medicineBoxValid = false;
  bool _medicineBoxQuantityValid = false;
  bool _appointmentDateValid = false;
  bool _isJoiningDateValid = false;
  bool _supportiveMedicineBoxValid = false;
  bool _supportiveMedicineBoxQuantityValid = false;

  final TextEditingController _joiningDateController = TextEditingController();
  final TextEditingController _appointmentDateController =
      TextEditingController();
  final TextEditingController _medicineBoxController = TextEditingController();
  final TextEditingController _supportiveMedicineBoxController =
      TextEditingController();
  final TextEditingController _emptyMedicineBoxController =
      TextEditingController();
  final TextEditingController _returnedMedicineBoxController =
      TextEditingController();
  final TextEditingController _lostMedicineBoxController =
      TextEditingController();

  final TextEditingController _medicineBoxQuantityController =
      TextEditingController();
  final TextEditingController _supportiveMedicineBoxQuantityController =
      TextEditingController();
  final TextEditingController _emptyMedicineBoxQuantityController =
      TextEditingController();
  final TextEditingController _returnedMedicineBoxQuantityController =
      TextEditingController();
  final TextEditingController _lostMedicineBoxQuantityController =
      TextEditingController();

  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  final RegExp _numericRegex = RegExp(r'^[0-9]*$');

  final TextEditingController _cccdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  // @override
  // void dispose() {
  //   _nameController.dispose();
  //   _cccdController.dispose();
  //   _joiningDateController.dispose();
  //   _appointmentDateController.dispose();
  //   _medicineBoxController.dispose();
  //   _supportiveMedicineBoxController.dispose();
  //   _emptyMedicineBoxController.dispose();
  //   _returnedMedicineBoxController.dispose();
  //   _lostMedicineBoxController.dispose();

  //   _medicineBoxQuantityController.dispose();
  //   _supportiveMedicineBoxQuantityController.dispose();
  //   _emptyMedicineBoxQuantityController.dispose();
  //   _returnedMedicineBoxQuantityController.dispose();
  //   _lostMedicineBoxQuantityController.dispose();
  //   super.dispose();
  // }

  @override
void dispose() {
  // Remove listeners before disposing
  _medicineBoxController.removeListener(_onMedicineBoxChanged);
  _medicineBoxQuantityController.removeListener(_onMedicineBoxQuantityChanged);
  _appointmentDateController.removeListener(_onAppointmentDateChanged);
  _joiningDateController.removeListener(_onJoiningDateChanged);
  _supportiveMedicineBoxController.removeListener(_onSupportiveMedicineBoxChanged);
  _supportiveMedicineBoxQuantityController.removeListener(_onSupportiveMedicineBoxQuantityChanged);
  // Dispose text controllers
  _nameController.dispose();
  _cccdController.dispose();
  _joiningDateController.dispose();
  _appointmentDateController.dispose();
  _medicineBoxController.dispose();
  _supportiveMedicineBoxController.dispose();
  _emptyMedicineBoxController.dispose();
  _returnedMedicineBoxController.dispose();
  _lostMedicineBoxController.dispose();
  _medicineBoxQuantityController.dispose();
  _supportiveMedicineBoxQuantityController.dispose();
  _emptyMedicineBoxQuantityController.dispose();
  _returnedMedicineBoxQuantityController.dispose();
  _lostMedicineBoxQuantityController.dispose();
  super.dispose();
}

void _onMedicineBoxChanged() {
  if (_medicineBoxController.text.isNotEmpty) {
    setState(() => _medicineBoxValid = true);
  }
}

void _onMedicineBoxQuantityChanged() {
  if (_medicineBoxQuantityController.text.isNotEmpty) {
    setState(() => _medicineBoxQuantityValid = true);
  }
}

void _onAppointmentDateChanged() {
  if (_appointmentDateController.text.isNotEmpty) {
    setState(() => _appointmentDateValid = true);
  }
}

void _onJoiningDateChanged() {
  if (_joiningDateController.text.isNotEmpty) {
    setState(() => _isJoiningDateValid = true);
  }
}

void _onSupportiveMedicineBoxChanged() {
  if (_supportiveMedicineBoxController.text.isNotEmpty) {
    setState(() => _supportiveMedicineBoxValid = true);
  }
}

void _onSupportiveMedicineBoxQuantityChanged() {
  if (_supportiveMedicineBoxQuantityController.text.isNotEmpty) {
    setState(() => _supportiveMedicineBoxQuantityValid = true);
  }
}


  @override
  void initState() {
    super.initState();
    _nameController.text = widget.patientDetail['TenBenhNhan'] ?? '';
    _cccdController.text = widget.patientDetail['CCCD'] ?? '';

     _medicineBoxController.addListener(() {
    if (_medicineBoxController.text.isNotEmpty) {
      setState(() => _medicineBoxValid = true);
    }
  });
    _medicineBoxQuantityController.addListener(() {
    if (_medicineBoxQuantityController.text.isNotEmpty) {
      setState(() => _medicineBoxQuantityValid = true);
    }
  });
   _appointmentDateController.addListener(() {
    if (_appointmentDateController.text.isNotEmpty) {
      setState(() => _appointmentDateValid = true);
    }
  });
  _joiningDateController.addListener(() {
    if (_joiningDateController.text.isNotEmpty) {
      setState(() => _isJoiningDateValid = true);
    }
  });
  _supportiveMedicineBoxController.addListener(() {
    if (_supportiveMedicineBoxController.text.isNotEmpty) {
      setState(() => _supportiveMedicineBoxValid = true);
    }
  });
  _supportiveMedicineBoxQuantityController.addListener(() {
    if (_supportiveMedicineBoxQuantityController.text.isNotEmpty) {
      setState(() => _supportiveMedicineBoxQuantityValid = true);
    }
  });
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
  //       controller.text = DateFormat('MM/dd/yyyy').format(pickedDate);
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
                        //Correctly format the date to "day/month/year"
                      // controller.text = DateFormat('dd/MM/yyyy').format(selectedDate);
                      // Navigator.pop(context); // Close the modal bottom sheet
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

  void updateReExamInfo() async {
    // Kiểm tra xem các trường đã được nhập hay chưa
    _medicineBoxValid = _medicineBoxController.text.isNotEmpty;
    _medicineBoxQuantityValid = _medicineBoxQuantityController.text.isNotEmpty;
    _appointmentDateValid = _appointmentDateController.text.isNotEmpty;
    _isJoiningDateValid = _joiningDateController.text.isNotEmpty;
    _supportiveMedicineBoxValid =
        _supportiveMedicineBoxController.text.isNotEmpty;
    _supportiveMedicineBoxQuantityValid =
        _supportiveMedicineBoxQuantityController.text.isNotEmpty;

    _isFormValid = _medicineBoxValid &&
        _medicineBoxQuantityValid &&
        _appointmentDateValid &&
        _isJoiningDateValid &&
        _supportiveMedicineBoxValid &&
        _supportiveMedicineBoxQuantityValid;

    if (!_isFormValid) {
      setState(() {}); // Cập nhật UI để hiển thị thông báo lỗi
      return;
    }

    // Lấy dữ liệu từ Provider hoặc từ nguồn dữ liệu khác
    final documentsData =
        Provider.of<DocumentsDataUpdate>(context, listen: false);
    final documentImagesProvider =
        Provider.of<DocumentImagesProvider>(context, listen: false);
    List<XFile?> documentImages = documentImagesProvider.documentImages;

    // Tạo Map chứa dữ liệu tái khám
    final Map<String, dynamic> patientDataUpdate = {
      "MaChuongTrinh": widget.patientDetail['MaChuongTrinh'],
      "MaBenhVien": widget.patientDetail['MaBenhVien'],
      "MaBenhNhan": widget.patientDetail['MaBenhNhan'],
      "NgayKham": _joiningDateController.text.trim(),
      "NgayHenTaiKham": _appointmentDateController.text.trim(),
      "ThuocThuongMaiHamLuong": _medicineBoxController.text.trim(),
      "ThuocThuongMaiSoLuong":
          int.tryParse(_medicineBoxQuantityController.text.trim()) ?? 0,
      "ThuocHoTroHamLuong": _supportiveMedicineBoxController.text.trim(),
      "ThuocHoTroSoLuong":
          int.tryParse(_supportiveMedicineBoxQuantityController.text.trim()) ??
              0,
      "VoThuocRongHamLuong": _emptyMedicineBoxController.text.trim(),
      "VoThuocRongSoLuong":
          double.tryParse(_emptyMedicineBoxQuantityController.text.trim()) ?? 0,
      "ThuocTraLaiHamLuong": _returnedMedicineBoxController.text.trim(),
      "ThuocTraLaiSoLuong":
          int.tryParse(_returnedMedicineBoxQuantityController.text.trim()) ?? 0,
      "ThuocThatLacHamLuong": _lostMedicineBoxController.text.trim(),
      "ThuocThatLacSoLuong":
          int.tryParse(_lostMedicineBoxQuantityController.text.trim()) ?? 0,
      "Check_M7": documentsData.checkedItems['M7']! ? "1" : "0",
      "Check_ToaThuocHoTro":
          documentsData.checkedItems['Toa thuốc hỗ trợ']! ? "1" : "0",
      "Check_HoaDonMuaNgoai":
          documentsData.checkedItems['Hóa đơn mua ngoài']! ? "1" : "0",
      "Check_ContactLog": documentsData.selectedContactLog == 0 ? "1" : "0",
      "Check_ADR": documentsData.selectedADR == 0 ? "1" : "0",
      "Username": widget.username,
    };

    // Thực hiện việc gửi dữ liệu cập nhật
    try {
      await ApiService().updateReExam(patientDataUpdate, documentImages);
      Provider.of<DocumentsDataUpdate>(context, listen: false).reset();
      Provider.of<DocumentImagesProvider>(context, listen: false).reset();
      Navigator.pop(context);
    } catch (e) {
      // Hiển thị thông báo lỗi
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi khi cập nhật thông tin tái khám: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextFieldNameCccd(
            controller: _nameController,
            label: 'Họ và tên',
            isRequired: false,
            fieldType: TextFieldType.text,
          ),
          SizedBox(height: 5),
          _buildTextFieldNameCccd(
            controller: _cccdController,
            label: 'CCCD',
            isRequired: false,
            fieldType: TextFieldType.cccd,
          ),
          SizedBox(height: 5),
          _buildDateField('Ngày khám', _joiningDateController, true),
          if (!_isFormValid && !_isJoiningDateValid)
            Text(
              'Vui lòng nhập ngày khám',
              style: TextStyle(color: Colors.red,fontSize: 12),
            ),
          SizedBox(height: 5),
          _buildDateField(
              'Ngày hẹn tái khám', _appointmentDateController, true),
          if (!_isFormValid && !_appointmentDateValid)
            Text(
              'Vui lòng nhập ngày hẹn tái khám',
              style: TextStyle(color: Colors.red,fontSize: 12),
            ),
          SizedBox(height: 30),
          Text('Thuốc thương mại', style: TextStyle(fontSize: 16)),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField('Hàm lượng', true, _medicineBoxController),
                    if (!_isFormValid && !_medicineBoxValid)
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0), // Điều chỉnh padding nếu cần
                        child: Text(
                          'Nhập hàm lượng',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildNumericTextField(
                        'Số lượng (hộp)', _medicineBoxQuantityController, true),
                    if (!_isFormValid && !_medicineBoxQuantityValid)
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0), // Điều chỉnh padding nếu cần
                        child: Text(
                          'Nhập số lượng',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Text('Thuốc hỗ trợ', style: TextStyle(fontSize: 16)),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField(
                        'Hàm lượng', true, _supportiveMedicineBoxController),
                    if (!_isFormValid && !_supportiveMedicineBoxValid)
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0), // Điều chỉnh padding nếu cần
                        child: Text(
                          'Nhập hàm lượng',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildNumericTextField('Số lượng (hộp)',
                        _supportiveMedicineBoxQuantityController, true),
                    if (!_isFormValid && !_supportiveMedicineBoxQuantityValid)
                       Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0), // Điều chỉnh padding nếu cần
                        child: Text(
                          'Nhập số lượng',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 30),
          Text('Vỉ vỏ thuốc rỗng', style: TextStyle(fontSize: 16)),
          Row(
            children: [
              Expanded(
                  child: _buildTextField(
                      'Hàm lượng', false, _emptyMedicineBoxController)),
              SizedBox(width: 16),
              Expanded(
                  child: _buildNumericTextField('Số lượng (hộp)',
                      _emptyMedicineBoxQuantityController, false)),
            ],
          ),
          SizedBox(height: 30),
          Text('Thuốc trả lại', style: TextStyle(fontSize: 16)),
          Row(
            children: [
              Expanded(
                  child: _buildTextField(
                      'Hàm lượng', false, _returnedMedicineBoxController)),
              SizedBox(width: 16),
              Expanded(
                  child: _buildNumericTextField('Số lượng (hộp)',
                      _returnedMedicineBoxQuantityController, false)),
            ],
          ),
          SizedBox(height: 30),
          Text('Thuốc thất lạc', style: TextStyle(fontSize: 16)),
          Row(
            children: [
              Expanded(
                  child: _buildTextField(
                      'Hàm lượng', false, _lostMedicineBoxController)),
              SizedBox(width: 16),
              Expanded(
                  child: _buildNumericTextField('Số lượng (hộp)',
                      _lostMedicineBoxQuantityController, false)),
            ],
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     updateReExamInfo();
          //   },
          //   child: Text('Cập nhật tái khám'),
          // ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      String label, bool isRequired, TextEditingController? controller) {
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
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9\s]+$')),
      ],
    );
  }

  // Widget _buildTextFieldNameCccd(
  //     {required TextEditingController controller,
  //     required String label,
  //     required bool isRequired}) {
  //   return TextFormField(
  //     controller: controller,
  //     decoration: InputDecoration(
  //       label: Text(label, style: TextStyle(color: Colors.teal, fontSize: 16)),
  //       suffixIcon:
  //           isRequired ? Icon(Icons.star, color: Colors.red, size: 20) : null,
  //       enabledBorder: _enabledBorder(),
  //       focusedBorder: _focusedBorder(),
  //       contentPadding: EdgeInsets.only(top: 15),
  //     ),
  //   );
  // }
  Widget _buildTextFieldNameCccd(
      {required TextEditingController controller,
      required String label,
      required bool isRequired,
      required TextFieldType fieldType}) {
    List<TextInputFormatter> inputFormatters = [];

    switch (fieldType) {
      case TextFieldType.text:
        inputFormatters
            .add(FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\s]+$')));
        break;
      case TextFieldType.phoneNumber:
        inputFormatters.add(FilteringTextInputFormatter.digitsOnly);
        break;
      case TextFieldType.cccd:
        inputFormatters
            .add(FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9]+$')));
        break;
    }

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
      ),
      inputFormatters: inputFormatters,
      keyboardType: fieldType == TextFieldType.phoneNumber
          ? TextInputType.phone
          : TextInputType.text,
    );
  }
//   Widget _buildTextFieldNameCccd(
//       {required TextEditingController controller,
//       required String label,
//       required bool isRequired}){
//   return TextFormField(
//     controller: controller,
//     decoration: InputDecoration(
//       label: RichText(
//         text: TextSpan(
//           text: label,
//           style: TextStyle(color: Colors.teal, fontSize: 16),
//           children: isRequired
//               ? [TextSpan(text: ' *', style: TextStyle(color: Colors.red, fontSize: 16))]
//               : [],
//         ),
//       ),
//       enabledBorder: _enabledBorder(),
//       focusedBorder: _focusedBorder(),
//       contentPadding: EdgeInsets.only(top: 15),
//     ),
//     inputFormatters: [
//       FilteringTextInputFormatter.allow(RegExp("[a-zA-Z\s]")), // Chỉ cho phép nhập chữ cái và khoảng trắng
//     ],
//   );
// }

  Widget _buildNumericTextField(
      String label, TextEditingController controller, bool isRequired) {
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
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*$'))],
    );
  }

  Widget _buildDateField(
      String label, TextEditingController controller, bool isRequired) {
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
          padding: EdgeInsets.only(top: 10.0),
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
