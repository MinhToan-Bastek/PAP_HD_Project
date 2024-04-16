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

class InfoReExamBodyPen extends StatefulWidget {
  final int idPhieuTaiKham;
  final String username;
  const InfoReExamBodyPen(
      {Key? key, required this.username, required this.idPhieuTaiKham})
      : super(key: key);

  @override
  InfoReExamBodyPenState createState() => InfoReExamBodyPenState();
}

class InfoReExamBodyPenState extends State<InfoReExamBodyPen> {
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

  // final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  // final RegExp _numericRegex = RegExp(r'^[0-9]*$');

  final TextEditingController _cccdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    fetchExaminationInfo();
  }

  void fetchExaminationInfo() async {
    try {
      var apiResponse = await ApiService()
          .getInforExaminationById(widget.username, widget.idPhieuTaiKham);
      if (apiResponse != null) {
        // Định dạng ngày nhận được từ API
        DateFormat inputFormat = DateFormat("M/d/yyyy hh:mm:ss a");
        // Định dạng ngày để hiển thị
        DateFormat outputFormat = DateFormat("dd/MM/yyyy");

        DateTime ngayKham = inputFormat.parse(apiResponse['NgayKham']);
        DateTime ngayHenTaiKham =
            inputFormat.parse(apiResponse['NgayHenTaiKham']);

        setState(() {
          _nameController.text = apiResponse['TenBenhNhan'] ?? '';
          _cccdController.text = apiResponse['CCCD'] ?? '';
          _joiningDateController.text = outputFormat.format(ngayKham);
          _appointmentDateController.text = outputFormat.format(ngayHenTaiKham);
          _medicineBoxController.text =
              apiResponse['ThuocThuongMaiHamLuong'] ?? '';
          _medicineBoxQuantityController.text =
              (double.parse(apiResponse['ThuocThuongMaiSoLuong'].toString()))
                  .toInt()
                  .toString();
          _supportiveMedicineBoxController.text =
              apiResponse['ThuocHoTroHamLuong'] ?? '';
          _supportiveMedicineBoxQuantityController.text =
              (double.parse(apiResponse['ThuocHoTroSoLuong'].toString()))
                  .toInt()
                  .toString();

          _emptyMedicineBoxController.text =
              apiResponse['VoThuocRongHamLuong'] ?? '';
          _emptyMedicineBoxQuantityController.text =
              (double.parse(apiResponse['VoThuocRongSoLuong'].toString()))
                  .toInt()
                  .toString();

          _returnedMedicineBoxController.text =
              apiResponse['ThuocTraLaiHamLuong'] ?? '';
          _returnedMedicineBoxQuantityController.text =
              (double.parse(apiResponse['ThuocTraLaiSoLuong'].toString()))
                  .toInt()
                  .toString();

          _lostMedicineBoxController.text =
              apiResponse['ThuocThatLacHamLuong'] ?? '';
          _lostMedicineBoxQuantityController.text =
              (double.parse(apiResponse['ThuocThatLacSoLuong'].toString()))
                  .toInt()
                  .toString();
        });
      }
    } catch (e) {
      print("Không thể lấy thông tin khám: $e");
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi khi lấy thông tin khám: $e')));
    }
  }

// void fetchExaminationInfo() async {
//     try {
//         var apiResponse = await ApiService().getInforExaminationById(widget.username, widget.idPhieuTaiKham);
//         // Assuming apiResponse is a Map<String, dynamic> that contains all the keys you'll use
//         _nameController.text = apiResponse['TenBenhNhan'] ?? '';
//         _cccdController.text = apiResponse['CCCD'] ?? '';
//         _joiningDateController.text = _dateFormat.format(DateTime.parse(apiResponse['NgayKham'])) ?? '';
//         _appointmentDateController.text = _dateFormat.format(DateTime.parse(apiResponse['NgayHenTaiKham'])) ?? '';
//         _medicineBoxController.text = apiResponse['ThuocThuongMaiHamLuong'] ?? '';
//         _medicineBoxQuantityController.text = apiResponse['ThuocThuongMaiSoLuong'].toString() ?? '';
//         _supportiveMedicineBoxController.text = apiResponse['ThuocHoTroHamLuong'] ?? '';
//         _supportiveMedicineBoxQuantityController.text = apiResponse['ThuocHoTroSoLuong'].toString() ?? '';
//         _emptyMedicineBoxController.text = apiResponse['VoThuocRongHamLuong'] ?? '';
//         _emptyMedicineBoxQuantityController.text = apiResponse['VoThuocRongSoLuong'].toString() ?? '';
//         _returnedMedicineBoxController.text = apiResponse['ThuocTraLaiHamLuong'] ?? '';
//         _returnedMedicineBoxQuantityController.text = apiResponse['ThuocTraLaiSoLuong'].toString() ?? '';
//         _lostMedicineBoxController.text = apiResponse['ThuocThatLacHamLuong'] ?? '';
//         _lostMedicineBoxQuantityController.text = apiResponse['ThuocThatLacSoLuong'].toString() ?? '';
//     } catch (e) {
//         print("Failed to fetch examination info: $e");
//         ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Error fetching examination info: $e'))
//         );
//     }
// }

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

          SizedBox(height: 5),
          _buildDateField(
              'Ngày hẹn tái khám', _appointmentDateController, true),

          SizedBox(height: 30),
          Text('Thuốc thương mại', style: TextStyle(fontSize: 16)),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField('Hàm lượng', true, _medicineBoxController),
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
       readOnly: true,
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
       readOnly: true,
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
       readOnly: true,
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
       readOnly: true,
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
              //_selectDate(context, controller);
            },
          ),
        ),
        enabledBorder: _enabledBorder(),
        focusedBorder: _focusedBorder(),
        contentPadding: EdgeInsets.only(top: 15),
      ),
      onTap: () {
        //_selectDate(context, controller);
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
