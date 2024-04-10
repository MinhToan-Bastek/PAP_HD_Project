import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pap_hd/model/checkbox_provider.dart';
import 'package:pap_hd/model/checkbox_updateReExam.dart';
import 'package:pap_hd/model/documentImages_provider.dart';
import 'package:pap_hd/services/api_service.dart';
import 'package:provider/provider.dart';

class UpdateInfoBody extends StatefulWidget {
  
  final Map<String, dynamic> patientDetail;
  final String username;
  const UpdateInfoBody({Key? key, required this.patientDetail, required this.username})
      : super(key: key);

  @override
  UpdateInfoBodyState createState() => UpdateInfoBodyState();
}

class UpdateInfoBodyState extends State<UpdateInfoBody> {
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

final TextEditingController _medicineBoxQuantityController = TextEditingController();
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

  @override
  void dispose() {
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

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.patientDetail['TenBenhNhan'] ?? '';
    _cccdController.text = widget.patientDetail['CCCD'] ?? '';
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
    controller.text = DateFormat('MM/dd/yyyy').format(pickedDate);
  });
}
  }

  void updateReExamInfo() async {
    // Kiểm tra các trường dữ liệu đã nhập
    bool _isReExamDateValid = _joiningDateController.text.isNotEmpty;
    bool _isAppointmentDateValid = _appointmentDateController.text.isNotEmpty;
    bool _isThuocThuongMaiHamLuongValid =
        _medicineBoxController.text.isNotEmpty;
    // Thêm các kiểm tra cho các trường dữ liệu khác nếu cần

    bool _isFormValid = _isReExamDateValid &&
        _isAppointmentDateValid &&
        _isThuocThuongMaiHamLuongValid;
    // Thêm các trường khác vào _isFormValid nếu cần

    if (!_isFormValid) {
      setState(() {}); // Cập nhật UI để hiển thị thông báo lỗi
      return;
    }

    // Lấy dữ liệu từ Provider hoặc từ nguồn dữ liệu khác
    final documentsData = Provider.of<DocumentsDataUpdate>(context, listen: false);
    final documentImagesProvider =
        Provider.of<DocumentImagesProvider>(context, listen: false);
    List<XFile?> documentImages = documentImagesProvider.documentImages;

    // Tạo Map chứa dữ liệu tái khám
    final Map<String, dynamic> patientDataUpdate = {
      "MaChuongTrinh": widget.patientDetail['MaChuongTrinh'],
      "MaBenhVien": widget.patientDetail['MaBenhVien'],
      "MaBenhNhan":widget.patientDetail['MaBenhNhan'],
      "NgayKham": _joiningDateController.text.trim(),
      "NgayHenTaiKham": _appointmentDateController.text.trim(),
      "ThuocThuongMaiHamLuong": _medicineBoxController.text.trim(),
      "ThuocThuongMaiSoLuong":
          int.tryParse(_medicineBoxQuantityController.text.trim()) ?? 0,
      "ThuocHoTroHamLuong": _supportiveMedicineBoxController.text.trim(),
      "ThuocHoTroSoLuong":
          int.tryParse(_supportiveMedicineBoxQuantityController.text.trim()) ?? 0,
      "VoThuocRongHamLuong": _emptyMedicineBoxController.text.trim(),
      "VoThuocRongSoLuong":
          double.tryParse(_emptyMedicineBoxQuantityController.text.trim()) ?? 0,
      "ThuocTraLaiHamLuong": _returnedMedicineBoxController.text.trim(),
      "ThuocTraLaiSoLuong":
          int.tryParse(_returnedMedicineBoxQuantityController.text.trim()) ?? 0,
      "ThuocThatLacHamLuong": _lostMedicineBoxController.text.trim(),
      "ThuocThatLacSoLuong":
          int.tryParse(_lostMedicineBoxQuantityController.text.trim()) ?? 0,
         
      "Check_M7":  documentsData.checkedItems['M7']! ? "1" : "0",
      "Check_ToaThuocHoTro": documentsData.checkedItems['Toa thuốc hỗ trợ']! ? "1" : "0",
      "Check_HoaDonMuaNgoai": documentsData.checkedItems['Hóa đơn mua ngoài']! ? "1" : "0",
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
              label: 'Tên Bệnh Nhân',
              isRequired: false),
          SizedBox(height: 5),
          _buildTextFieldNameCccd(
              controller: _cccdController, label: 'CCCD', isRequired: false),
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
                  child: _buildTextField(
                      'Hàm lượng', true, _medicineBoxController)),
              SizedBox(width: 16),
              Expanded(
                  child: _buildNumericTextField(
                      'Số lượng (hộp)', _medicineBoxQuantityController, true)),
            ],
          ),
          SizedBox(height: 30),
          Text('Thuốc hỗ trợ', style: TextStyle(fontSize: 16)),
          Row(
            children: [
              Expanded(
                  child: _buildTextField(
                      'Hàm lượng', true, _supportiveMedicineBoxController)),
              SizedBox(width: 16),
              Expanded(
                  child: _buildNumericTextField('Số lượng (hộp)',
                      _supportiveMedicineBoxQuantityController, true)),
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
                  child: _buildNumericTextField(
                      'Số lượng (hộp)', _emptyMedicineBoxQuantityController, false)),
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
                  child: _buildNumericTextField(
                      'Số lượng (hộp)', _returnedMedicineBoxQuantityController, false)),
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
                  child: _buildNumericTextField(
                      'Số lượng (hộp)', _lostMedicineBoxQuantityController, false)),
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
    );
  }

  Widget _buildTextFieldNameCccd(
      {required TextEditingController controller,
      required String label,
      required bool isRequired}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(label, style: TextStyle(color: Colors.teal, fontSize: 16)),
        suffixIcon:
            isRequired ? Icon(Icons.star, color: Colors.red, size: 20) : null,
        enabledBorder: _enabledBorder(),
        focusedBorder: _focusedBorder(),
        contentPadding: EdgeInsets.only(top: 15),
      ),
    );
  }

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
