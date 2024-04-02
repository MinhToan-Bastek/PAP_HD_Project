import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pap_hd/components/patient_registration/attachment_section.dart';
import 'package:pap_hd/model/checkbox_provider.dart';
import 'package:pap_hd/model/documentImages_provider.dart';
import 'package:pap_hd/services/api_service.dart';
import 'package:provider/provider.dart';



class PatientInfoForm extends StatefulWidget {
  final String maChuongTrinh;
  final String username;

  PatientInfoForm(
      {Key? key, required this.maChuongTrinh, required this.username})
      : super(key: key);
  @override
  _PatientInfoFormState createState() => _PatientInfoFormState();
}

class _PatientInfoFormState extends State<PatientInfoForm> {
  @override
  void initState() {
    super.initState();
    print('Username ở màn hình đăng ký bệnh nhân: ${widget.username}');
  }

  final TextEditingController _joiningDateController = TextEditingController();
  final TextEditingController _appointmentDateController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cccdController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

// Giả sử bạn có một danh sách bệnh viện lấy từ API
  List<String> hospitalList = [
    'Bệnh viện A',
    'Bệnh viện B'
  ]; // Danh sách này sẽ được cập nhật từ API
  String? selectedHospital; // Bệnh viện được chọn
  //List<XFile?> documentImages = [];


  @override
  void dispose() {
    _joiningDateController.dispose();
    _appointmentDateController.dispose();
    _nameController.dispose();
    _cccdController.dispose();
    _phoneController.dispose();
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
  void _submitPatientInfo() async {
    final documentsData = Provider.of<DocumentsData>(context, listen: false);
  final documentImagesProvider = Provider.of<DocumentImagesProvider>(context, listen: false);
  List<XFile?> documentImages = documentImagesProvider.documentImages;
    final Map<String, dynamic> patientData = {
      "MaChuongTrinh": widget.maChuongTrinh, // Ví dụ mã chương trình
      "MaBenhVien": selectedHospital ??
          "CS000134", // Mã bệnh viện được chọn hoặc giá trị mặc định
      "TenBenhNhan": _nameController.text.trim(),
      "CCCD": _cccdController.text.trim(),
      "SoDienThoai": _phoneController.text.trim(),
      "NgayThamGia": _joiningDateController.text.trim(),
      "NgayHenTaiKham": _appointmentDateController.text.trim(),
      "Check_M1": documentsData.checkedItems['M1']! ? "1" : "0",
      "Check_M2": documentsData.checkedItems['M2']! ? "1" : "0",
      "Check_CCCD": documentsData.checkedItems['CCCD']! ? "1" : "0",
      "Check_HoSoBenhAn":
          documentsData.checkedItems['Hồ sơ bệnh án']! ? "1" : "0",
      "Check_ContactLog":
          documentsData.checkedItems['Contact log']! ? "1" : "0",
      "Check_ADR": documentsData.selectedADR == 0 ? "1" : "0",
      "Username": widget.username,
      // Thêm các trường dữ liệu khác theo yêu cầu
    };
     for (var image in documentImages.where((element) => element != null)) {
    print("Hình ảnh: ${image!.path}, Kích thước: ${await image.length()} bytes");
    // Bạn cũng có thể hiển thị thông tin này trên UI nếu muốn
  }
    print("Thông tin bệnh nhân sẽ được gửi lên server:");
    print("MaChuongTrinh: ${patientData["MaChuongTrinh"]}");
    print("MaBenhVien: ${patientData["MaBenhVien"]}");
    print("TenBenhNhan: ${patientData["TenBenhNhan"]}");
    print("CCCD: ${patientData["CCCD"]}");
    print("SoDienThoai: ${patientData["SoDienThoai"]}");
    print("NgayThamGia: ${patientData["NgayThamGia"]}");
    print("NgayHenTaiKham: ${patientData["NgayHenTaiKham"]}");
    print("Check_M1: ${patientData["Check_M1"]}");
    print("Check_M2: ${patientData["Check_M2"]}");
    print("Check_CCCD: ${patientData["Check_CCCD"]}");
    print("Check_HoSoBenhAn: ${patientData["Check_HoSoBenhAn"]}");
    print("Check_ContactLog: ${patientData["Check_ContactLog"]}");
    print("Check_ADR: ${patientData["Check_ADR"]}");
    print("Username: ${patientData["Username"]}");
    try {
      await ApiService().postPatientData(patientData,documentImages);
      // Hiển thị thông báo thành công hoặc điều hướng
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Thông tin đã được gửi thành công')),
      );
    } catch (e) {
      // Hiển thị thông báo lỗi
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi khi gửi thông tin: $e')),
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
          _buildDropDown('Bệnh viện', hospitalList, true),
          SizedBox(
            height: 5,
          ),
          _buildTextField('Họ & tên', _nameController, true),
          SizedBox(height: 5),
          _buildTextField('CCCD', _cccdController, true),
          SizedBox(height: 5),
          _buildTextField('Số điện thoại', _phoneController, true),
          SizedBox(height: 5),
          _buildDateField('Ngày tham gia', _joiningDateController, true),
          SizedBox(
            height: 5,
          ),
          _buildDateField(
              'Ngày hẹn tái khám', _appointmentDateController, false),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitPatientInfo,
            child: Text('Gửi thông tin'),
          ),
        ],
      ),
    );
  }

  Widget _buildDropDown(String label, List<String> items, bool isRequired) {
    return DropdownButtonFormField<String>(
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
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(fontSize: 14), // Điều chỉnh kích thước chữ tại đây
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        // handle change
      },
    );
  }

  Widget _buildTextField(
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
